$thumb = 'EB9C6BA38638528EFD86CEC47722234040FB6A86'
$cert = Get-Item "Cert:\CurrentUser\My\$thumb" -ErrorAction SilentlyContinue
if (-not $cert) {
    Write-Host "Creating new cert..."
    $cert = New-SelfSignedCertificate -Subject "CN=Tezarre Gaming" -Type CodeSigning -CertStoreLocation "Cert:\CurrentUser\My" -HashAlgorithm SHA256 -NotAfter (Get-Date).AddYears(5)
}
Write-Host "Using cert: $($cert.Subject)"
$result = Set-AuthenticodeSignature -FilePath "d:\Tezarre-TK63-win32-x64\installer\Tezarre-TK63-Setup.exe" -Certificate $cert -HashAlgorithm SHA256
Write-Host "Sign result: $($result.Status)"
$bytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
[System.IO.File]::WriteAllBytes("d:\Tezarre-TK63-win32-x64\installer\TezarreGaming.cer", $bytes)
Write-Host "Certificate exported to TezarreGaming.cer"
