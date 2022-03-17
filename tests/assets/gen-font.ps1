
using namespace System
using namespace System.Text

param (
    [String] $HexFile,
    [String] $OutFile
)

[UInt32[]] $desiredChars = (0 .. 127)
[byte[]] $outputBin = [byte[]]::new(0)


function ReverseBits ([byte] $b) {
    [byte[]] $lookup = ( 0x0, 0x8, 0x4, 0xc, 0x2, 0xa, 0x6, 0xe, 0x1, 0x9, 0x5, 0xd, 0x3, 0xb, 0x7, 0xf )
    return ($lookup[$b -band 0b1111] -shl 4) -bor ($lookup[$b -shr 4])
}


foreach ($line in [System.IO.File]::ReadLines($HexFile)) {

    $codePoint, $data = $line.Split(":")

    $codePoint = [Convert]::ToUInt32($codePoint, 16)

    if ($desiredChars.Contains($codePoint)) {
        Write-Output "$codePoint - $data"
        for ($i = 0; $i -lt $data.Length; $i += 2) {
            $outputBin += ReverseBits([Convert]::ToByte($data.SubString($i, 2), 16))
        }
    }

}

[System.IO.File]::WriteAllBytes($OutFile, $outputBin)