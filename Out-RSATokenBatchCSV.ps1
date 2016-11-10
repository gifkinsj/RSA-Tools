function Out-RSATokenBatchCSV {
 
# The purpose of this cmdlet is to produce a CSV for bulk creating users, and 
# then assigning said users to tokens which have been loaded into the RSA AM
# system. An example of the cmdlet is as follows:
#
# Out-RSATokenBatchCSV -filename batch.txt -firstNumber 17447 -lastNumber 19946
#
# The token serial numbers are prepended with leadng 0's (to ensure names are
# accurate.
#
# A CSV will then be created for importing into RSA AM using the Bulk Admin 
# library supplied by RSA.
#

PARAM(
[string]$filename,
[int]$firstNumber,
[int]$lastNumber 
)

$lastToken = $lastNumber + 1

New-Item -ItemType File -Name $filename

Add-Content $filename "Action,IdentitySource,DefLogin,FirstName,LastName,SecurityDomain,ReplTokSerial,TokEnabled,PinMode"

Do { 
    
    $ppFirstNumber = $firstNumber.ToString("000000000000")
    #Add "AU" (Add User) Record to CSV
    Add-Content $filename "AU,internal database,$ppfirstNumber,$ppfirstNumber,$ppfirstNumber,TSBToken,,,"
    #Add "ATU" (Assign token to user) record to CSV
    Add-Content $filename "ATU,internal database,$ppfirstNumber,$ppfirstNumber,$ppfirstNumber,,$ppfirstNumber,1,0"
    $firstNumber++

    Write-Progress -Activity "Creating CSV file..." 

        } while($firstNumber -ne $lastToken)

}
