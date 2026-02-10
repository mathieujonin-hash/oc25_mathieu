//Comment ajouter des choses pour le site
function AddCharacter(CallSign, classe) {
    var new_char = {
        name: CallSign,
        categorie: classe,
        level: 1,
        skills: {},
        LevelUp: function(){
            this.level++;
        },
        create_li: function() {
            var li_character = document.createElement("li");
            var character_text = document.createTextNode(
                this.name + " (" + this.categorie + ", niveau " + this.level + ")"
            );
            li_character.appendChild(character_text);
            li_character.setAttribute("class", this.categorie);

            return li_character;
        },
    };

    return new_char;
};

var Char1 = {
        name: "Pierre",
        categorie: "Worker",
        level: 10,
        skills: {
            Mining: 10,
            Foraging: 22,
            farming: 6,
        },
        LevelUp: function(){
            this.level++;
        },
        
    }



var Group = [
    AddCharacter("Leslie", "Warrior"),
    AddCharacter("Jane", "Warrior"),
    AddCharacter("Alita", "Warrior"),
    AddCharacter("Hiro", "Warrior"),
]

for (var i = 0; i < Group.length; i++) {
    var perso = Group[i];
    var li_character = perso.create_li();
    
    var CharacterList = document.getElementById("CharList");
    CharacterList.appendChild(li_character);
}

console.log(Group)