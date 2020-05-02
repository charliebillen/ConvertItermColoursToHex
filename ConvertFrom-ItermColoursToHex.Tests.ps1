Import-Module $PSScriptRoot\ConvertFrom-ItermColoursToHex.psm1

function Get-XmlWithKey ($key) {
    [xml]@"
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
        <dict>
            <key>$key</key>
            <dict>
                <key>Color Space</key>
                <string>sRGB</string>
                <key>Blue Component</key>
                <real>0</real>
                <key>Green Component</key>
                <real>0.6</real>
                <key>Red Component</key>
                <real>0.6</real>
            </dict>
        </dict>
    </plist>
"@
}

Describe 'ConvertFrom-ItermColoursToHex' {
    Context 'given keys that map to colour names' {
        It 'returns names and colours in hex format' {
            $inputXml = Get-XmlWithKey 'Ansi 1 Color'

            $colours = $inputXml | ConvertFrom-ItermColoursToHex

            $colours.Name | Should -Be 'Red'
            $colours.Colour | Should -Be '#999900'
        }
    }

    Context 'given keys that do not map to colour names' {
        It 'returns nothing' {
            $inputXml = Get-XmlWithKey 'Not a known colour'

            $colours = $inputXml | ConvertFrom-ItermColoursToHex

            $colours | Should -BeNullOrEmpty
        }
    }
}
