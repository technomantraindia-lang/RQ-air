# Adds inquiry modal CSS + JS includes to all HTML pages in arkdin-html
$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot '..\arkdin-html'
$files = Get-ChildItem -Path $dir -Filter '*.html' -File

$cssTag  = '    <link rel="stylesheet" href="assets/css/inquiry-modal.css">'
$jsTag   = '    <script src="assets/js/inquiry-modal.js"></script>'

$updated = 0
foreach ($f in $files) {
    $content = Get-Content -Path $f.FullName -Raw
    $changed = $false

    # Add CSS after style.css link if not present
    if ($content -notmatch 'inquiry-modal\.css') {
        $content = $content -replace '(<link rel="stylesheet" href="assets/css/style\.css">)', "`$1`r`n$cssTag"
        $changed = $true
    }

    # Add JS after main.js include if not present
    if ($content -notmatch 'inquiry-modal\.js') {
        $content = $content -replace '(<script src="assets/js/main\.js"></script>)', "`$1`r`n$jsTag"
        $changed = $true
    }

    if ($changed) {
        Set-Content -Path $f.FullName -Value $content -NoNewline
        Write-Host "Updated: $($f.Name)"
        $updated++
    } else {
        Write-Host "Skipped (already has includes): $($f.Name)"
    }
}
Write-Host "`nDone. $updated file(s) updated."