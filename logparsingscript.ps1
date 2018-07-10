Get-Content 'C:\Users\nkwiecie\Downloads\Matched_hosts - Copy.csv' | ForEach-Object  {
            
                
               
               $url = Select-String  -InputObject $_  -pattern "(bit\.ly|goo\.gl|tinyurl\.com)\S*\s"
               $timestamp = select-string -InputObject $_ -pattern  "((\d+(:|-))+\d+\D)+"
               $websitetitle = Select-string -InputObject $_ -pattern "(Web Page Title:).*?(Web Page Visit|Browser)"
               $hostname = $_.split(",")
               $username = select-string -InputObject $_ -pattern "(Username: ).*?\s"
               
             
               Write-host ""
               Write-host " | Found URL ===" $url.matches.value 
               Write-host " | TIME STAMP === " $timestamp.matches.value 
               Write-host " | FOUND WEBSITE TITLE === " $Websitetitle.matches.value 
               Write-host " | HOSTNAME FOUND === " $hostname[0] 
               Write-host " | USERNAME FOUND === " $username.matches.value 

          
            

            
               New-Object  -Type PSObject -Property @{
               'URL' = $url.Matches.value
               'timestamp' = $timestamp.matches.value
               'websitetitle' = $websitetitle.matches.value 
               'hostname' = $hostname.matches.value
               'username' = $username.matches.value 
              }

                } | Export-Csv C:\Users\nkwiecie\Downloads\output.csv
