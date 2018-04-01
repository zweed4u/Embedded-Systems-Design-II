#!/usr/bin/python
# Zachary Weeden 2018
# Lab 3 Remote Form

from flask_wtf import FlaskForm
from wtforms import IntegerField, BooleanField, SubmitField
from wtforms.validators import DataRequired


class GUIForm(FlaskForm):
    """
    Form elements used in Flask app form
    """
    pwm_period = IntegerField('PWM Period (ms): ', validators=[DataRequired()])
    duty_cycle = IntegerField('Duty Cycle (ms): ', validators=[DataRequired()])
    enable = BooleanField('Enable')
    submit = SubmitField('Submit')
