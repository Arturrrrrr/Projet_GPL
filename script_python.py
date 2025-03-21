import dash
from dash import dcc, html
from dash.dependencies import Input, Output
import pandas as pd
import time

app = dash.Dash(__name__)

app.layout = html.Div([
    html.H1("Dashboard CAC40"),
    dcc.Graph(id='time-series'),
    # Intervalle de rafraîchissement toutes les 5 minutes
    dcc.Interval(
        id='interval-component',
        interval=5*60*1000,  # 5 minutes en millisecondes
        n_intervals=0
    )
])

@app.callback(
    Output('time-series', 'figure'),
    Input('interval-component', 'n_intervals')
)
def update_graph(n):
    # On relit le CSV à chaque callback
    df = pd.read_csv("data_euronext.csv", sep=';', header=None, names=['timestamp','price'])
    df['timestamp'] = pd.to_datetime(df['timestamp'])
    df['price'] = df['price'].str.replace(',', '', regex=False).replace('N/A', None).astype(float)

    #test change

    fig = {
        'data': [{
            'x': df['timestamp'],
            'y': df['price'],
            'type': 'line',
            'name': 'CAC40 Price'
        }],
        'layout': {
            'title': 'CAC40 Price over time'
        }
    }
    return fig

server = app.server

if __name__ == '__main__':
    app.run_server(debug=True, host='0.0.0.0', port=8050)
