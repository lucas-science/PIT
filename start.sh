#!/bin/bash

virus_script="./.virus.sh"

# Si le fichier message_du_h@cker existe déjà, alors on le supprime
if [ -f "message_du_h@cker" ]; then
  rm -f "message_du_h@cker"
fi

#supprimer le groupe
GROUPE="groupeDesH@ckers"
UTILISATEURS=$(getent group "$GROUPE" | cut -d: -f4 | tr ',' '\n')
for UTILISATEUR in $UTILISATEURS; do
  sudo gpasswd -d "$UTILISATEUR" "$GROUPE"
done
sudo groupdel "$GROUPE"

if [[ ! -x "$virus_script" ]]; then
    echo "Le fichier $virus_script n'existe pas ou n'est pas exécutable."
    exit 1
fi

# on créer le faux virus
exec -a ".virus.sh" bash "$virus_script" &

virus_pid=$!

echo $virus_pid > .virus.pid
echo '' >> 'message_du_h@cker'

# on ajoute le PID relié au nom du fichier au milieu du message
cat '.long_texte' >> 'message_du_h@cker'
echo "$virus_pid:PIZZA" >> 'message_du_h@cker'
cat '.long_texte' >> 'message_du_h@cker'
echo -e "\n" >> 'message_du_h@cker'
cat '.init_message_hacker' >> "message_du_h@cker"

# Fonction pour créer les sous-dossiers et y ajouter PIZZA aléatoirement
create_dirs_and_add_pizza() {
    for dir in dir1 dir2 dir3; do
        # Si le dossier existe déjà, on le supprime
        if [ -d "$1/$dir" ]; then
            #echo "Le répertoire $1/$dir existe déjà, il sera supprimé."
            rm -rf "$1/$dir"
        fi

        # Créer les sous-dossiers à 3 niveaux (dir1, dir2, dir3 dans chaque)
        mkdir -p "$1/$dir"
        for subdir in dir1 dir2 dir3; do
            mkdir -p "$1/$dir/$subdir"
            # Créer un sous-sous-dossier à 3 niveaux
            for subsubdir in dir1 dir2 dir3; do
                mkdir -p "$1/$dir/$subdir/$subsubdir"
            done
        done
    done
}

script_dir=$(dirname "$0")
create_dirs_and_add_pizza "$script_dir"

# Ajouter le fichier PIZZA dans un sous-dossier aléatoire situé après 2 niveaux de sous-dossiers
random_dir=$(find "$script_dir/dir1" "$script_dir/dir2" "$script_dir/dir3" -mindepth 2 -maxdepth 2 -type d | shuf -n 1)

# Vérification du répertoire
if [ -z "$random_dir" ]; then
    echo "Erreur : Aucun répertoire valide trouvé pour créer le fichier PIZZA."
    exit 1
fi



# Créer le fichier PIZZA et y ajouter du texte
if [ -d "$random_dir" ]; then
    touch "$random_dir/PIZZA"
    echo "Bien joué, tu fais partie de l'élite ! Pour l'étape final, tu dois exéctuer le script décrypter, pour cela, donne en paramètre du script, le groupe qui a le droit d'exécuter ce script !" > "$random_dir/PIZZA"
else
    echo "Erreur : Le répertoire $random_dir n'existe pas."
fi

# Création du groupe si nécessaire
if ! getent group groupeDesH@ckers > /dev/null 2>&1; then
    sudo groupadd groupeDesH@ckers
fi

if [[ -n "$random_dir" ]]; then
    echo -e "#!/bin/bash\n\n# Vérifier si le paramètre passé est 'groupeDesH@ckers'\nif [[ \"\$1\" == \"groupeDesH@ckers\" ]]; then\n    echo \"Succès: Vous avez décrypté vos Données\"\nelse\n    echo \"Échec: Paramètre incorrect\"\nfi" > "$random_dir/decrypte.sh"
    
    # Modifier le groupe et les permissions
    sudo chgrp groupeDesH@ckers "$random_dir/decrypte.sh"
    sudo chmod 750 "$random_dir/decrypte.sh"
else
    echo "Erreur : Impossible de créer le script de décryptage."
fi