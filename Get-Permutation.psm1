<#PSScriptInfo
.Version 0.1.3
.Guid 19631007-5360-4a0e-86d4-e90ea9a08246
.Author Ronald Bode (iRon)
.CompanyName
.Copyright
.Tags Permutation Combination Collection Enumerate
.License https://github.com/iRon7/Get-Permutation/LICENSE.txt
.ProjectUri https://github.com/iRon7/Get-Permutation
.Icon https://raw.githubusercontent.com/iRon7/Get-Permutation/master/Get-Permutation.png
.ExternalModuleDependencies
.RequiredScripts
.ExternalScriptDependencies
.ReleaseNotes
.PrivateData
#>

using namespace System.Collections
using namespace System.Collections.Generic

Class Permutations : IEnumerator {
    [ICollection] $c    # Collection
    [int[]] $a          # Indices
    [int] $i            # Iteration

    Permutations([int]$Size) {
        $this.a = [int[]](0..($Size - 1))
    }

    Permutations([ICollection]$Collection) {
        $this.a = [int[]](0..($Collection.Count - 1))
        $this.c = $Collection
    }

    [object]get_Current() {
        if ($null -eq $this.c) { return $this.a }
        else { return $this.a.foreach{ $this.c[$_] } }
    }

    [bool] MoveNext() {
        # use the initial permutation on the first call to MoveNext
        if (-not $this.i++) { return $true }
        if ($this.a.Count -le 1) { $this.Reset(); return $false }
        # Find the largest index k such that a[k] < a[k + 1]. If no such index exists, the permutation is the last permutation.
        for ($k = $this.a.Count - 2; $this.a[$k] -gt $this.a[$k + 1]; $k--) { if (-not $k) { $this.Reset(); return $false } }
        # Find the largest index l greater than k such that a[k] < a[l].
        for ($l = $this.a.Count - 1; $l -ge 0; $l--) { if ($this.a[$k] -lt $this.a[$l]) { break } }
        # Swap the value of a[k] with that of a[l].
        $this.a[$k], $this.a[$l] = $this.a[$l], $this.a[$k]
        # Reverse the sequence from a[k + 1] up to and including the final element a[n].
        [Array]::Reverse($this.a, ($k + 1), ($this.a.Count - $k - 1))
        return $true
    }

    [void] Reset() {
        $this.a = [int[]](0..($this.a.Count - 1))
        $this.i = 0
    }

    [void] Dispose() {}
}

class Permutation : Permutations, IEnumerator[int] {
    Permutation($SizeOrSet) : base($SizeOrSet) { }
    [Int]get_Current() { return $this }
}

function Get-Permutation {
    <#
.SYNOPSIS
Generate permutations of a set.

.DESCRIPTION
This function enumerates all possible permutations of a given set.

.EXAMPLE
# Get all permutations of an given set

    Get-Permutation -InputObject 'Alpha', 'Beta', 'Gamma' | ForEach-Object { "$_" }

    Alpha Beta Gamma
    Alpha Gamma Beta
    Beta Alpha Gamma
    Beta Gamma Alpha
    Gamma Alpha Beta
    Gamma Beta Alpha

.EXAMPLE
# Get the first 5 permutations of a collection of 5 numbers

    1..5 | Get-Permutation | ForEach-Object { "$_" } | Select-Object -First 5

    1 2 3 4 5
    1 2 3 5 4
    1 2 4 3 5
    1 2 4 5 3
    1 2 5 3 4

.PARAMETER InputObject

The input collection to generate permutations for.

.LINK
[1]: https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order "wikipedia:Permutation#Generation_in_lexicographic_order"
[2]: https://gist.github.com/Jaykul/dfc355598e0f233c8c7f288295f7bb56 "Joel Bennett's how to implement `IEnumerator<T>` in PowerShell"
#>
    param(
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$InputObject
    )

    if ($Input) { ,[Permutation]$Input } else { ,[Permutation]$InputObject }
}

Export-ModuleMember -Function Get-Permutation

# https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_classes#exporting-classes-with-type-accelerators
$TypeAcceleratorsClass = [PSObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')

if ('Permutations' -notin $ExistingTypeAccelerators.Keys) { $TypeAcceleratorsClass::Add('Permutations', [Permutations]) }
if ('Permutation'  -notin $ExistingTypeAccelerators.Keys) { $TypeAcceleratorsClass::Add('Permutation',  [Permutation]) }
