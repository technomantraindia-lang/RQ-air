# Replace header nav button text "Read More" -> "Inquire" across all pages.
# Only targets the button inside .cs_main_header_right (the navbar CTA).
$ErrorActionPreference = 'Stop'

$dir = Join-Path $PSScriptRoot '..\arkdin-html'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$utf8Bom   = New-Object System.Text.UTF8Encoding($true)

$pattern = '(<div class="cs_main_header_right">\s*<a href="contact\.html" class="cs_btn cs_style_1">\s*<span>\s*)Read More(\s*</span>)'

Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $path = $_.FullName
    $bytes  = [System.IO.File]::ReadAllBytes($path)
    $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    $enc    = if ($hasBom) { $utf8Bom } else { $utf8NoBom }

    $text    = [System.IO.File]::ReadAllText($path)
    $updated = [regex]::Replace($text, $pattern, '${1}Inquire${2}')

    if ($updated -ne $text) {
        [System.IO.File]::WriteAllText($path, $updated, $enc)
        Write-Output "Updated: $($_.Name)"
    } else {
        Write-Output "No header match: $($_.Name)"
    }
}

Write-Output "--- Verification (Inquire occurrences) ---"
Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $matches2 = Select-String -Path $_.FullName -Pattern 'Inquire'
    foreach ($m in $matches2) {
        Write-Output "$($_.Name):$($m.LineNumber): $($m.Line.Trim())"
    }