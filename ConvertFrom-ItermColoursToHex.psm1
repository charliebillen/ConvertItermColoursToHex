$Script:colourNames = [ordered]@{
    'Ansi 0 Color' = 'Black'
    'Ansi 1 Color' = 'Red'
    'Ansi 2 Color' = 'Green'
    'Ansi 3 Color' = 'Yellow'
    'Ansi 4 Color' = 'Blue'
    'Ansi 5 Color' = 'Magenta'
    'Ansi 6 Color' = 'Cyan'
    'Ansi 7 Color' = 'White'
    'Ansi 8 Color' = 'Bright Black'
    'Ansi 9 Color' = 'Bright Red'
    'Ansi 10 Color' = 'Bright Green'
    'Ansi 11 Color' = 'Bright Yellow'
    'Ansi 12 Color' = 'Bright Blue'
    'Ansi 13 Color' = 'Bright Magenta'
    'Ansi 14 Color' = 'Bright Cyan'
    'Ansi 15 Color' = 'Bright White'
    'Background Color' = 'Background'
    'Foreground Color' = 'Text'
    'Bold Color' = 'Bold Text'
    'Selection Color' = 'Selection Background'
    'Selected Text Color' = 'Selected Foregrond'
    'Cursor Color' = 'Cursor Background'
    'Cursor Text Color' = 'Cursor Foreground'
}

function ConvertFrom-ItermColoursToHex {
    <#
    .SYNOPSIS
    Converts an SRGB iTerm colour scheme to hex RGB values

    .DESCRIPTION
    Converts an SRGB iTerm colour scheme to hex RGB values

    .PARAMETER InputXml
    The content of the colour scheme as an XmlDocument

    .INPUTS
    XmlDocument

    .OUTPUTS
    PSCustomObject

    .EXAMPLE
    ConvertFrom-ItermColoursToHex -InputXml [xml](Get-Content '.\colourscheme.itermcolors)

    .EXAMPLE
    [xml](Get-Content '.\colourscheme.itermcolors) | ConvertFrom-ItermColoursToHex

    .LINK
    https://github.com/charliebillen/ConvertItermColoursToHex
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [xml]
        $InputXml
    )

    process {
        foreach ($key in $InputXml.GetElementsByTagName('key')) {
            $mappedName = $Script:colourNames[$key.InnerText]

            if (-not $mappedName) {
                continue
            }

            [pscustomobject]@{
                Name = $mappedName
                Colour = Get-HexFromXml $key.NextSibling
            }
        }
    }
}

function Get-HexFromXml($Xml) {
    [int]$r = 0; [int]$g = 0; [int]$b = 0

    foreach ($node in $Xml.ChildNodes) {
        if ($node.InnerText -match 'red') {
            $r = 255 * [double]($node.NextSibling.InnerText)
        }

        if ($node.InnerText -match 'green') {
            $g = 255 * [double]($node.NextSibling.InnerText)
        }

        if ($node.InnerText -match 'blue') {
            $b = 255 * [double]($node.NextSibling.InnerText)
        }
    }

    "#{0:X2}{1:X2}{2:X2}" -f $r, $g, $b
}

Export-ModuleMember -Function ConvertFrom-ItermColoursToHex
