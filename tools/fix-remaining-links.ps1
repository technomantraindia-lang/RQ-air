$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot '..\arkdin-html'

function Replace-OrderedHrefs {
  param(
    [string]$Content,
    [string]$Anchor,
    [string[]]$Targets
  )
  $parts = $Content.Split([string[]]@($Anchor), [System.StringSplitOptions]::None)
  if ($parts.Length -le 1) { return $Content }
  $sb = New-Object System.Text.StringBuilder
  for ($i = 0; $i -lt $parts.Length; $i++) {
    [void]$sb.Append($parts[$i])
    if ($i -lt $parts.Length - 1) {
      $t = if ($i -lt $Targets.Length) { $Targets[$i] } else { 'service-details.html' }
      [void]$sb.Append($Anchor.Replace('service-details.html', $t))
    }
  }
  return $sb.ToString()
}

function Replace-LabeledFooterLinks {
  param([string]$Content)
  $pairs = @(
    @('Rapid Cool Installation',    'ac-installation.html'),
    @('Air Flow Optimization',      'routine-maintenance.html'),
    @('Rapid Drain Unclogging',     'duct-cleaning-sanitization.html'),
    @('Frost Guard Emergency',      'emergency-support.html'),
    @('Breeze Balance Calibration', 'hvac-inspection.html')
  )
  foreach ($p in $pairs) {
    $Content = $Content.Replace('href="service-details.html">' + $p[0] + '<', 'href="' + $p[1] + '">' + $p[0] + '<')
  }
  return $Content
}

# index.html: service cards (document order) + footer
$indexPath = Join-Path $root 'index.html'
$c = [System.IO.File]::ReadAllText($indexPath)
$c = Replace-OrderedHrefs -Content $c -Anchor '<a href="service-details.html">Learn more' -Targets @(
  'ac-repair-service.html',
  'ac-installation.html',
  'routine-maintenance.html',
  'duct-cleaning-sanitization.html',
  'refrigeration-solutions.html',
  'amc-plans.html'
)
$c = Replace-OrderedHrefs -Content $c -Anchor '<a href="service-details.html" class="cs_text_btn' -Targets @(
  'emergency-support.html',
  'ac-repair-service.html',
  'routine-maintenance.html',
  'hvac-inspection.html',
  'ac-repair-service.html',
  'duct-cleaning-sanitization.html'
)
$c = Replace-LabeledFooterLinks -Content $c
[System.IO.File]::WriteAllText($indexPath, $c)
Write-Host "Updated index.html"

# Footer-only fixes
foreach ($f in @('projects.html','service.html','service-details.html','refrigeration-solutions.html','routine-maintenance.html')) {
  $p = Join-Path $root $f
  $c = [System.IO.File]::ReadAllText($p)
  $c = Replace-LabeledFooterLinks -Content $c
  [System.IO.File]::WriteAllText($p, $c)
  Write-Host "Updated $f"
}

Write-Host 'All remaining generic links fixed.'