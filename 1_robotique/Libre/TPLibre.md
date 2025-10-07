# Projet robotique
option complémentaire en informatique du gymnase Bugnon 

## Description

Dans ce projet nous programons le robot Kitronik MOVE

### Partie obligatoir

* commence le parcours à la position A
* va suivre une ligne
* va détecter un objet avec le capteur ultrason (position B variable)
* va attraper l'objet avec la pince
* va ramener l'objet à la position A

### Partie libre 

Possibilitées :
* 
* joue le refrain de *Porque Te Vas*

## 16.09.25

* preparer plan de ce qu'on va faire

## 18.09.25 

### time_pulse_us (permet de mesurer distances grace au echo)

```
from microbit import *
from machine import time_pulse_us

trigger = pin13
echo = pin14

trigger.write_digital(1)
trigger.write_digital(0)
distance = time_pulse_us(echo, 1)/2e6*340
display.scroll(str(round(distance)))
```

### Controler
```

from microbit import *
import radio
import music

g = 11
display.scroll(g)

radio.config(group=g)
radio.on()

VIB = pin1
BUZZER = pin2
UP = pin8
LEFT = pin12
RIGHT = pin13
DOWN = pin14
FIRE1 = pin15
FIRE2 = pin16

def vibrate(t):
    VIB.write_digital(1)
    sleep(t)
    VIB.write_digital(0)

msg = '0'   # le message à envoyer, juste une lettre

while True:
    if UP.read_digital() == 0:
        msg = 'u'
    
    elif LEFT.read_digital() == 0:
        msg = 'l'
             
    elif RIGHT.read_digital() == 0:
        msg = 'r'
        
    elif DOWN.read_digital() == 0:
        msg = 'd'

    elif FIRE1.read_digital() == 0:
        if msg == '0':
            music.pitch(440, 20, pin=BUZZER)
        msg = '1'
        
    elif FIRE2.read_digital() == 0:
        if msg == '0':
            vibrate(50)
        msg = '2'

    elif button_a.get_presses():
        msg = 'a'
        
    elif button_b.get_presses():
        msg = 'b'
        
    else:
        msg = '0'

    display.show(msg)

    radio.send(msg)
    sleep(100)
```
* Porque te vas :
```
porque_te_vas = ('g3:2','g3:1', 'f#3:1', 'g3:2', 'f#3:2', 'g3:2', 'a3:2', 'b3:2', 'g3:2',)
```

## 23.09.25

* Terminé porque te vas

```
porque_te_vas = ('g4:2','g4:1', 'f#4:1', 'g4:2', 'f#4:2', 'g4:2', 'f#4:2', 'g4:2', 'a4:2', 'bb4:2', 'g4:8', 
                 'g4:2', 'a4:2', 'bb4:2', 'd4:10', 'd4:2', 'f4:2', 'g4:2', 'd4:8',
                 'g4:2','g4:1', 'f#4:1', 'g4:2', 'f#4:2', 'g4:2', 'f#4:2', 'g4:2', 'a4:2', 'bb4:2', 'g4:8', 
                 'g4:2', 'a4:2', 'bb4:2', 'd4:10', 'bb3:2', 'c4:2', 'd4:2', 'g3:2')

```
## 25.09.25
* tentative de réaliser le plan pobligatoir

### Valeurs des couleurs (pour points A et B)

* noir : 225 - 274 -> ligne suivie 
*  : 275 - 325 -> point B
* bleu : 400 - 500 -> point A
* blanc : > 550 -> autour le parcours

## 02.10.25
* longueur du robot : 18 cm (stylo-pince) et 5 cm (stylo-yeux)
### Partie obligatoire:
```
"""
TP robot libre

Nom: Jonin Mathieu - Makeeva Nina
Classe: 3M1-3M6
Date: 16.09
No du robot: 11-10

Dans ce TP, il va falloir inventer un programme pour le robot
de manière à utiliser ce qu'on sait faire, il contient une
partie libre et une partie obligatoire
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

def distance():											#définir détection d'obstacle
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
        
    if prog == 0:								#utilisation de chaque fonctionnalité
        msg = radio.receive()					#pour tester que tout fonctionne
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
            
    if prog == 1:								#Partie obligatoire
        msg = radio.receive()
        d = distance()
        
        if msg:
            if msg == '1':
                follow = True

        if follow : 							#suivi de ligne
            left = pin1.read_analog()
            right = pin2.read_analog()
            s = (left - right) // 5 
            robot.move(20 - s, 20 + s) 
                
        if d < 5 and follow: 					#récupération de l'objet si vu
            follow = False
            robot.move(-75, -80, 1000)
            robot.move(75, -80, 900)
            robot.goToPosition(1, 160)
            sleep(250)
            robot.move(-75, -80, 1000)
            robot.goToPosition(1, 20)
            sleep(250)
            robot.move(75, -80, 900)
```
### Partie musique et chorégraphie (Libre)
```
if prog == 2 : 
        robot.goToPosition(1, 20)
        msg = radio.receive()
        if msg == '1':
            music.play(porque_te_vas, wait=False, loop=False)
            robot.move(-80,-80,1250)
            robot.goToPosition(1, 150)
            sleep(250)
            robot.goToPosition(1, 20)
            sleep(250)
            robot.goToPosition(1, 150)
            sleep(250)
            robot.goToPosition(1, 20)
            sleep(250)
            robot.goToPosition(1, 150)
            sleep(250)
        
            robot.move( 100, 100,1000)
            robot.goToPosition(1, 20)
            sleep(250)
            robot.goToPosition(1, 150)
            sleep(250)
            robot.goToPosition(1, 20)
            sleep(250)
           
            robot.move(-100,100,250)
            robot.move(100,-100,250)
            robot.move(-100,100,250)
            robot.move(75,-75,2400)
            robot.move(100,100,250)
            robot.move(-100,100,250)
            robot.move(100,-100,250)
            robot.move(-75,75,2400)

            robot.goToPosition(1, 150)
            sleep(500)
            robot.move(80,80,1250)
```
