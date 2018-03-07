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
    print(f"PWM Period: {pwm_period}\nDuty Cycle: {duty_cycle}\nEnable: {enable}")
    if pwm_period and duty_cycle:
        return json.dumps({'html':'<span>PWM Period and Duty cycle fields good !!</span>'})
    else:
        return json.dumps({'html':'<span>Enter the required fields</span>'})


@app.route("/")
def main():
    return render_template('gui.html')


if __name__ == "__main__":
    app.run()
