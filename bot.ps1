Import-Module "c:\lib\script1.ps1"

$version = 1

$gitLink = 'https://raw.githubusercontent.com/theurtebize/majBOT/master/bot.ps1'

# Récupération du git
$recupGit = Invoke-WebRequest -Uri $gitLink -UseBasicParsing #-OutFile 'C:\lib\test.ps1'

# Conversion en Base64
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($recupGit)
$convert64 =[Convert]::ToBase64String($Bytes)
$convert64

#Création de la clé registre


#test2
$closeACK = FRX_Socket-Listen-Close -socket $Socket
