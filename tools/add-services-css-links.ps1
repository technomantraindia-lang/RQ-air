# Adds the services-custom.css stylesheet link (same as service.html) to every other page,
# so the service page header looks identical ("same to same") across all pages.
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$pages = @('about-us.html', 'contact.html', 'index.html', 'projects.html', 'service-details.html')
$linkLine = '    <link rel="stylesheet" href="assets/css/services-custom.css" />'

foreach ($name in $pages) {
    $path = Join-Path $root "arkdin-html\$name"
    $content = [System.IO.File]::ReadAllText($path)

    if ($content -match 'services-custom\.css') {
        Write-Output "SKIP (already linked): $name"
        continue
    }

    $pattern = '(<link[^>]*style\.css[^>]*>)'
    if ($content -match $pattern) {
        $replacement = '$1' + "`r`n" + $linkLine
        $newContent = [regex]::Replace($content, $pattern, $replacement)
        [System.IO.File]::WriteAllText($path, $newContent, (New-Object System.Text.UTF8Encoding($false)))
        Write-Output "UPDATED: $name"
    }
    else {
        Write-Output "WARN (style.css link not found): $name"
    }
}