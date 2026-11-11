# Creates the top-level OUs for the lab.local domain.
# Run on DC01 in an elevated PowerShell session.

"Workstations", "Staff", "Groups" | ForEach-Object {
    New-ADOrganizationalUnit -Name $_ -Path "DC=lab,DC=local"
}
