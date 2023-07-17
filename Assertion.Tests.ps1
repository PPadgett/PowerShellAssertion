 BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
# Test cases
Describe 'Assert-Condition' {
    Context 'When DebugPreference is not SilentlyContinue and the condition is true' {
        BeforeAll {
            $DebugPreference = 'Continue'
        }

        It 'Should throw an error with the provided message' {
            { Assert-Condition -Condition ($true) -Message 'Test error message' } |
                Should -Throw -ExpectedMessage 'Assertion failed: Test error message'
        }
    }

    Context 'When DebugPreference is SilentlyContinue or the condition is false' {
        BeforeAll {
            $DebugPreference = 'SilentlyContinue'
        }

        It 'Should not throw an error' {
            { Assert-Condition -Condition ($false) -Message 'Test error message' } |
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
        BeforeAll {
            $DebugPreference = 'Continue'
        }

        It 'Should throw an error stating that the input must not be a negative number' {
            { Get-Square -num -4 } |
                Should -Throw -ExpectedMessage 'Assertion failed: Input must not be a negative number.'
        }
    }
}
0 comments on commit 6998549
