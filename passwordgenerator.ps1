# Function to generate a random password
function New-UserCreationRandomPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int]$Length,
        [int]$NonAlpha
    )

    # Shuffle the password
    $password = ConvertTo-SecureString -String ([System.Web.Security.Membership]::GeneratePassword($Length,$NonAlpha)) -AsPlainText -Force
    return $password
}