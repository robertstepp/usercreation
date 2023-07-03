Add-Type -AssemblyName System.Windows.Forms

# Define the domain name
$domainName = "test.com"
$passwordLength = 32
$nonAlphachar = 8

# Dot-source the passwordgenerator.ps1 file
. .\passwordgenerator.ps1

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "User Creation"
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.StartPosition = "CenterScreen"

# Create labels and textboxes for first name, last name, and employee number
$labelFirstName = New-Object System.Windows.Forms.Label
$labelFirstName.Location = New-Object System.Drawing.Point(10, 20)
$labelFirstName.Size = New-Object System.Drawing.Size(80, 20)
$labelFirstName.Text = "First Name:"
$form.Controls.Add($labelFirstName)

$textBoxFirstName = New-Object System.Windows.Forms.TextBox
$textBoxFirstName.Location = New-Object System.Drawing.Point(100, 20)
$textBoxFirstName.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($textBoxFirstName)

$labelLastName = New-Object System.Windows.Forms.Label
$labelLastName.Location = New-Object System.Drawing.Point(10, 50)
$labelLastName.Size = New-Object System.Drawing.Size(80, 20)
$labelLastName.Text = "Last Name:"
$form.Controls.Add($labelLastName)

$textBoxLastName = New-Object System.Windows.Forms.TextBox
$textBoxLastName.Location = New-Object System.Drawing.Point(100, 50)
$textBoxLastName.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($textBoxLastName)

$labelEmployeeNumber = New-Object System.Windows.Forms.Label
$labelEmployeeNumber.Location = New-Object System.Drawing.Point(10, 80)
$labelEmployeeNumber.Size = New-Object System.Drawing.Size(80, 30)
$labelEmployeeNumber.Text = "Employee Number:"
$form.Controls.Add($labelEmployeeNumber)

$textBoxEmployeeNumber = New-Object System.Windows.Forms.TextBox
$textBoxEmployeeNumber.Location = New-Object System.Drawing.Point(100, 80)
$textBoxEmployeeNumber.Size = New-Object System.Drawing.Size(150, 20)
$form.Controls.Add($textBoxEmployeeNumber)

# Create Add and Cancel buttons
$buttonAdd = New-Object System.Windows.Forms.Button
$buttonAdd.Location = New-Object System.Drawing.Point(50, 120)
$buttonAdd.Size = New-Object System.Drawing.Size(75, 23)
$buttonAdd.Text = "Add"
$buttonAdd.Add_Click({
    # Create Active Directory user account
    $firstName = $textBoxFirstName.Text
    $lastName = $textBoxLastName.Text
    $username = $firstName.Substring(0, 1) + $lastName.Substring(0, [Math]::Min(7, $lastName.Length))
    $displayName = $firstName + " " + $lastName
    $employeeID = [int]$textBoxEmployeeNumber.Text

    # Generate a random password
    $password = New-UserCreationRandomPassword -Length $passwordLength -NonAlpha $nonAlphachar

    Write-Host $username
    Write-Host $displayName
    Write-Host $password
    Write-Host $employeeID

    # Add code to create Centrify user account using $username, $displayName, and $password
    # Example command: Add-CdmUser -Name $displayName -UserID $username -Password $password -Domain "Default Domain"

    # Add code to create Active Directory user account using $username, $displayName, and $password
    $securePassword = $password
    $userParams = @{
        Name = $displayName
        SamAccountName = $username
        DisplayName = $displayName
        GivenName = $firstName
        Surname = $lastName
        AccountPassword = $securePassword
        Enabled = $false
        UserPrincipalName = "$username@$domainName"
    }
    #New-ADUser @userParams

    # Close the form
    $form.Close()
})
$form.Controls.Add($buttonAdd)

$buttonCancel = New-Object System.Windows.Forms.Button
$buttonCancel.Location = New-Object System.Drawing.Point(150, 120)
$buttonCancel.Size = New-Object System.Drawing.Size(75, 23)
$buttonCancel.Text = "Cancel"
$buttonCancel.Add_Click({
    # Close the form
    $form.Close()
})
$form.Controls.Add($buttonCancel)

# Show the form
$form.ShowDialog() | Out-Null
