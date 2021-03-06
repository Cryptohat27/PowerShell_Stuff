 Import-Module ActiveDirectory
:serviceloop while(1) 
{
$name = Read-Host "Enter the user you which to move to Former Employees"
Get-ADUser $name | Move-ADObject -TargetPath "OU=Former Employees,OU=Lockdown,OU=TMC,DC=MainOffice,DC=hazmatt,DC=com" 
Disable-ADAccount -Identity $name
Get-ADPrincipalGroupMembership -Identity $name | % {Remove-ADPrincipalGroupMembership -Identity $name -MemberOf $_}
$rerun = Read-Host "Would you like to fire another employee?"
            if ($rerun -eq "y" -or $rerun -eq "Y"){
                    Write-Host "Okay, fire again`n"
    #Waits 1 second before prompting the user for more input
                    Start-Sleep -s 2
                    continue serviceloop
                    }
            else{
                    Write-Host "`n Okay then. Goodbye.`n"
    #Waits 1 second before closing after saying goodbye
                    Start-Sleep -s 1
                    break
                    }     
                }