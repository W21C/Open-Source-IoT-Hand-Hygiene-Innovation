from . import db
import datetime
from sqlalchemy import DateTime


class Pump(db.Model):
    __tablename__ = 'pumps'
    id = db.Column(db.Integer, primary_key=True)
    payload = db.Column(db.String)
    location = db.Column(db.String)
    volt = db.Column(db.Integer)

    def __repr__(self):
        return str(self.payload)


class Trigger(db.Model):
    __tablename__ = 'trigger'
    id = db.Column(db.Integer, primary_key=True)
    datetime = db.Column(DateTime, default=datetime.datetime.now)
    pump = db.Column(db.String)

    def __repr__(self):
        return str(self.datetime)
