Prompt pour chatGPT :  
"Créer moi une image de 4 étudiants côte à côte qui doit pouvoir être publiée dans un article en ligne parlant d'eux. C'est une équipe qui a remporté le concours de math mais n'ajoute pas de gros trophé ou de gros prix."  
<img width="400" height="400" alt="image" src="/3_ia/generated-image-1.png" />  
Pour la deuxième image :  
"Peux-tu inverser les deux personnes sur la gauche ? Ne modifie rien d'autre, ni leur apparence, ni leurs vêtements, ni les objets qu'ils ont en main. Uniquement leur position."  
<img width="400" height="400" alt="image" src="/3_ia/ChatGPT Image 25 févr. 2026, 21_04_46.png" />  
"Tu n'as pas fait la modification que je t'ai demandée, recommence"  
<img width="400" height="400" alt="image" src="/3_ia/ChatGPT Image 25 févr. 2026, 21_05_08.png" />  
"Il y a 2 fois la même personne. Enlève le garçon au pull rouge du milieu et garde celuui de droite puis rapproche les deux personnes de gauche des deux personnes de droite"  
<img width="400" height="400" alt="image" src="/3_ia/ChatGPT Image 25 févr. 2026, 21_07_27.png" />  
"Tu en as enlever un de trop. Remet le garçon au pull rouge à gauche"  
<img width="400" height="400" alt="image" src="/3_ia/ChatGPT Image 25 févr. 2026, 21_12_12.png" />  
  
Les deux images finales sont donc:  
<img width="400" height="400" alt="image" src="/3_ia/generated-image-1.png" />  
<img width="400" height="400" alt="image" src="/3_ia/ChatGPT Image 25 févr. 2026, 21_12_12.png" />  

L'article de news avait pour prompt "Maintenant, écrit un petit article de journal d'environ 200 mots sur leur victoire. Ils font parties de l'équipe de math du gymnase du bugnon et ont gagné le concours Math 4 fun."  
La réponse est :  
"L’équipe du Gymnase du Bugnon remporte le concours Math 4 Fun

Grande fierté au Gymnase du Bugnon : l’équipe de mathématiques de l’établissement a brillamment remporté le concours Math 4 Fun lors de l’édition de cette année. Composée de quatre élèves passionnés et complémentaires, l’équipe s’est distinguée par son esprit d’analyse, sa créativité et une excellente cohésion.

Le concours Math 4 Fun, réputé pour ses épreuves exigeantes et ludiques, met les candidats au défi de résoudre des problèmes complexes mêlant logique, algèbre, géométrie et modélisation. Face à des équipes venues de plusieurs établissements de la région, les élèves du Bugnon ont su garder leur sang-froid et faire preuve d’une remarquable efficacité.

Selon leur enseignant, leur victoire repose autant sur leur solide préparation que sur leur capacité à collaborer sous pression. « Ils ont travaillé avec rigueur tout au long de l’année et ont développé une véritable stratégie d’équipe », souligne-t-il avec enthousiasme.

Au-delà du trophée, cette réussite récompense des mois d’entraînement et témoigne du dynamisme des activités scientifiques proposées par le Gymnase du Bugnon. Les lauréats espèrent désormais inspirer d’autres élèves à rejoindre l’équipe de mathématiques et à relever, eux aussi, de nouveaux défis."



Token = un truc entre un mot et une lettre, souvent le mot est transformé en tokens pour que 
        l'IA puisse comprendre ce qu'on lui demande
        Exemple : "Le chat mange."
                [Le] [cha] [t] [man] [ge.]

LLM = (Large Language Model) un type d'IA qui comprend, process et génère du texte humain
MMLU = (Massive Multitask Language Understanding) une évaluation pour déterminer la capacité d'un modèle IA
(GPT = Generatuve Pre-Trained Model)

Un modèle LLM de base est un modèle qui complète le texte en calculant quel est le mot le plus probable qui va suivre.  
Token| how |  I  | my  | baby |  champignon  
Proba| 36% | 24% | 10% |  1%  |  0,000001%  
  
Comment passer d'un LLM à un chat bot ?  
Avec du Fine-Tuning (permet aussi de créer une IA qui fait autre chose : tri, reconnaitre sentiments, ...)  
Prompt devient un message avec les rôles system et user (il en existe d'autres mais peu utilisé)  
  
gen(prompt) --> <|im_start|>system  
                        ....... (instruction)  
                <|im_end|>  
  
                <|im_start|>user   
                        ........ (conversation/question)  
                <|im_end|>  
  
                <|im_start|>assistant  
  
Enfaite, il complète un texte également mais c'est juste une conversation. Une fois que la probabilité est assez grande, il complète par <|im_end|> et fini le message.

En général, un chat bot possède déjà des instructions de départ "system" et on ne peut pas les modifiers (par exemple évite les sujets politiques)

Cycle de vie d'un LLM :
1) collecte et préparation des données : 
        Tri des données (Toxics, inutiles, biaisée, répétition) par des scripts ---> efficacité augmentée
        Sécurité, confidentialité et éthique
        En général on ne sait pas d'où viennent les données (internet en entier? Github? Wikipedia?)
        Exemple :
        Alice is writing a paper about LLMs. #$^& Alice is writing a paper about LLMs.
        --> Alice is writing a paper about LLMs. Alice is writing a paper about LLMs.
        --> Alice is writing a paper about LLMs.
        --> Replace(Alice) is writing a paper about LLMs. 
        --> ...

2) pré-entraînement

3) fine-tuning et alignement

4) évaluation
    MMLU benchmark, human evaluation, ...

5) déploiement
        Quantification (réduire le modèle) et distillation 
            Exemple Q : réduire palette de couleur d'une image
            Exemple D : image plus petite, mais qui a appris du grand modèle -> pas entraînement from scratch


Fonctionnement d'un LLM (entraînement)

        Lien avec le programme du gymnase (Math et Info)
                Programmation Python (langage de choix pour l'IA)
                Architecture des ordinateurs (rôle des CPU/GPU, mémoire pour pérformance des modèles)
                Systèmes d'équations (base des calclus dans les modèles)
                Analyse (Chercher les minimums et les dérivées d'une fonction)
                Probabilités (Distibution du résultat d'un modèle, échantillonnage)
                        exemple, Chat GPT : P(mot suivant | mots avant)

        Fonctionnement et entrainement 
                Machine learning :
                        Y = f_têta(X)
                                X : prompt, input, ... de l'Utilisateur
                                Y : réponse, prédition, ... du Modèle
                                f : règle pour passer de l'input à l'output
                                têta : variable qui paramétrisent les règles 
                        têta est en général appris ou dérivée par l'IA
                        f devient en général une boîte noir car trop gros pour savoir ce qui se passe dedans
                        exemple :
                                TYPE                  X         Y       Exemples
                                text to text        prompt   réponse    chat GPT
                                text to image       prompt    image     MidJourney
                                text to video       prompt    vidéo     Sora
                                image               image     classe    AlexNet
                                ...                  ...       ...      ...
                        
                        Données d'entraînement :
                                Les paramètres sont déterminés par les données d'apprentissage
                                Les données consistent en des couples de données d'entrée / de sortie (Xi,Yi)
                        
                        Fonction de coût : 
                                L'apprentissage consiste à trouver têta tel que : 
                                        Yi =(vague) f_têta(Xi), pour le maximum de couples de données (Xi, Yi)
                                Fonction de coût qui mesure la distance entre la prédiction du modèle et la vraie valeur pour minimiser cette distance
                                
                        Exemple : La régression linéaire
                                Modèle linéaire :                                               Taille(âge)
                                - Entrée : un nombre X                                          X = âge 
                                - Sortie : un autre nombre Y                                    Y = taille
                                - Données : des couples (Xi, Yi)                                (0, 50cm), (3, 110), ...
                                - Modèle : f_têta(X) = aX + b                                   
                                - Paramètre : têta = (a, b)                                     
                                - Fonction de coup : 
                                        ei = F_coût(f_têta(Xi), Yi) = (f_têta(Xi) - Yi)^2
                                
                        Boucle d'entraînement : 
                                1) Tirer un batch (Xi, Yi) depuis les données
                                2) Calculer la prédiction Yi = f_têta(Xi) - forward pass (avancer dans le réseau de neurones)
                                3) Mesurer l'erreur ei = ...
                                4) Ajuster têta pour réduire ei - backpropagation (ajustement de poids)
                                5) Répéter
                        
                        Ajustement des paramètres (poids) :
                                dérivation et optimisation de fonction
                                En dimension 1 :
                                        - Inversion de variables : h(têta) = F_coût(Yi, f_têta(Xi))
                                        - But trouver le minimum h'(têta) = 0
                                        - Problème : en général impossible à résoudre analytiquement
                                        - Solution : algorithme d'optimisation numérique, on prend la dérivée au point où on est 
                                                     -> baisse/augmente têta pour se rapprocher de la solution (0)
                                
                                En pratique têta est un vecteur
                                        - La dérivée se généralise au gradient
                                        - dans le cas d'un réseau de neurone ce processus s'appelle backpropagation
                        
                        Réseau de neurone :
                                Dans un réseau de neurone, un neurone a un vecteur X, on le multiplie par des poids (produit scalaire entre poids et vecteurs). Dans les réseaux, on a des couches de neurones et têta est une matrice. Pour le deeplearning, on a plusieurs couches de neurones avec pleins de paramètres.
                                Forwardpass : de X vers la sortie
                                Backpropagation : calculer la dérivée du modèle, on prend le X, on lui applique une couche, puis une autre, ... -> devient une fonction composée. En pratique, l'optimisation par descente de gradient devient une série de calculs matriciels.

                        (Début du TP4, rappel des notions du machine learning)
                        Exemple de modèle : calcul du prix des maisons à Boston en 1970 avec 13 paramètres et un prix médian --> code pour la régression linéaire
                        
                        Ex 1.2: reconnaître les paramètres (X, Y, têta)   
                                X est le nombre de pièces 
                                Les points sont les couples de données (Xi, Yi) 
                                La droite est le modèle
                                L'erreur est une fonction de la distance: (Yi -f_têta(Xi))**2
                                tangeante en 3d est un plan 
                                Les paramètres a et b sont défini par
                                        a, b = np.polyfit(x_rm, y, 1)
                                
                                En gros, il cherche les meilleurs a et b en fonction de Yi et Xi pour estimer la meilleure droite représentant le calcul et qui respectent ces critères : 
                                        MSE = Somme((Yi - f_têta(XI))**2)
                                        h(a, b) = Somme((Yi - (aXi + b))**2)
                                        dh/da = 0
                                        dh/db = 0
                                et pour cela il trouve un a, fait la dérivée en a, et descend ou monte a pour se rapprocher de 0 (il cherche le minimum de la fonction pour trouver a) ---> voir tp4, section 1.3
                        
                        Section 1.5, réseau de neurones (13 paramètres)
                                désavantage si trop de paramètres car on sait pas ce qui influence le plus les réponses
                                chaque boîte montre l'influence du paramètre associé sur le prix
                                le modèle prend en compte tous les paramètres pour la meilleure réponse possible
                                13 inputs, 64 neurones, chaque inputs (paramètres) passe dans chacun des neurones pour estimer le prix au mieux ---> 13*64 + 64 = 832 + 64 = 896 paramètres au total. 
                                Ensuite, on ajoute une couche de paramètre ---> 64 paramètres de plus + 1 biais ---> au total, 961 paramètres dans le modèle

                                Plus un modèle a de paramètres, plus ils ont tendance à apprendre les réultats sur les données d'entraînement et sont incapables de donner une estimation sur les nouvelles données.

                                1.5.2 --> on ajoute une 2ème couche de neurones 
                                        ---> chaque 13 paramètres passent dans la chacun des neurones de la première couche, puis chaque sortie de chaque paramètre passe dans chaque neurones de la 2ème couche, et enfin ils ont tous encore un paramètre à la sortie + un biais ---> total : 896 + 4160 + 65 = 5121 paramètres
        
                Tokenisation :
                        Comment passer de texte en entrée à texte en sortie alors quee les calculs sont fait sur des nombres ?
                                1. Tokenisation
                                        transformer des mots ou des bouts de phrases en tokens (par exemple par caractère ou par mot), celui que presque tout le monde utilise est le BPE (voir 2.3)
                                        Le but est de crée un dictionnaire : token 1 = 1, token 2 = 2, ...
                                        Pour le BPE, on lui donne plein de texte et il regarde quels mots/caractères/groupe de caractères reviennent les plus souvent et leur ajoute une valeur. 
                                2. Embedding
                                        chaque token ID est converti en un vecteur de dimension d.
                                        (exemple au 3.1)
                                        similarité : calcul de la distance entre deux vecteurs pour trouver des similarités, p.ex. king - man + woman = queen (0.77)
                                        on peut voir au 3.4 que lion est dans le groupe des animaux mais il se rapproche du groupe de la royauté --> lion = roi des animaux


                        Prédiction du token suivant : P(token_n+1 | token_1, ..., token_t)
                
                Partie 4: 
                        On a des nombres en sortie, on en fait quoi ?
                        Chaque  nombre est associé à une probabilité 
