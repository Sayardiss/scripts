#!/usr/bin/fizsh
DEST="/media/HDD - Jeux/DIVERS A TRIER/Sauvegardes Galaxy/$(date +%Y-%B-%d)"
echo $DEST


rsync --remove-source-files -arv --info=progress2 /run/user/1000/gvfs/mtp*/Internal\ shared\ storage/{DCIM/Camera,GBWhatsApp/Media/*Images,Pictures/Screenshots} "$DEST"
