import dash
from dash import dcc, html, dash_table
from dash.dependencies import Input, Output
import pandas as pd
import glob
import os
import datetime as dt
import numpy as np

app = dash.Dash(__name__)

# Liste des fichiers CSV à traiter
csv_files = ["AEX.csv", "BEL20.csv", "CAC40.csv", "ISEQ20.csv", "OBX.csv", "PSI.csv"]

app.layout = html.Div([
    html.H1("Dashboard Indices Européens", style={'textAlign': 'center', 'color': '#000000'}),
    dcc.Graph(id='time-series-relative'),
    html.H2("Daily Report", style={'textAlign': 'center', 'marginTop': '40px'}),
    html.Div(id='daily-report', style={'width': '90%', 'margin': 'auto'}),
    dcc.Interval(
        id='interval-component',
        interval=5 * 60 * 1000,  # toutes les 5 minutes
        n_intervals=0
    )
])

@app.callback(
    [Output('time-series-relative', 'figure'),
     Output('daily-report', 'children')],
    Input('interval-component', 'n_intervals')
)
def update_dashboard(n):

    # horaires ouverture/fermeture
    #AEL: 08:00-16:40
    #BEL20: 08:00-16:40
    #CAC40: 08:00-16:40
    #ISEQ20: 08:00-16:40
    #OBX: 08:00-15:30
    #PSI: 08:00-16:40

    traces_relative = []

    now = pd.Timestamp.now()
    today = now.normalize()

    # Date du rapport à afficher (hier si < 16h40, aujourd’hui si ≥ 1640)
    report_day = today if now.time() >= pd.to_datetime("16:40").time() else today - pd.Timedelta(days=1)
    report_filename = f"report_{report_day.date()}.csv"

    # Boucle sur chaque fichier pour les graphiques
    for file in csv_files:
        try:
            df = pd.read_csv(file, sep=';', header=None, names=['timestamp', 'price'])
            df['timestamp'] = pd.to_datetime(df['timestamp'])
            df['price'] = df['price'].astype(str).str.replace(',', '', regex=False).replace('N/A', None).astype(float)
            
            df = df.sort_values('timestamp')
            df['Date'] = df['timestamp'].dt.date

            # On garde seulement les jours ouvrés
            df = df[df['timestamp'].dt.weekday < 5]

            # On garde seulement les heures de cotation
            df = df[df['timestamp'].dt.time.between(pd.to_datetime("08:00").time(), pd.to_datetime("16:40").time())]

            # Affichage cumulatif depuis le premier jour
            P0 = df['price'].iloc[0]
            df['relative'] = df['price'] / P0

            name = file.replace('.csv', '')
            traces_relative.append({
                'x': df['timestamp'],
                'y': df['relative'],
                'type': 'line',
                'name': name
            })

        except Exception as e:
            print(f"Erreur avec le fichier {file} : {e}")
            continue

    # Graphique avec axe temporel segmenté
    fig_relative = {
        'data': traces_relative,
        'layout': {
            'title': 'Relative Indices Growth',
            'xaxis': {
                'title': 'Date',
                'type': 'date',
                'rangebreaks': [
                    # Cacher les weekends
                    {'pattern': 'day of week', 'bounds': [5, 1]},
                    # Cacher les heures de fermeture
                    {'pattern': 'hour', 'bounds': ['16:40', '08:00']}
                ]
            },
            'yaxis': {
                'title': 'Relative variation (%)',
                'tickformat': '.2f',
                'ticksuffix': '%'
            }
        }
    }

    # Daily report (affichage + création si besoin)
    if os.path.exists(report_filename):
        report_df = pd.read_csv(report_filename)
    elif now.time() >= pd.to_datetime("16:40").time() and report_day == today:
        # Crée le rapport du jour à 16h40
        report_data = []
        for file in csv_files:
            try:
                df = pd.read_csv(file, sep=';', header=None, names=['timestamp', 'price'])
                df['timestamp'] = pd.to_datetime(df['timestamp'])
                df['price'] = df['price'].astype(str).str.replace(',', '', regex=False).replace('N/A', None).astype(float)

                df = df[df['timestamp'].dt.normalize() == today]
                df = df[df['timestamp'].dt.weekday < 5]
                df = df[df['timestamp'].dt.time.between(pd.to_datetime("08:00").time(), pd.to_datetime("16:40").time())]

                name = file.replace('.csv', '')
                open_price = df['price'].iloc[0]
                close_price = df['price'].iloc[-1]
                change = close_price - open_price
                pct_change = ((close_price - open_price) / open_price) * 100

                report_data.append({
                    'Index': name,
                    'Open': round(open_price, 2),
                    'Close': round(close_price, 2),
                    'Change': round(change, 2),
                    'Change (%)': round(pct_change, 2),
                    'High': round(df['price'].max(), 2),
                    'Low': round(df['price'].min(), 2),
                    'Volatility': round(df['price'].std(), 2)
                })

            except Exception as e:
                print(f"Erreur génération rapport pour {file} : {e}")
                continue

        report_df = pd.DataFrame(report_data)
        report_df.to_csv(report_filename, index=False)
    else:
        report_df = None

    # Affichage du rapport
    if report_df is not None and not report_df.empty:
        report_table = dash_table.DataTable(
            columns=[{"name": i, "id": i} for i in report_df.columns],
            data=report_df.to_dict('records'),
            style_table={'overflowX': 'auto'},
            style_cell={'textAlign': 'center'},
            style_header={'fontWeight': 'bold'}
        )
    else:
        report_table = html.P("Le daily report sera disponible à 16h40.")

    print(traces_relative[0]['x'].min(), traces_relative[0]['x'].max())
    return fig_relative, report_table

server = app.server

if __name__ == '__main__':
    app.run_server(debug=True, host='0.0.0.0', port=8050)
