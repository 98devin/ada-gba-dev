#! /usr/bin/env pwsh

param (
    [Parameter(ValueFromRemainingArguments)]
    [String[]] $FilePath,

    [switch] $Clear
)

if ($Clear) {
    Write-Output "Clearing artifacts from $FilePath"
    Get-ChildItem $FilePath | Where-Object Extension -in ".bin", ".s", ".sym", ".gba" | Remove-Item
    return
}

foreach ($Exe in Get-ChildItem $FilePath | Where-Object Extension -eq "") {

    $BinFileName = "$FilePath/$($Exe.Name).bin"
    $AsmFileName = "$FilePath/$($Exe.Name).s"
    $SymFileName = "$FilePath/$($Exe.Name).sym"
    $GbaFileName = "$FilePath/$($Exe.Name).gba"

    Write-Output "Building artifacts for $($Exe.Name)"
    arm-eabi-objcopy -O binary $Exe.FullName $BinFileName
    arm-eabi-objdump -dS $Exe.FullName > $AsmFileName
    arm-eabi-objdump -t $Exe.FullName > $SymFileName

    cp $BinFileName $GbaFileName
    gbafix $GbaFileName

}