#!/usr/bin/env python
from flask import Flask, make_response, request
from sqlalchemy import create_engine

app = Flask(__name__)
engine = create_engine('postgresql://eventcaptureuser:postgres@localhost/event',
                       pool_size=25, max_overflow=0)

@app.route("/capture", methods=['POST'])
def capture():
    query = 'select insert_eventlog(%s, %s, %s, %s)'
    params = [request.form.get(p) for p in
              ['event_type', 'ext_ref', 'user_ref', 'data']]

    with engine.begin() as conn:
        try:
            conn.execution_options(autocommit=True).execute(query, params)
        except Exception as err:
            return make_response(err, 500)

    return make_response('', 200)


@app.route("/")
def home():
    return "It works!"


if __name__ == '__main__':
    app.run(port=3000, debug=True)
