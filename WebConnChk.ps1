# START SCRIPT


# Script Banner
echo "

 __      __      ___.   _________                      _________ .__     __    
/  \    /  \ ____\_ |__ \_   ___ \  ____   ____   ____ \_   ___ \|  |__ |  | __
\   \/\/   // __ \| __ \/    \  \/ /  _ \ /    \ /    \/    \  \/|  |  \|  |/ /
 \        /\  ___/| \_\ \     \___(  <_> )   |  \   |  \     \___|   Y  \    < 
  \__/\  /  \___  >___  /\______  /\____/|___|  /___|  /\______  /___|  /__|_ \
       \/       \/    \/        \/            \/     \/        \/     \/     \/

[+] Script:        WebConnChk.ps1
[+] Purpose:       Tests for HTTP/s web connection to end device
[+] Dependencies:  IP Address input file
[+] Author:        Ryan Pan***** 07/16/2019

"

# Input textfile - file in which IP Address are read from
$textfile = 'IPList.txt'

echo "[+] Connection Tests:"

# Loop through each IP Address in the text file
foreach($line in Get-Content $textfile) {
    # Assign each line as an IP Address variable
    $ip = $line

    Try
    {
        # curl command executed the IP Address to test for 200 status code
        $connTest = curl $ip -Method Get -timeout 10 -ErrorAction Ignore | findstr "200"
        $status = Write-Output $connTest

        # If status of 200 is returned
        if ($status) {
            # State connection success
            echo "SUCCESS,$ip"
        }
    }
    Catch
    {
        # If status code of 200 is not returned
        # State connection failed
        echo "FAIL,$ip"
    }
}


# END OF SCRIPT
