#Requires -Modules @{ModuleName="Pester"; ModuleVersion="5.5.0"}

using namespace System.Collections
using namespace System.Collections.Generic

[Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssignments', '', Justification = 'False positive')]
param()

Describe 'Use-ClassAccessors' {

    BeforeAll {

        Set-StrictMode -Version Latest
        Import-Module .\Get-Permutation.psm1

    }

    Context 'Load Check' {

        It 'Help' {
            Get-Permutation -? | Out-String -Stream | Should -Contain SYNOPSIS
        }
    }

    Context 'Class' {

        BeforeAll {
            . Get-Permutation
        }

        It "Set with a size of 4" {
            $Permutations = [Permutation]4
            $Permutations | Should -HaveCount 24
            $Permutations | Select-Object -Index 4 | ForEach-Object { "$_" } | Should -Be '0 3 1 2'
            $Permutations.Reset()
            $Permutations | Select-Object -Index 4 | ForEach-Object { "$_" } | Should -Be '0 3 1 2'
        }

        It "Indexer for the size 1 to 6" -ForEach (1..6) {
            $IsUnique = [HashSet[String]]::new()
            $Permutations = [Permutation]$_
            foreach ($Permutation in $Permutations) {
                $IsUnique.Add("$Permutation") | Should -BeTrue
            }

            For (($i = 1), ($Factorial = 1); $i -le $_; $i++) { $Factorial *= $i }
            @($Permutations) | Should -HaveCount $Factorial
        }
    }

    Context 'Function' {

        It "A specific set: 'a', 'b', 'c', 'd'" {
            $Permutations = 'a', 'b', 'c', 'd' | Get-Permutation
            $Permutations | Should -HaveCount 24
            $Permutations | Select-Object -Index 4 | ForEach-Object { "$_" } | Should -Be 'a d b c'
        }

        It "A collection with 1 to 6 items" -ForEach (1..6) {
            $IsUnique = [HashSet[String]]::new()
            $Permutations = 1..$_ | Get-Permutation
            foreach ($Permutation in $Permutations) {
                $IsUnique.Add("$Permutation") | Should -BeTrue
            }

            For (($i = 1), ($Factorial = 1); $i -le $_; $i++) { $Factorial *= $i }
            @($Permutations) | Should -HaveCount $Factorial
        }
    }
}
