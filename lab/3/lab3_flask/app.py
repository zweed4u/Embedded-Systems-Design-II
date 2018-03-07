#!/usr/bin/python3

from flask import Flask
from flask import render_template
from flask import request
import json

app = Flask(__name__)

@app.route('/gui')
def gui():
    return render_template('gui.html')

@app.route('/submit', methods=['POST'])
def submit():
    pwm_period = request.form['pwm_period']
    duty_cycle = request.form['duty_cycle']
    enable = request.form['enable']
    print(f"PWM Period: {pwm_period}ns\nDuty Cycle: {duty_cycle}ns\nEnable: {enable}")
    print(f"Duty Cycle %: {(float(duty_cycle)/float(pwm_period))*100.0}%")
    duty_sleep = float(duty_cycle)/float(1000000000)  # seconds
    period_sleep = float(pwm_period)/float(1000000000) - duty_sleep  # seconds
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
