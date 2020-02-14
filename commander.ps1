Import-Module "C:\lib\secu\s1.ps1"

<#
En message, il faut envoyer :
recupscript  --> permet de récupérer le script à nouveau
update       --> permet de mettre à jour le script
createtache  --> permet de créer la tâche du script
#>

FRX_Socket-Send-Port -IPTarget 192.168.219.143 -port 1984 -message 'update'
