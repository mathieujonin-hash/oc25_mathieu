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

* 
