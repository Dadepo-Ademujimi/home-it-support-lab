# Home IT Support Lab

A small Windows network I built to practise real service desk work: setting up a domain, joining computers, and fixing common faults.

## Setup
- DC01: Windows Server 2025, Active Directory domain lab.local
- WS01: Windows 11 Enterprise client, joined to the domain
- Running on VMware Workstation (NAT network 192.168.59.0/24)

## Stage 1: Build and join
1. Installed Windows Server and promoted it to a domain controller, with DNS and internet forwarders
2. Created OUs: Workstations, Staff, Groups
3. Created 20 users and 4 groups (Finance, Sales, IT, HR) with PowerShell
4. Set up Group Policy: password and lockout policy, S: mapped drive, and a Sales-only desktop lockdown
5. Joined WS01 to the domain and logged in as a domain user; confirmed each policy with gpresult

## Fault 1: User logged into a temporary profile
- **Symptom:** "We can't sign in to your account"; empty desktop and Documents, so the user thought their files were gone
- **Cause:** the user's profile folder had been renamed, so it no longer matched the registry. Event Viewer showed IDs 1511 and 1515, and Windows had renamed the profile's registry key to .bak
- **Fix:** confirmed which registry key belonged to the user, removed .bak, set State to 0, renamed the folder back, restarted, deleted the leftover TEMP folder
- **Ticket:** INC-001 logged with priority (P3), evidence, root cause, resolution and prevention

## Coming next
- Fault 2: printer not printing (Print Spooler)
- Fault 3: Windows Update failing because of a bad Group Policy setting
- Fault 4: user can open but not save files on a shared folder
- Fault 5: BitLocker recovery key
- Account lockout and password reset

## What I learned
- DNS is everything in a domain: the client must point at the domain controller, or it can't join
- Event Viewer IDs lead you straight to the cause. 1511 and 1515 together mean a profile mismatch
- Check before you change: there were two similar registry keys, and only one belonged to the affected user
