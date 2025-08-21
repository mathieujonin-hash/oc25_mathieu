from microbit import *
import music

# Liste des notes et des durées approximatives de l'hymne de l'URSS
# Chaque note est suivie de la durée en millisecondes
melodie = [
    ('E5', 500), ('E5', 500), ('G5', 500), ('G5', 500), ('C6', 500), ('B5', 500), ('G5', 500), ('E5', 500),
    ('C5', 500), ('C5', 500), ('D5', 500), ('C5', 500), ('B4', 500),
    ('E5', 500), ('E5', 500), ('G5', 500), ('G5', 500), ('C6', 500), ('B5', 500), ('G5', 500), ('E5', 500),
    ('C5', 500), ('C5', 500), ('D5', 500), ('C5', 500), ('B4', 500)
]

# Fonction pour jouer la mélodie
def jouer_hymne():
    for note, duree in melodie:
        music.play(note, wait=True, loop=False)
        music.set_tempo(bpm=240)# tempo 240 pour un rythme rapide

project = 0;

# Boucle principale
while True:
    if button_a.is_pressed():
        music.play(music.NYAN)
    sleep(100)
