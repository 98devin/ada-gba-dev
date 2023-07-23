#! /usr/bin/env pwsh

param (
    [Parameter(ValueFromRemainingArguments)]
    [String[]] $FilePath,

    [switch] $Clear
)


ForEach ($Exe in Get-ChildItem -Path $FilePath -Exclude *.*) {

    $BinFileName = "$FilePath/$($Exe.Name).bin"
    $AsmFileName = "$FilePath/$($Exe.Name).s"
    $SymFileName = "$FilePath/$($Exe.Name).sym"
    $GbaFileName = "$FilePath/$($Exe.Name).gba"


    if ($Clear) {
        Write-Output "Clearing artifacts for $($Exe.Name)"
        {
            Test-Path $BinFileName && Remove-Item $BinFileName
            Test-Path $AsmFileName && Remove-Item $AsmFileName
            Test-Path $SymFileName && Remove-Item $SymFileName
            Test-Path $GbaFileName && Remove-Item $GbaFileName
        } | Out-Null
    } else {
        Write-Output "Building artifacts for $($Exe.Name)"
        arm-eabi-objcopy -O binary $Exe.FullName $BinFileName
        arm-eabi-objdump -dS $Exe.FullName > $AsmFileName
        arm-eabi-objdump -t $Exe.FullName > $SymFileName

        cp $BinFileName $GbaFileName
        gbafix $GbaFileName
    }

}