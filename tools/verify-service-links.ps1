$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..\arkdin-html'

Write-Host '=== HTML files ==='
Get-ChildItem (Join-Path $root '*.html') | ForEach-Object { Write-Host $_.Name }

Write-Host '---'
$expected = @(
  'ac-repair-service.html','ac-installation.html','routine-maintenance.html',
  'duct-cleaning-sanitization.html','refrigeration-solutions.html','amc-plans.html',
  'emergency-support.html','hvac-inspection.html'
)
foreach ($f in $expected) {
  $p = Join-Path $root $f
  if (Test-Path $p) { Write-Host "OK  $f" } else { Write-Host "MISSING  $f" }
}

Write-Host '--- Generic service-details.html hrefs remaining ---'
$total = 0
Get-ChildItem (Join-Path $root '*.html') | ForEach-Object {
  $m = Select-String -Path $_.FullName -Pattern 'href="service-details\.html"' -AllMatches
  if ($m) {
    $n = ($m.Matches | Measure-Object).Count
    $total += $n
    Write-Host ($_.Name + ': ' + $n)
  }
}
Write-Host ('TOTAL generic hrefs: ' + $total)

Write-Host '--- Links pointing to each detail page ---'
foreach ($f in $expected) {
  $name = [System.IO.Path]::GetFileNameWithoutExtension($f)
  $count = 0
  Get-ChildItem (Join-Path $root '*.html') | ForEach-Object {
    $m = Select-String -Path $_.FullName -Pattern ('href="' + $f + '"') -AllMatches
    if ($m) { $count += ($m.Matches | Measure-Object).Count }
  }
  Write-Host ($f + ' <- ' + $count + ' inbound links')
}