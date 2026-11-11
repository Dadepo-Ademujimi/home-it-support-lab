# Creates one global security group per department in OU=Groups
# and adds members based on each user's Department attribute.

foreach ($d in "Finance", "Sales", "IT", "HR") {
    if (-not (Get-ADGroup -Filter "Name -eq 'GG_$d'")) {
        New-ADGroup -Name "GG_$d" -GroupScope Global -GroupCategory Security -Path "OU=Groups,DC=lab,DC=local"
    }
    Add-ADGroupMember -Identity "GG_$d" -Members (Get-ADUser -Filter "Department -eq '$d'")
}
