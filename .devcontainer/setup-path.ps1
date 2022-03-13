Write-Output >> $profile @'

foreach ($alire_lib in Get-ChildItem /alire) {
    $env:PATH += ":$($alire_lib.FullName)/bin"
}

'@
