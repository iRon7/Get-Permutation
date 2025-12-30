<!-- markdownlint-disable MD033 -->
# Get-Permutation

Generate permutations of a set.

## Syntax

```PowerShell
Get-Permutation
    [-InputObject <String[]>]
    [<CommonParameters>]
```

## Description

This function enumerates all possible permutations of a given set.

## Examples

### <a id="example-1"><a id="example-get-all-permutations-of-an-given-set">Example 1: Get all permutations of an given set</a></a>


```PowerShell
Get-Permutation -InputObject 'Alpha', 'Beta', 'Gamma' | ForEach-Object { "$_" }

Alpha Beta Gamma
Alpha Gamma Beta
Beta Alpha Gamma
Beta Gamma Alpha
Gamma Alpha Beta
Gamma Beta Alpha
```

### <a id="example-2"><a id="example-get-the-first-5-permutations-of-a-collection-of-5-numbers">Example 2: Get the first 5 permutations of a collection of 5 numbers</a></a>


```PowerShell
1..5 | Get-Permutation | ForEach-Object { "$_" } | Select-Object -First 5

1 2 3 4 5
1 2 3 5 4
1 2 4 3 5
1 2 4 5 3
1 2 5 3 4
```

## Parameters

### <a id="-inputobject">`-InputObject` <a href="https://docs.microsoft.com/en-us/dotnet/api/System.String[]">&lt;String[]&gt;</a></a>

The input collection to generate permutations for.

```powershell
Name:                       -InputObject
Aliases:                    # None
Type:                       [String[]]
Value (default):            # Undefined
Parameter sets:             # All
Mandatory:                  False
Position:                   # Named
Accept pipeline input:      False
Accept wildcard characters: False
```

## Related Links

* [wikipedia:Permutation#Generation_in_lexicographic_order](https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order)
* [Joel Bennett's how to implement `IEnumerator<T>` in PowerShell](https://gist.github.com/Jaykul/dfc355598e0f233c8c7f288295f7bb56)
<!-- -->


[1]: https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order "wikipedia:Permutation#Generation_in_lexicographic_order"
[2]: https://gist.github.com/Jaykul/dfc355598e0f233c8c7f288295f7bb56 "Joel Bennett's how to implement `IEnumerator<T>` in PowerShell"

[comment]: <> (Created with Get-MarkdownHelp: Install-Script -Name Get-MarkdownHelp)
