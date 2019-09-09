from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectMultipleField, widgets, SelectField
from wtforms.fields.html5 import DateTimeField, DateField
from wtforms.validators import DataRequired


class PumpForm(FlaskForm):
    payload = StringField('PumpID - Programmed payload on ESP8266')
    location = StringField('Indicated location')
    pumpsubmit = SubmitField('Add')


class RequestData(FlaskForm):
    topic = SelectField('Standardized Time', choices=[('hour', 'Hourly use'), ('day', 'Daily use'),
                                                      ('week', 'Weekly use'), ('month', 'Monthly use'), ('custom', 'Custom timerange')])
    date1 = DateField('Start Date')
    date2 = DateField('End Date')
    type = SelectField('Type of graph requested', choices=[('bar', 'Bar'), ('line', 'Line')]) # ('stack', 'Stack'),

    pump = SelectMultipleField('Select Pumps', coerce=str)

    requestsubmit = SubmitField('Request')


class RequestExport(FlaskForm):
    date1 = DateField('Start Date')
    date2 = DateField('End Date')

    requestsubmit = SubmitField('Request')
