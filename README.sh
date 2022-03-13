# Edition
#      mkdocs serve
#
#   avec PDF 
#   export ENABLE_PDF_EXPORT=1
# GENERATION DU SITE
mkdocs build 
# ENVOI SUR SERVEUR DOCKER DOCS 
rsync -av -e 'ssh -p 8023' ./ sadmin@alpine:/srv/terraform/ 
ssh -p 8023 sadmin@alpine sudo sh /srv/terraform/compose-restart.sh
