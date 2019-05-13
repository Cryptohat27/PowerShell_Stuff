    Write-Host "**********************************************************************************`n
            
    Powershell New AD User Script`n
       Writen By: Spencer Bischof
         
            
    **********************************************************************************`n"
##Imports the Active Directory module in order to be able to use the New-ADUser Cmdlet
    Import-Module ActiveDirectory

##The start of the loop to make users
    :serviceloop while(1) {




<##Last name loop which asks the user for the last name (read-host) and then checks if there is a Mc, Jr. or O' in it, and properly sets variables to what they need to be
    The following are what the variables are:

    $Last = the user inputted data
    $Last1, $Last2 = Segments of the name to put together in order to make other variations of the name for instance one could be mc and the other donalds
    $LastE = the last name that will be included in the email address like mcdonalds
    $LastD = the display that the user sees and the display name on the computer like McDonalds
    $Last = gets changed from the user input to just the root name with jr like Downey Jr. would have the variable last equil to Downey
                
 #>



 
                :serviceloop while(1) {
                            $Last = Read-Host "Enter Last Name"

                            if (($Last[-3] + $Last[-2] + $Last[-1]) -eq "Jr.")
                                {
                                    $Last = $Last.tolower()
                                    $Last1 = $Last[-3] + $Last[-2]
                                    $Last2 = $Last.TrimEnd("jr.")
                                    $Last2 = $Last2.TrimEnd()
                                    $LastE = $Last.TrimEnd("jr.")
                                    $LastE = $LastE.TrimEnd() + "jr"
                                    $LastD = (Get-Culture).textinfo.totitlecase(“$Last2”.tolower()) + " " + (Get-Culture).textinfo.totitlecase(“$Last1”.tolower()) + "."
                                    $Last = (Get-Culture).textinfo.totitlecase(“$Last2”.tolower())
                                }

                            elseif (($Last[-2] + $Last[-1]) -eq "Jr")
                                {
                                    $Last = $Last.tolower()
                                    $Last1 = $Last[-2] + $Last[-1]
                                    $Last2 = $Last.TrimEnd("jr")
                                    $Last2 = $Last2.TrimEnd()
                                    $LastE = $Last.TrimEnd("jr")
                                    $LastE = $LastE.TrimEnd() + "jr"
                                    $LastD = (Get-Culture).textinfo.totitlecase(“$Last2”.tolower()) + " " + (Get-Culture).textinfo.totitlecase(“$Last1”.tolower()) + "."
                                    $Last = (Get-Culture).textinfo.totitlecase(“$Last2”.tolower())
                                    }

                            else{
                                    $Last = (Get-Culture).textinfo.totitlecase(“$Last”.tolower())
                                    $LastD = $Last
                                    $LastE = $Last
                                }

                            if (($Last[0] + $Last[1]) -eq "mc")
                                {
                                    $Last1 = $LastD[0] + $LastD[1]
                                    $Last2 = $LastD.substring(2)
                                    $LastD = (Get-Culture).textinfo.totitlecase(“$Last1”.tolower()) + (Get-Culture).textinfo.totitlecase(“$Last2”.tolower())
                                
                                 }
                            elseif (($Last[0] + $Last[1]) -eq "O'")
                                {
                                    $Last1 = $LastE[0] + $LastE[1]
                                    $Last2 = $LastD.substring(2)
                                    $LastD = (Get-Culture).textinfo.totitlecase(“$Last1”.tolower()) + (Get-Culture).textinfo.totitlecase(“$Last2”.tolower())
                                    $Last3 = (Get-Culture).textinfo.totitlecase(“$Last2”.tolower())
                                    $LastE = $LastE[0] + $LastE.substring(2)
                                
                                }
                            else{
                                    $Last = (Get-Culture).textinfo.totitlecase(“$Last”.tolower())
                                    #$LastE = $Last
                                }
                       
                            write-Host $LastD
                        
    #Remove the "<#> if you want user verification of information on this feild
                            <#$Correct1 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct1 -eq "y" -or $Correct1 -eq "Y") {
                                break
                                      }#>
                            break
                            }




##First name field, this field comes with no user input validation or other solicitation to the user
                  :serviceloop while(1) {
                            $First = Read-Host "Enter First Name"

                            $First = (Get-Culture).textinfo.totitlecase(“$First”.tolower())

                            Write-Host $First

    #Remove the "<#> if you want user verification of information on this feild
                            <#$Correct2 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct2 -eq "y" -or $Correct2 -eq "Y"){
                                    break
                              }#>

                            break
                            }


##This defines the users display name as first and last name with a space in between
                        $FullNameWS = $First + " " + $LastD



##Middle initial field, comes with checking to see if the user solicited input is a single character, if it is not, then it will read out to the user that the input is invalid
    #if there is already a middle initial defined from a previous solicited input, this will clear it
                    if (1 -eq ($MiddleI | measure-object -character | select -expandproperty characters)){
                                Clear-Variable MiddleI
                                }
                
                   :serviceloop while(1) {
                        $MiddleI = Read-Host "Enter Middle Initial (If no middle initial, just leave blank and hit enter)"
                        if ( "0" -eq ($MiddleI | measure-object -character | select -expandproperty characters)){
                                Write-Host "No Middle Initial."
                            
                                break
                                }
                        elseif (1 -eq ($MiddleI | measure-object -character | select -expandproperty characters)){
                                $MiddleI = $MiddleI[0].ToString().ToUpper()
                                Write-Host $MiddleI
                            
                                break
                                }
                        else{
                                Write-Warning "Invalid response: Please enter a single letter or press enter if it is unknown."
                                Clear-Variable MiddleI
                                continue serviceloop
                                }

    #Remove the "<#> if you want user verification of information on this feild
                        <#$Correct3 = Read-Host "Is this correct? [y/n]"
     
                        if ($Correct3 -eq "y" -or $Correct3 -eq "Y"){
                                break
                          }#>

                            }




##Defines the username for use in the email field, and sets the user variable to all lowercase if it is not already so. This also writes the users username out to the person entering information
                        $User = $First[0] + $LastE

                        $User = “$user”.tolower()

                            Write-Host `nUsername is:($User)`n





<##Department field, this field is where the user can enter the department the new use is in, and this field comes with error correction for abbreviations.
 This field also consists of an invalid input error that when displayed, means that the user did not enter any matching information

 THIS IS THE FIRST FIELD THAT YOU NEED TO EDIT IF YOU NEED TO ADD A DEPARTMENT TO THE SCIPT

 #>
                        :serviceloop while(1) {
                            $Dept = Read-Host "Enter Department"
                            switch ($Dept)
                                {
                                    {($_ -eq "Accounting") -or ($_ -eq "Account") -or ($_ -eq "Acc") -or ($_ -eq "Ac") -or ($_ -eq "AD") -or ($_ -eq "A")} {
                                            $Dept = "Accounting"}
                                    {($_ -eq "Field Technician") -or ($_ -eq "Field Services") -or ($_ -eq "FServices") -or ($_ -eq "FService") -or ($_ -eq "Field Tech.") -or ($_ -eq "Field Tech") -or ($_ -eq "Field") -or ($_ -eq "FT") -or ($_ -eq "FS") -or ($_ -eq "F") -or ($_ -eq "FTech.") -or ($_ -eq "FTech")} {
                                            $Dept = "Field Services"}
                                    {($_ -eq "Operations") -or ($_ -eq "Ops.") -or ($_ -eq "Ops") -or ($_ -eq "O")} {
                                            $Dept = "Operations"}
                                    {($_ -eq "Transportation and Disposal") -or ($_ -eq "Transportation & Disposal") -or ($_ -eq "Transportation") -or ($_ -eq "Transport") -or ($_ -eq "Disposal") -or ($_ -eq "T and D") -or ($_ -eq "TandD") -or ($_ -eq "T & D") -or ($_ -eq "T&D") -or ($_ -eq "TD") -or ($_ -eq "TND") -or ($_ -eq "T N D") -or ($_ -eq "T")} {
                                            $Dept = "Transportation and Disposal"}
                                    {($_ -eq "Project Manager") -or ($_ -eq "Project Managers") -or ($_ -eq "Project Management") -or ($_ -eq "Project Mgmt") -or ($_ -eq "Project") -or ($_ -eq "PM") -or ($_ -eq "P")} {
                                            $Dept = "Project Management"}
                                    {($_ -eq "Supervisors") -or ($_ -eq "Foreman") -or ($_ -eq "Foremen") -or ($_ -eq "Supervisors and Foreman") -or ($_ -eq "Supervisors and Foremen") -or ($_ -eq "Supervisor") -or ($_ -eq "SF")} {
                                            $Dept = "Supervisors and Foremen"}
                                    {($_ -eq "Human Resources") -or ($_ -eq "Human") -or ($_ -eq "Compliance") -or ($_ -eq "HR") -or ($_ -eq "H")} {
                                            $Dept = "Human Resources"}
                                    {($_ -eq "Health and Safety") -or ($_ -eq "Health") -or ($_ -eq "Safety") -or ($_ -eq "HS") -or ($_ -eq "H and S") -or ($_ -eq "HandS") -or ($_ -eq "H & S") -or ($_ -eq "H&S") -or ($_ -eq "HNS")} {
                                            $Dept = "Health and Safety"}
                                    {($_ -eq "Information Technology") -or ($_ -eq "Information Services") -or ($_ -eq "IT") -or ($_ -eq "IS") -or ($_ -eq "Tech") -or ($_ -eq "Tech.") -or ($_ -eq "I")} {
                                            $Dept = "Information Technology"}
                                    {($_ -eq "Marketing") -or ($_ -eq "Market") -or ($_ -eq "MT") -or ($_ -eq "M") -or ($_ -eq "Design")} {
                                            $Dept = "Marketing"}
                                    {($_ -eq "Sales") -or ($_ -eq "Sail") -or ($_ -eq "Sale") -or ($_ -eq "SLS") -or ($_ -eq "sold")} {
                                            $Dept = "Sales"}
                                    default {
                                        Write-Warning "Invalid response: Please enter a valid department (Accounting, Field Services, Transportation and Disposal, Project Management, Supervisors and Foremen, Human Resources, Health and Safety, Information Technology, Marketing, or Sales)"
                                        continue serviceloop
                                    }
                                }

                            Write-Host $Dept

    #Remove the "<#> if you want user verification of information on this field
                            <#$Correct4 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct4 -eq "y" -or $Correct4 -eq "Y"){
                                    break
                              }#>

                            break
        
                            }



##Job title field, this field is where a user defines the job title of the new user, and this field comes with no correction code, but does include auto capitalization
                        :serviceloop while(1) {
                            $Title = Read-Host "Enter Job Title"

                            $Title = (Get-Culture).textinfo.totitlecase(“$Title”.tolower())

                            Write-Host $Title
                            if ( "0" -eq ($Title | measure-object -character | select -expandproperty characters)){
                                    Write-Warning "Try entering the Job Title again."
                                    continue serviceloop
                                    }
    #Remove the "<#> if you want user verification of information on this feild
                            <#$Correct5 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct5 -eq "y" -or $Correct5 -eq "Y"){
                                    break
                              }#>

                            break
                            }



<##Service Center Location field, this field is where an end user would input where the new user's service center would be. This field comes with error checking, and asks for the correct input if the user does not enter the correct service center
   If the user enters a state with mutable cities that have service centers, the code will warn the user that they must provide valid input and tell them the cities names.

   THIS IS THE PLACE TO CHANGE/ADD SERVICE CENTERS IN THE CODE

#>
                        :serviceloop while(1) {
                            $Local = Read-Host "Enter Service Center Location"
                            switch ($Local)
                                { 
    #DeExt = default extension aka the last 4 of the phone number of the service center. This is here if one wanted to have code that created users with an extension equivilent to the last 4 digits of the service centers phone number
                                    {($_ -eq "MA") -or ($_ -eq "Mass") -or ($_ -eq "Massachusetts")} {Write-Warning "Invalid response: Enter City of Service Center (Generic)"
                                                continue serviceloop}
                                    {($_ -eq "g") -or ($_ -eq "generic")} {
                                            $Local = "generic"
                                            $Address = "generic"
                                            $ServCity = "generic"
                                            $Zip = "generic"
                                            $PhoneArea = "(508) 966-"
                                            $DeExt = "generic"
                                            $Fax = "generic"
                                            }


                                    {($_ -eq "VT") -or ($_ -eq "Vermont")} {
                                            Write-Warning "Invalid response: Enter City of Service Centerp"
                                            continue serviceloop
                                            }
                                  
                                    default {
                                        Write-Warning "Invalid response: Please enter the state that the service center is in"
                                        continue serviceloop
                                    }
                                }

                            Write-Host "$ServCity, $Local"

    #Remove the "<#> if you want user verification of information on this field
                            <#$Correct6 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct6 -eq "y" -or $Correct6 -eq "Y"){
                                    break
                              }#>
                            break    
                            }


<##Extension field, This is the field that you would enable by removing <# > to change the last four of the work phone to a user’s extension, and ask the person inputting information what there extension is
    
    REMEBER: remove the last part of the script where it says remove next line, so that the extension will be the last four digits on the work phone number
#>
                        <#:serviceloop while(1) {
                            $Ext = Read-Host "Enter 4 Digit Extention (If no mobile number, just leave blank and hit enter)"
                            if ("0" -eq ($Ext | measure-object -character | select -expandproperty characters)){
                                    Write-Host "No Extention."
                                    $Ext = $DeExt
                             }
                            elseif ( "4" -ne ($Ext | measure-object -character | select -expandproperty characters)){
                                    Write-Host "Invalid response."
                                    continue serviceloop
                             }
                            else{
                                    Write-Host $Ext
                             }
    Remove the "<# > if you want user verification of information on this feild
                            $Correct7 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct7 -eq "y" -or $Correct7 -eq "Y"){
                                    break
                              }
                            else {
                                    continue serviceloop
                                  }
                           }
                        #>
   #remove next line if using extension script
                        $Ext = $DeExt
                        #^^^^^^^^^^^^^^





##This defines the phone number to be phone area code and middle 3 digits and the last four of the phone number which is either the default,  the users extension if the above field is enabled
                        $Phone = $PhoneArea + $Ext





<##Mobile Phone field, this field is for users to be able to add a mobile phone number to a user’s profile if they have it, this field does not have error checking for the types of characters
   This field only contains checking for the number of characters in the solicited response, in this case if the response has 10 characters it will be okay in the eyes of the script
#>
                        :serviceloop while(1) {
                            $MobilePh = Read-Host "Enter 10 Digit Mobile Number (no hyphens or parentheses)(If no mobile number, just leave blank and hit enter)"
                            if ( "0" -eq ($MobilePh | measure-object -character | select -expandproperty characters)){
                                    Write-Host "No Mobile Number."
                                    break
                                    }
                            elseif (10 -eq ($MobilePh | measure-object -character | select -expandproperty characters)){
                                    $MobilePhEntry = ($MobilePh.Substring(0,$MobilePh.Length-7)) + "." + ($MobilePh.Substring(3,$MobilePh.Length-7)) + "." + $MobilePh.substring($MobilePh.length - 4, 4)
                                    $MobilePh = "(" + ($MobilePh.Substring(0,$MobilePh.Length-7)) + ") " + ($MobilePh.Substring(3,$MobilePh.Length-7)) + "-" + $MobilePh.substring($MobilePh.length - 4, 4)

                                    Write-Host $MobilePh
                                    break
                                    }
                            else{
                                    Write-Warning "Invalid response: Phone number not 10 digits"
                                    Clear-Variable MobilePh
                                    continue serviceloop
                                    }

    #Remove the "<#> if you want user verification of information on this field
                            <#$Correct8 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct8 -eq "y" -or $Correct8 -eq "Y"){
                                    break
                              }#>
        
                                }




##This is where a user defines what company the user will be a part of this affects two fields the company field in the new ad user creation, and the email address domain name
                        :serviceloop while(1) {
                            $Company = Read-Host "Enter Company (company, Company)"
                            switch ($Company)
                                {
                                    {($_ -eq "Company") -or ($_ -eq "Company") -or ($_ -eq "Company") -or ($_ -eq "Company")} {
                                            $Company = "Company"
                                            $emailending = "Company.com"
                                            }
                                    {($_ -eq "Company") -or ($_ -eq "Company") -or ($_ -eq "Company")} {
                                            $Company = "Company"
                                            $emailending = "Company"
                                            }
                                    default {
                                        Write-Warning "Invalid response: Enter options"
                                        continue serviceloop
                                    }
                                }

                            Write-Host $Company

    #Remove the "<#> if you want user verification of information on this feild
                           <#$Correct9 = Read-Host "Is this correct? [y/n]"
 
                            if ($Correct9 -eq "y" -or $Correct9 -eq "Y"){
                                    break
                              }#>

                            break
        
                            }





##This defines the email address with the $User variable first, and proper company domain name next with an @ symbol in between them
                        $EmailAddress = $User +"@" + $emailending



##Below shows the user the input they provided to make sure it is correct before proceeding
        Write-Host `n
        Write-Host "User's Last Name Is: " $Last
        Write-Host "User's First Name Is :" $First
        Write-Host "User's Department Is :" $Dept
        Write-Host "User's Location Is :" $ServCity"," $Local
        Write-Host "User's Job Title Is :" $Title
        #Write-Host "User's Extention :" $Ext
        Write-Host "User's Phone Number :" $Phone
        Write-Host "User's Fax Number :" $Fax
        Write-Host "User's Mobile Phone Number :" $MobilePh
        Write-Host "User's Email Address :" $EmailAddress



##The following code converts the phone numbers with parentheses and dashes to a phone number with dots (to follow the naming convention of AD)

        if (1 -lt ($MobilePh | measure-object -character | select -expandproperty characters)){
                $MobilePh = ($MobilePh.Substring(1,$MobilePh.Length-11)) + "." + ($MobilePh.Substring(6,$MobilePh.Length-11)) + "." + $MobilePh.substring($MobilePh.length - 4, 4)
                }

        $Phone = ($Phone.Substring(1,$Phone.Length-11)) + "." + ($Phone.Substring(6,$Phone.Length-11)) + "." + $Phone.substring($Phone.length - 4, 4)
        $Fax = ($Fax.Substring(1,$Fax.Length-11)) + "." + ($Fax.Substring(6,$Fax.Length-11)) + "." + $Fax.substring($Fax.length - 4, 4)



##User Verification by creator

        $Correct10 = Read-Host "Is all this information correct? [y/n]"
 
        if ($Correct10 -eq "y" -or $Correct10 -eq "Y") {
            


#Function for setting folder permission for a user

}
##Create Users Z drive and grant them full control ONLY WORKS WITH POWERSHELL 3
 
 
            
            
            New-Item -type directory -path "\\hardlinkpath\path"
            
            Start-Process  "C:\acl-grant.bat"
           
        

##CSV Creation for logging of what users information was sent to the New-ADUser cmdlet        
    #Create a Timestamp for CSV
            $a = Get-Date
            $Timestamp = "$a.Day" + "/" + "$a.Month" + "/" + "$a.Year" + " UT: " +"$a.ToUniversalTime()"

    #Add a place for the CSV to go
            $CurrentUser = [Environment]::UserName
            [system.io.directory]::CreateDirectory("C:\Users\$CurrentUser\Desktop\NewUsers") | Out-Null 

    #Now Add CSV creation/appending
                New-Object -TypeName PSCustomObject -Property @{
                    "Timestamp" = $Timestamp
                    "Username" = $User
                    "Last Name" = $Last
                    "First Name" = $First
                    "Department" = $Dept
                    "Job Title" = $Title
                    "Company" = $Company
                    "Address" = $Address
                    "State" = $Local
                    "City" = $ServCity
                    "Zip Code" = $Zip
                    "Extension" = $Ext
                    "Work Phone" = $Phone
                    "Mobile Phone" = $MobilePh
                    "Email Address" = $EmailAddress
                } | Export-Csv -Path "C:\Users\$CurrentUser\Desktop\NewUsers\Newuser $(((get-date).ToUniversalTime()).ToString("yyyyMMddThhmmssZ")).csv" -NoTypeInformation  <#-Append#> | Out-Null 




<##Chose OU Path based on service center and department, they are all the same, but can be changed if they need to be moved into other locations
   
   THIS IS THE SECOND FEILD THAT HAS TO BE CHANGED IF DEPARTMENT NAMES GET ADDED OR CHANGED!

#>
                switch ($Local){
                    "state" {
                            if ($Dept -eq "generic"){
                                    $Path = "OU=generic,OU=generic,DC=generic,DC=generic,DC=generic"
                                    }
                            elseif ($Dept -eq "generic"){
                                    $Path = "OU=generic,OU=generic,DC=generic,DC=generic,DC=generic"
                                    }
                            }
                     

                    "state" {
                            if ($Dept -eq "generic"){
                                    $Path = "OU=generic,OU=generic,DC=generic,DC=generic,DC=generic"
                                    }
                            elseif ($Dept -eq "generic"){
                                    $Path = "OU=generic,OU=generic,DC=generic,DC=generic,DC=generic"
                                    }
                            
                            }

                         
                  
                    default {
                        Write-Warning "An Error Has Occurred, where the department entered does not have a match
                         to the paths for which an end user should go. In this case the user will be in the New Users Organizational Unit (almost like a folder).
                         Please contact the administrator in order to convey this message."
                        break
                    }
                }


##Now Add New-ADUser Creation
                New-ADUser -Name $FullNameWS -AccountPassword (ConvertTo-SecureString -AsPlainText "Reset123" -Force) -ChangePasswordAtLogon $true -City $ServCity -Company $Company -Department $Dept -Description $Local -DisplayName $FullNameWS -EmailAddress $EmailAddress -Fax $Fax -GivenName $First -HomeDirectory \\leia\users\"$User" -HomeDrive "z" -Initials $MiddleI -MobilePhone $MobilePh <#-OfficePhone $Phone#> -Organization $Company -PostalCode $Zip -SamAccountName $User -State $local -StreetAddress $Address -Surname $Last -Title $Title -UserPrincipalName $EmailAddress -Path $Path <#-Confirm#> -PassThru | Enable-ADAccount
                Set-ADUser $User -Add @{otherTelephone=$Phone} 
        

##If no cell than it will add "no cell" to phone description
                if ( "0" -eq ($MobilePh | measure-object -character | select -expandproperty characters)){
                        Set-ADUser $User -Replace @{info='no cell'}
                        }


##Now Add Group Association to All Users!
                Add-ADGroupMember -Identity "General" -Members $User
                Add-ADGroupMember -Identity "Global" -Members $User



##Add more group associations based on location of service center
                    switch ($Local){
                            "state" {
                                    Add-ADGroupMember -Identity "state" -Members $User
                                    }
                            "state" {
                                    Add-ADGroupMember -Identity "state" -Members $User
                                    }
                            

                            default {
                                Write-Warning "An Error Has Occurred: State doesnt exist as a group"
                                break
                                }
                            }


<##Add more group associations based on department

   THIS IS THE THIRD AND FINAL LOOP THAT HAS TO BE CHANGED IF DEPARTMENT NAMES GET ADDED OR CHANGED!!!
#>
                    switch ($Dept)
                           {
                            "department" {
                                    Add-ADGroupMember -Identity "identity" -Members $User
                                    
                                         }
                            "department" {
                                    Add-ADGroupMember -Identity "identity" -Members $User
                                    }
                            "department" {
                                    Add-ADGroupMember -Identity "identity" -Members $User
 
                            default {
                                Write-Warning "An Error Has Occurred."
                                break
                                }
                            }


##Create a new mailbox in exchange
            #$Correct11 = Read-Host "Would you like to add a mailbox?"
            if ($Correct11 -eq "y" -or $Correct11 -eq "Y"){
                    $ErrorActionPreference = "SilentlyContinue"
                    add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
                    Enable-Mailbox -Identity $EmailAddress
                    }
                   


##Tell the user that the account creation has been done, but not nessasarily successfull (errors can happen in the backround with this script, so make sure user is created in New Users if possible)            
            Write-Host "New User Added"


##Added loop back and create another user afterwards if user wants to add a new user$Correct12 = Read-Host "Would you like to add another new user?"
            $Correct12 = Read-Host "Would you like to add a another new user?"
            if ($Correct12 -eq "y" -or $Correct12 -eq "Y"){
                    Write-Host "Okay Add a New User`n"
    #Waits 1 second before prompting the user for more input
                    Start-Sleep -s 1
                    continue serviceloop
                    }
            else{
                    Write-Host "`n Okay then. Goodbye.`n"
    #Waits 1 second before closing after saying goodbye
                    Start-Sleep -s 1
                    break
                    }     
                }


##This is if the user stated that the information in the preview was incorrect, and they would like to try again
        else{
                Write-Host "`n Retry Entering Information.`n"
                continue serviceloop
            }     
        
