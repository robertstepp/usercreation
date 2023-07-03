# Function to generate a random password
function New-UserCreationRandomPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(8, 64)]
        [int]$Length
    )

    $uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $lowercase = "abcdefghijklmnopqrstuvwxyz"
    $numbers = "0123456789"
    $specialCharacters = "!@#$%^&*()_+"

    $password = ""

    # Ensure at least one character from each character type
    $password += ($uppercase | Get-Random -Count 1)
    $password += ($lowercase | Get-Random -Count 1)
    $password += ($numbers | Get-Random -Count 1)
    $password += ($specialCharacters | Get-Random -Count 1)

    # Generate remaining characters
    $remainingLength = $Length - 4
    $characters = $uppercase + $lowercase + $numbers + $specialCharacters
    $password += ($characters | Get-Random -Count $remainingLength)

    # Shuffle the password
    $password = (ConvertTo-SecureString( -String ($password.ToCharArray() | Get-Random -Count $Length) -join "") -AsPlainText -Force)

    return $password
}