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