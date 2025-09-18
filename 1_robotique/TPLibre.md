# Travail suivi 

## 16.09.25

* preparer plan de ce qu'on va faire

## 18.09.25 

* rajouté module "time_pulse_us" (permet de mesurer distances grace au echo)

  "from microbit import *
  from machine import time_pulse_us

  trigger = pin13
  echo = pin14

  trigger.write_digital(1)
  trigger.write_digital(0)
  distance = time_pulse_us()"
### controler
* # télécommande avec kitronik GAME controller
from microbit import *
import radio
import music

# choisissez comme groupe le numéro de votre kit (1-15)
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
