Get-Content 'C:\Users\Jdoe\Downloads\Matched_hosts - Copy.csv' | ForEach-Object  {
            
                
               
               #Using the select-string argument I can then use regex to look for specific data 
               
               $url = Select-String  -InputObject $_  -pattern "(bit\.ly|goo\.gl|tinyurl\.com)\S*\s"
               $timestamp = select-string -InputObject $_ -pattern  "((\d+(:|-))+\d+\D)+"
               $websitetitle = Select-string -InputObject $_ -pattern "(Web Page Title:).*?(Web Page Visit|Browser)"
               $hostname = $_.split(",")
               $username = select-string -InputObject $_ -pattern "(Username: ).*?\s"
               
               #output to powershell to help with debuging 
               
               Write-host ""
               Write-host " | Found URL ===" $url.matches.value 
               Write-host " | TIME STAMP === " $timestamp.matches.value 
               Write-host " | FOUND WEBSITE TITLE === " $Websitetitle.matches.value 
               Write-host " | HOSTNAME FOUND === " $hostname[0] 
               Write-host " | USERNAME FOUND === " $username.matches.value 

          
            

               #Created custom objects from my extracted data
               
               New-Object  -Type PSObject -Property @{
               'URL' = $url.Matches.value
               'timestamp' = $timestamp.matches.value
               'websitetitle' = $websitetitle.matches.value 
               'hostname' = $hostname.matches.value
               'username' = $username.matches.value 
              }
                        #Finally exported to CSV 
                } | Export-Csv C:\Users\jDoe\Downloads\output.csv
