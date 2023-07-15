BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
# Test cases
Describe 'Assert-Condition' {
    Context 'When DebugPreference is not SilentlyContinue and the condition is true' {
        It 'Should output the provided message' {
            Mock -CommandName 'Get-Variable' -MockWith { return 'Continue' } -ParameterFilter { $Name -eq 'DebugPreference' }
            { Assert-Condition -Condition ($true) -Message 'Assertion failed: Test error message' } |
                Should -StartWith 'Assertion failed:'
        }
    }

    Context 'When DebugPreference is SilentlyContinue and the condition is false' {
        It 'Should not output message' {
            Mock -CommandName 'Get-Variable' -MockWith { return 'SilentlyContinue' } -ParameterFilter { $Name -eq 'DebugPreference' }
            { Assert-Condition -Condition ($false) -Message 'Assertion failed: Test error message' } |
                Should -Not -Throw
        }
    }
}

Describe 'Get-Square' {
    Context 'When the input number is positive' {
        It 'Should return the square of the input number' {
            Get-Square -num 4 | Should -Be 16
        }
    }

    Context 'When the input number is zero' {
        It 'Should return zero' {
            Get-Square -num 0 | Should -Be 0
        }
    }

    Context 'When the input number is negative' {
        It 'Should output an message stating that the Assertion failed: input must not be a negative number' {
            Mock -CommandName 'Get-Variable' -MockWith { return 'Continue' } -ParameterFilter { $Name -eq 'DebugPreference' }
            { Get-Square -num -4 } |
                Should -StartWith 'Assertion failed:'
        }
    }
}
