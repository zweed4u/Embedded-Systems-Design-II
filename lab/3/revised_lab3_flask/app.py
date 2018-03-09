#!/usr/bin/python
# Zachary Weeden 2018

from flask import Flask
from flask import render_template
from flask import request
import json
from forms import GUIForm
from flask import flash
from flask import redirect
from flask import session
from lab3_logic import Lab3Logic

app = Flask(__name__)
app.config['SECRET_KEY'] = 'i-really-dont-care'

@app.route('/gui', methods=['GET', 'POST'])
def gui():
    form = GUIForm()
    if form.validate_on_submit():
        session['pwm_period'] = form.pwm_period.data
        session['duty_cycle'] = form.duty_cycle.data
        session['enable'] = form.enable.data
        flash('PWM period: {}, Duty Cycle: {}, Enable: {}'.format(form.pwm_period.data, form.duty_cycle.data, form.enable.data))
        return redirect('/submitted')
    return render_template('gui.html', title='Submit', form=form)
    #return render_template('gui.html')

@app.route("/submitted")
def submitted():
    print session['pwm_period'] 
    print session['duty_cycle']
    print session['enable']
    Lab3Logic(int(session['pwm_period']), int(session['duty_cycle']), session['enable'])
    return "Your update request has been submitted"


@app.route("/")
def main():
    return render_template('gui.html')


if __name__ == "__main__":
    os.system('cat system.bin > /dev/xdevcfg')
    app.run(host='0.0.0.0')
