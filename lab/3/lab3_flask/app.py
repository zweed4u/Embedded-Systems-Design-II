#!/usr/bin/python3

from flask import Flask
from flask import render_template
from flask import request
import json
from forms import GUIForm
from flask import flash
from flask import redirect

app = Flask(__name__)
app.config['SECRET_KEY'] = 'i-really-dont-care'

@app.route('/gui', methods=['GET', 'POST'])
def gui():
    form = GUIForm()
    if form.validate_on_submit():
        flash('PWM period: {}, Duty Cycle: {}, Enable: {}'.format(form.pwm_period.data, form.duty_cycle.data, form.enable.data))
        return redirect('/submitted')
    return render_template('gui.html', title='Submit', form=form)
    #return render_template('gui.html')

@app.route("/submitted")
def submitted():
    return "Your update request has been submitted"

@app.route('/submit', methods=['POST'])
def submit():
    pwm_period = request.form['pwm_period']
    duty_cycle = request.form['duty_cycle']
    enable = request.form['enable']
    if int(duty_cycle) > int(pwm_period):
        return json.dumps({'html':'<span>Duty Cycle must be less than PWM Period</span>'})
    print(f"PWM Period: {pwm_period}ms\nDuty Cycle: {duty_cycle}ms\nEnable: {enable}")
    print(f"Duty Cycle %: {(float(duty_cycle)/float(pwm_period))*100.0}%")
    duty_sleep = float(duty_cycle)/float(1000)  # seconds
    period_sleep = float(pwm_period)/float(1000) - duty_sleep  # seconds
    print(f"Write pin high and sleep for {duty_sleep} seconds, toggle the pin low as duty cycle has bee fufilled and now sleep remainder of period {period_sleep} seconds")
    if pwm_period and duty_cycle:
        return json.dumps({'html':'<span>PWM Period and Duty cycle fields good !!</span>'})
    else:
        return json.dumps({'html':'<span>Enter the required fields</span>'})


@app.route("/")
def main():
    return render_template('gui.html')


if __name__ == "__main__":
    app.run()
