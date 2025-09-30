"""
TP robot libre

Nom: Jonin Mathieu - Makeeva Nina
Classe: 3M1-3M6
Date: 16.09
No du robot: 11-10

Dans ce TP, il va falloir inventer un programme pour le robot
de manière à utiliser ce qu'on sait faire
"""

from microbit import *
import KitronikMOVEMotor
import music
import radio
import neopixel
import random
from machine import time_pulse_us

trigger = pin13
echo = pin14

def distance():
    trigger.write_digital(1)
    trigger.write_digital(0)
    d = time_pulse_us(echo, 1)/2e6*340*100
    return round(d)

robot = KitronikMOVEMotor.MOVEMotor()
robot.move(0, 0)
robot.goToPosition(1, 90)

# le group doit correspondre au kit (1..15)
g = 11
display.scroll(g)
radio.on()
radio.config(group=g)

prog = 0 
display.show(prog)
msg = radio.receive()

red = (100, 0, 0)
green = (0, 100, 0)
blue = (0, 0, 100)

yellow = (100, 100, 0)
cyan = (0, 100, 100)
magenta = (100, 0, 100)
orange = (100, 50, 0)

black = (0, 0, 0)
white = (100, 100, 100)

colors = (black, red, orange, yellow, green, cyan, blue, magenta, white)

np = neopixel.NeoPixel(pin8, 4)
# all variables
follow = False
collect = False
target = False

hexa = '0123456789ABCDEF'
v = 4 # vitesse actuelle


def avancer(d):
    # avancer ou reculer de d centimètres
    d0 = 10.3 # distance de calibration
    if d>0:
        robot.move(120, 120, 20)
        robot.move(60, 60, d/d0*1000)
    else:
        robot.move(-120, -120, 20)
        robot.move(-60, -60, -d/d0*1000)

def tourner(a):
    # pivoter un angle a degrés
    d = a / 140 * 1000
    if a>0:
        robot.move(120, -120, 10)
        robot.move(60, -60, d)
    else:
        robot.move(-120, 120, 10)
        robot.move(-60, 60, -d)

while True:
    if button_a.was_pressed():
        robot.move(0, 0)
        prog = (prog + 1) % 3
        display.show(prog)
        music.pitch(440, 20)
        
    if prog == 0:
        msg = radio.receive()
        if msg:
            display.show(msg)
            if msg == '0':
                robot.move(0, 0)
            elif msg == 'u':
                robot.move(75, 80)
            elif msg == 'r':
                robot.move(75, -80)
            elif msg == 'l':
                robot.move(-75, 80)
            elif msg == 'd':
                robot.move(-75, -80)
            elif msg == '2':
                robot.goToPosition(1, 20)
            elif msg == '1':
                robot.goToPosition(1, 160)
            elif msg == 'a':
                follow = False
                robot.move(0, 0)
            elif msg == 'b':
                follow = True
        print(str(pin1.read_analog()), str(pin2.read_analog()))
                
                
        if follow :
            left = pin1.read_analog()
            right = pin2.read_analog()
            d = (left - right)
            d = d // 10
            robot.move(10 - d, 10 + d)
            
    if prog == 1:
        msg = radio.receive()
        d = distance()
       
        if msg:
            if msg == '1':
                collect = True
            elif msg == '2':
                follow = False 
                robot.move(0, 0)

        if follow :
            if 300 < pin1.read_analog() < 400 and 300 < pin2.read_analog() < 400:
                    follow = False
                    collect = True
            else:
                left = pin1.read_analog()
                right = pin2.read_analog()
                s = (left - right) // 10 
                robot.move(10 - s, 10 + s) 
                
        if collect :
            if d < 20:
                target = True
                collect = False
            else :
                robot.move(40, -40)
                
        if target :
            robot.move(0, 0, 700)
            robot.move(75, -80, 900)
            robot.goToPosition(1, 160)
            sleep(200)
            robot.move(-75, -80, 1000)
            robot.goToPosition(1, 20)
            sleep(200)
            robot.move(75, 80, 1000)
            target = False

    if prog == 2:
        msg = radio.receive()

        if msg:
            if msg == '2':
                for i in range(3):
                    robot.goToPosition(1, 160)
                    sleep(250)
                    robot.goToPosition(1, 20)
                    sleep(250)