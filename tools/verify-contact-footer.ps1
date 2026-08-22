# Verifies every page (except contact.html) contains the exact contact.html footer block.
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..\arkdin-html'
$contact = Get-Content (Join-Path $root 'contact.html') -Raw
if ($contact -notmatch '(?s)<footer class="cs_footer.*?</footer>') { throw 'Footer not found in contact.html' }
$ref = $Matches[0]

$files = Get-ChildItem -Path $root -Filter '*.html' | Where-Object { $_.Name -ne 'contact.html' }
$fail = 0
foreach ($f in $files) {
    $c = Get-Content $f.FullName -Raw
    if ($c -match '(?s)<footer class="cs_footer.*?</footer>') {
        if ($Matches[0] -ne $ref) { Write-Output ('MISMATCH: ' + $f.Name); $fail++ }
    }
    else { Write-Output ('NO FOOTER: ' + $f.Name); $fail++ }
}
if ($fail -eq 0) { Write-Output ('ALL ' + $files.Count + ' PAGES MATCH CONTACT FOOTER') }