#!/usr/bin/python
# Zachary Weeden 2018
# Lab 3 Remote Frontend

import os
from flask import Flask
from flask import render_template
from forms import GUIForm
from flask import flash
from flask import redirect
from flask import session
from lab3_logic import Lab3Logic

app = Flask(__name__)
app.config['SECRET_KEY'] = 'esd-ii-lab-iii'


@app.route('/gui', methods=['GET', 'POST'])
def gui():
    """
    /gui - Form that allows users to specify pwm period, duty cycle and enable
    :return: /submitted - on successful POST, /gui - if fail
    """
    form = GUIForm()
    if form.validate_on_submit():
        # Extract data from form submission
        session['pwm_period'] = form.pwm_period.data
        session['duty_cycle'] = form.duty_cycle.data
        session['enable'] = form.enable.data
        # Use in base.html to display previous entries
        flash('PWM period: {}, Duty Cycle: {}, Enable: {}'.format(
            form.pwm_period.data, form.duty_cycle.data, form.enable.data))
        return redirect('/submitted')
    return render_template('/gui.html', title='Submit', form=form)


@app.route("/submitted")
def submitted():
    """
    /submitted - Landing page after successful form POST
    :return: str in webpage
    """
    print session['pwm_period']
    print session['duty_cycle']
    print session['enable']
    Lab3_Backend.set_all(int(session['pwm_period']),
                         int(session['duty_cycle']), session['enable'])
    return "Your update request has been submitted"


@app.route("/")
def main():
    """
    Redirect to /gui form
    :return: /gui
    """
    return redirect('/gui')


if __name__ == "__main__":
    os.system('cat system.bin > /dev/xdevcfg')
    Lab3_Backend = Lab3Logic(0, 0, False)
    app.run(host='0.0.0.0')
