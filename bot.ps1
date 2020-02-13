Import-Module "c:\lib\script1.ps1"

$version = 1

function check_version{

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/theurtebize/majBOT/master/bot.ps1?token=ADGCY3BOHGDYLGLVPLYBRQS6IVVT2'

}

function global:FRX_Socket-MessageAction{
    param($message)
    $stop = $false
    switch ($message) {
        {$_ -match "HACKMETHIS"  } {write-host "hack this" -ForegroundColor green}
        {$_ -match "COUNT"       } {write-host "COUNT" -ForegroundColor Yellow}
        {$_ -like  "GAMEOVER"    } {write-host "--- TERMINATING CONNECTION ---" -ForegroundColor red
                                    $stop=$true}
        Default {write-host $message}
    }

    return $stop

}

#netstat -ano | find "1984"
$Socket = FRX_Socket-Listen-Connect -port 1984

do{
    $message = FRX_Socket-Listen-Read -socket $Socket -buffersize 512
    $stop    = FRX_Socket-MessageAction -message $message
}until($stop)

$closeACK = FRX_Socket-Listen-Close -socket $Socket
