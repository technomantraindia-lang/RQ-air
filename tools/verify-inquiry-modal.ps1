# Verifies inquiry modal integration across all pages
$dir = Join-Path $PSScriptRoot '..\arkdin-html'
$files = Get-ChildItem -Path $dir -Filter '*.html' -File

$missingCss = @()
$missingJs = @()
$inquireCount = 0

foreach ($f in $files) {
    $c = Get-Content -Path $f.FullName -Raw
    if ($c -notmatch 'inquiry-modal\.css') { $missingCss += $f.Name }
    if ($c -notmatch 'inquiry-modal\.js') { $missingJs += $f.Name }
    $inquireCount += ([regex]::Matches($c, '>Inquire</a>')).Count
}

Write-Host "Pages total: $($files.Count)"
Write-Host "Inquire buttons found: $inquireCount"
if ($missingCss.Count) { Write-Host "MISSING CSS include: $($missingCss -join ', ')" } else { Write-Host "CSS include OK on all pages" }
if ($missingJs.Count)  { Write-Host "MISSING JS include: $($missingJs -join ', ')" } else { Write-Host "JS include OK on all pages" }

# Show sample from service-details.html
Write-Host "`n--- service-details.html includes ---"
Select-String -Path (Join-Path $dir 'service-details.html') -Pattern 'inquiry-modal' | ForEach-Object { $_.Line.Trim() }