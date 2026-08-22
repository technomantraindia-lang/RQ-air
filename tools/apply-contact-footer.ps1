# Applies the contact.html footer block to every other HTML page.
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..\arkdin-html'
$contactPath = Join-Path $root 'contact.html'
$contact = Get-Content $contactPath -Raw

# Extract the full footer block from contact.html
if ($contact -notmatch '(?s)(<footer class="cs_footer.*?</footer>)') {
    throw 'Footer block not found in contact.html'
}
$footerBlock = $Matches[1].Replace('$', '$$')

$files = Get-ChildItem -Path $root -Filter '*.html' | Where-Object { $_.Name -ne 'contact.html' }
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '(?s)<footer class="cs_footer.*?</footer>') {
        $newContent = [regex]::Replace($content, '(?s)<footer class="cs_footer.*?</footer>', $footerBlock)
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Output ("Updated: " + $file.Name)
    }
    else {
        Write-Output ("NO FOOTER FOUND: " + $file.Name)
    }
}
Write-Output 'Done.'