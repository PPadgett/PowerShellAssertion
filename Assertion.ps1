function Assert-Condition {
  <#
  .SYNOPSIS
      Asserts if a given condition is met, throwing an error message if the condition is not met and DebugPreference is set to 'Continue' or 'Inquire'.
  
  .DESCRIPTION
      The Assert-Condition function checks if the provided condition is met, based on the DebugPreference. If the DebugPreference is 'Continue' or 'Inquire', 
      the function checks the provided condition and throws an error message if the condition is not met.
  
  .PARAMETER Condition
      A boolean condition to be checked by the function. This is a mandatory parameter.
  
  .PARAMETER Message
      A string message that will be displayed if the condition is not met and DebugPreference is set to 'Continue' or 'Inquire'. This is a mandatory parameter.
  
  .EXAMPLE
      Assert-Condition -Condition ($variable -eq $null) -Message "Variable cannot be null"
  
      This example will check if $variable is null. If it is, it will throw the error message "Variable cannot be null".
  
  .INPUTS
      System.Boolean, System.String
  
  .OUTPUTS
      System.Management.Automation.ErrorRecord (if assertion fails)
  
  .NOTES
      The DebugPreference is a shell variable that determines how Windows PowerShell responds to debug statements 
      that are generated by a script or a cmdlet. 
      DebugPreference variable settings:
          'SilentlyContinue' - no effect
          'Stop' - the Debug statements are displayed and the script stop.
          'Continue' - the Debug statements are displayed and the script continues to run.
          'Inquire' - the Debug statements are displayed and you are prompted to continue.
  #>
  param(
      [Parameter(Mandatory = $true)]
      [bool]
      $Condition,  # Boolean condition that will be checked

      [Parameter(Mandatory = $true)]
      [string]
      $Message  # Error message to display if condition is not met
  )

    # If the hash code is not 0 (meaning the DebugPreference is 'Stop', 'Continue' or 'Inquire'), the function will check the condition
    if ($DebugPreference.GetHashCode() -ne 0) {
        # If the condition is met (is true), it will throw the provided message, otherwise it will not do anything ($null)
        $Condition ? throw "Assertion failed: $Message" : $null
    }
}

function Get-Square {
    param(
        [Parameter(Mandatory=$true)]
        [int]$num
    )
    Assert-Condition ($num -lt 0) "Input must not be a negative number."
    
    $result = $num * $num
    return $result
}

# Call the function with a positive number
Write-Output (Get-Square 4)  # Output: 16

# Call the function with a negative number
$DebugPreference = 'Continue'
Write-Output (Get-Square -4) # Output: Input mu
