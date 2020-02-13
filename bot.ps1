Import-Module "c:\lib\script1.ps1"

$version = 1

$gitLink = 'https://raw.githubusercontent.com/theurtebize/majBOT/master/bot.ps1?token=ADGCY3BOHGDYLGLVPLYBRQS6IVVT2'

# Récupération du git
Invoke-WebRequest -Uri $gitLink -UseBasicParsing -OutFile 'C:\lib\botv1.ps1'

#netstat -ano | find "1984"
$Socket = FRX_Socket-Listen-Connect -port 1984


$closeACK = FRX_Socket-Listen-Close -socket $Socket
