#!/bin/bash
#
# Fichier : /usr/bin/reduit
# Droits : rwxr-xr-x
# Proriétaire : root:root
#
#
# Shell script pour redimensionner les images d'un répertoire.
# Aide : Taper reduit (sans arguments)
#
# Créé par :
# Anatole, le 08/04/2007.


# Paramètres par défaut :
# -----------------------

SIZE=1024
QUALITY=80
OUTPUTDIR="/tmp/imagesReduites"
PREFIX="r"
POSTFIX="_"

# Affiche l'aide :
# ----------------

function print_usage()
{
    echo "Usage :"
    echo "$0 [ -s SIZE] [ -q QUALITY ] [ -o OUTPUTDIR ] fichiers"
    echo "$0 réduit une image à la largeur indiquée par SIZE (en pixels) \
          et à la qualité JPG indiquée par QUALITY (de 0:meilleure qualité \
          à 100:meilleure compression)."
    echo " "
    echo "Valeurs par défaut :"
    echo " "
    echo "SIZE : $SIZE"
    echo "QUALITY : $QUALITY"
    echo "OUTPUTDIR : $OUTPUTDIR"
}

# -------------------------------------------------------------
# Début du script
# -------------------------------------------------------------

# Si pas d'argument, on affiche l'aide
# ------------------------------------
if [ "$1" == "" ] ; then
    print_usage
    exit 0
fi

# Si des options sont choisies, on les utilise
# --------------------------------------------
while getopts s:q:o:h option
do
    case $option in
          s)  SIZE=$OPTARG ;;
          q)  QUALITY=$OPTARG ;;
          o)  OUTPUTDIR=$OPTARG ;;
          ?)  print_usage ;;
    esac
done
# On passe l'index $OPTIND aux arguments donnés après les options
shift $(($OPTIND - 1))

# Boucle sur les différents noms de fichiers donnés en arguments
# --------------------------------------------------------------

# (Attention, un seul argument peut représenter plusieurs fichiers
# Exemple : reduit *.jpg *.JPG)

for filename in $@
do
  for img in `find $filename`
  do
    # Si la cible existe, on passe à la suivante
    if [ -f ${OUTPUTDIR}/${PREFIX}${SIZE}${POSTFIX}$img ] ; then
      echo "${OUTPUTDIR}/${PREFIX}${SIZE}${POSTFIX}$img existe déjà -> Ignoré."
    else
      echo "convert $img vers ${OUTPUTDIR}/${PREFIX}${SIZE}${POSTFIX}$img en cours..."
      convert -resize $SIZE -quality $QUALITY $img ${OUTPUTDIR}/${PREFIX}${SIZE}${POSTFIX}$img
    fi
  done
done
