from app import create_app, db
from app.models import Pump, Trigger

app = create_app()


@app.shell_context_processor
def make_shell_context():
    return dict(db=db, Pump=Pump, Trigger=Trigger)

# def loopapp():
if __name__ == '__main__':
    app.run(host='127.0.0.1')
    # app.run(host='192.168.137.1')


