#!/usr/bin/python3

from flask_wtf import FlaskForm
from wtforms import IntegerField, RadioField, StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import DataRequired

class GUIForm(FlaskForm):
    pwm_period = IntegerField('PWM Period (ms): ', validators=[DataRequired()])
    duty_cycle = IntegerField('Duty Cycle (ms): ', validators=[DataRequired()])
    enable = BooleanField('Enable')
    submit = SubmitField('Submit')
