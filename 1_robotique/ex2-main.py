"""
Mathieu Jonin
21 Août 2025
Intro Robotique
"""

# All imports at the top of the code
from microbit import *
import music
import speech 

"""
Mon premier programme permettra de choisir quel projet on veut display sur le microbit
"""

p = 0 # p is the code that will execute if it is selected
OpChoosing = True; # it will stay true until we choose a program
op_length = 4;

while True:
    if OpChoosing:
        display.show(p)
        if button_b.get_presses():
            if p < op_length:
                p += 1;
            else :
                p = 0;
        if button_a.get_presses():
            if p > 0:
                p -= 1;
            else :
                p = op_length;

    if pin_logo.is_touched():
        OpChoosing = False;
        if p == 0:
            speech.say('Are-you-a-girl?? Are-you-a-boy?? Then-what-are-you???')
            music.play(music.NYAN)
            OpChoosing = True;
            sleep(1000)
        elif p == 1:
            speech.say('FUKK-U')
            OpChoosing = True;
            sleep(1000)
        elif p == 2:
            speech.say('PLEASE-HELP-ME')
            OpChoosing = True;
            sleep(1000)
        elif p == 3:
            display.show(Image.DUCK)
            OpChoosing = True;
            sleep(1000)
        elif p == 4:
            display.show(Image.SKULL)
            OpChoosing = True;
            sleep(1000)