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
Mon premier programme permet de choisir quel projet on veut display sur le microbit.
Ensuite, chaque programme (lorsqu'il est selectionné) fait quelque chose de différent.

0)  pointe une flèche vers le bas, si on appuie sur le bouton A la flèche pointe à gauche,
    pareil pour B mais vers la gauche et si les 2 boutons sont pressés en même temps, la
    flèche point en haut
    
1)  ouvre un menu pour voir tous les smileys disponible, A et B pour faire défiler respectivement
    à gauche et à droite
    
2)  recrée un meme très connu sur internet avec la musique de NyanCat à la fin

3)  recrée un meme très connu lui aussi

4)  fait défilé tous les animaux disponible sur microbit comme emoji

5)  fait une animation d'étoile qui "s'allume" et ensuite s'éteint

6)  fait apparaître les lettres "IDK" à la suite sans scroller 

7)  dit "1, 2, 3, compte avec moi" en anglais

8)  affiche le volume capté par le micro au moment d'appuyer

9)  affiche un stickman levant la main (imaginé par moi)

"""

p = 0 # p is the code that will execute if it is selected
op_length = 9;

s = 0;
smiley = 9;

OpChoosing = True; # it will stay true until we choose a program
last_touch = False


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

    touched = pin_logo.is_touched()
    if touched and not last_touch:  
        OpChoosing = not OpChoosing
    if not OpChoosing:
        
        if p == 0:
            while not OpChoosing:
                sleep(100)
                if pin_logo.is_touched():
                    OpChoosing = True
                    sleep(500)
                    break
                
                if button_b.is_pressed():
                    if button_a.is_pressed():
                        display.show(Image.ARROW_N)
                    else:
                        display.show(Image.ARROW_E)
                elif button_a.is_pressed():
                    display.show(Image.ARROW_W)
                else:
                    display.show(Image.ARROW_S)

        elif p == 1:
            while not OpChoosing:
                sleep(100)
                if pin_logo.is_touched():
                    OpChoosing = True
                    sleep(500)
                    break
        
                if button_b.get_presses():
                    if s < smiley:
                        s += 1
                    else:
                        s = 0
        
                if button_a.get_presses():
                    if s > 0:
                        s -= 1
                    else:
                        s = smiley
        
                if s == 0:
                    display.show(Image.ANGRY)
                elif s == 1:
                    display.show(Image.HAPPY)
                elif s == 2:
                    display.show(Image.SAD)
                elif s == 3:
                    display.show(Image.ASLEEP)
                elif s == 4:
                    display.show(Image.CONFUSED)
                elif s == 5:
                    display.show(Image.FABULOUS)
                elif s == 6:
                    display.show(Image.MEH)
                elif s == 7:
                    display.show(Image.SILLY)
                elif s == 8:
                    display.show(Image.SMILE)
                elif s == 9:
                    display.show(Image.SURPRISED)

                
        elif p == 2:
            speech.say('Ar-u-a-gurl?? No.. Ar-u-a-boi?? NO.. Then-what-ar-u???')
            music.play(music.NYAN)
            OpChoosing = True;
            sleep(100)
        elif p == 3:
            speech.say('Shee-said-she-wwas-twwailv')
            OpChoosing = True;
            sleep(100)
        elif p == 4:
            display.show(Image.BUTTERFLY)
            sleep(500)
            display.show(Image.COW)
            sleep(500)
            display.show(Image.DUCK)
            sleep(500)
            display.show(Image.GIRAFFE)
            sleep(500)
            display.show(Image.RABBIT)
            sleep(500)
            display.show(Image.SNAKE)
            sleep(500)
            display.show(Image.TORTOISE)
            sleep(500)
            OpChoosing = True;
        elif p == 5:
            sleep(500)
            display.show(Image(
                "00000:"
                "00000:"
                "00000:"
                "00000:"
                "00000"))
            sleep(500)
            display.show(Image(
                "00000:"
                "00900:"
                "09990:"
                "00900:"
                "00000"))
            sleep(500)
            display.show(Image(
                "00000:"
                "09990:"
                "09990:"
                "09990:"
                "00000"))
            sleep(500)
            display.show(Image(
                "90909:"
                "09990:"
                "99999:"
                "09990:"
                "90909"))
            sleep(500)
            display.show(Image(
                "00000:"
                "09990:"
                "09990:"
                "09990:"
                "00000"))
            sleep(500)
            display.show(Image(
                "00000:"
                "00900:"
                "09990:"
                "00900:"
                "00000"))
            sleep(500)
            display.show(Image(
                "00000:"
                "00000:"
                "00000:"
                "00000:"
                "00000"))
            sleep(500)
            OpChoosing = True;
        elif p == 6:
            display.show("IDK")
            OpChoosing = True;
        elif p == 7:
            speech.say("1, 2, 3. Count, with, me.")
            OpChoosing = True;
        elif p == 8:
            display.scroll(microphone.sound_level())
            OpChoosing = True;
        elif p == 9:
            display.show(Image(
                "90909:"
                "09990:"
                "00900:"
                "00900:"
                "09090:"))
            sleep(1000)
            OpChoosing = True;
            
    last_touch = touched
    sleep(50)