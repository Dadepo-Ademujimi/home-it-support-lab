# Bulk-creates 20 lab users in OU=Staff across four departments.
# Run on DC01 as a saved script (.ps1), so Read-Host works correctly.
# Skips users who already exist and prints a result line per user.

$pw = Read-Host "Initial password for all users" -AsSecureString

$staff = "John,Smith,Finance", "Amy,Jones,Finance", "Priya,Shah,Finance", "Tom,Reid,Finance", "Grace,Okafor,Finance",
         "Kiran,Patel,Sales", "Liam,Brown,Sales", "Sophie,Clark,Sales", "Daniel,Evans,Sales", "Chloe,Hughes,Sales",
         "Ben,Carter,IT", "Fatima,Ali,IT", "Ryan,Walsh,IT", "Emma,Wood,IT", "Joe,Murray,IT",
         "Hannah,Lee,HR", "Sam,Taylor,HR", "Olivia,King,HR", "Adam,Scott,HR", "Zara,Hussain,HR"

foreach ($s in $staff) {
    $f, $l, $d = $s.Split(",")
    $sam = ($f.Substring(0, 1) + $l).ToLower()

    if (Get-ADUser -Filter "SamAccountName -eq '$sam'") {
        Write-Host "$sam already exists - skipped" -ForegroundColor Yellow
    }
    else {
        New-ADUser -Name "$f $l" -GivenName $f -Surname $l -SamAccountName $sam `
            -UserPrincipalName "$sam@lab.local" -Department $d `
            -Path "OU=Staff,DC=lab,DC=local" -AccountPassword $pw -Enabled $true
        Write-Host "Created $sam" -ForegroundColor Green
    }
}
