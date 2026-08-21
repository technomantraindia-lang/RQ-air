param(
  [string]$SourceDir = "arkdin-php",
  [string]$OutputDir = "arkdin-html"
)

$ErrorActionPreference = "Stop"

$sourceRoot = Resolve-Path $SourceDir
$outputRoot = Join-Path (Get-Location) $OutputDir
$partialsRoot = Join-Path $sourceRoot "partials"

if (!(Test-Path $outputRoot)) {
  New-Item -ItemType Directory -Path $outputRoot | Out-Null
}

$assetsSource = Join-Path $sourceRoot "assets"
$assetsOutput = Join-Path $outputRoot "assets"
Copy-Item -Path $assetsSource -Destination $outputRoot -Recurse -Force

function Get-FileText {
  param([string]$Path)
  return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Set-FileText {
  param([string]$Path, [string]$Content)
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Content, $utf8NoBom)
}

function Convert-PhpLinks {
  param([string]$Content)
  return [regex]::Replace($Content, '(?<==["''])([^"'']+)\.php(?=["''#?])', '$1.html')
}

function Render-Template {
  param(
    [string]$Path,
    [hashtable]$Variables
  )

  $content = Get-FileText $Path

  foreach ($match in [regex]::Matches($content, '\$(\w+)\s*=\s*([''"])(.*?)\2\s*;', [System.Text.RegularExpressions.RegexOptions]::Singleline)) {
    $Variables[$match.Groups[1].Value] = $match.Groups[3].Value
  }

  $content = [regex]::Replace(
    $content,
    '<\?php\s*(?:\$\w+\s*=\s*([''"]).*?\1\s*;\s*)+\?>',
    '',
    [System.Text.RegularExpressions.RegexOptions]::Singleline
  )

  $content = [regex]::Replace(
    $content,
    '<\?php\s+include\s+[''"]\.\/partials\/([^''"]+)[''"]\s*;?\s*\?>',
    {
      param($match)
      $partialPath = Join-Path $partialsRoot $match.Groups[1].Value
      Render-Template $partialPath $Variables
    },
    [System.Text.RegularExpressions.RegexOptions]::Singleline
  )

  $content = [regex]::Replace(
    $content,
    '<\?php\s+echo\s+\$(\w+)\s*;?\s*\?>',
    {
      param($match)
      $name = $match.Groups[1].Value
      if ($Variables.ContainsKey($name)) { return $Variables[$name] }
      return ''
    },
    [System.Text.RegularExpressions.RegexOptions]::Singleline
  )

  return $content
}

$pages = Get-ChildItem -Path $sourceRoot -Filter "*.php" -File
foreach ($page in $pages) {
  $variables = @{}
  $html = Render-Template $page.FullName $variables
  $html = Convert-PhpLinks $html
  $html = [regex]::Replace($html, '<title>.*?</title>', '<title>Arkdin - Air Conditioning Services HTML Template</title>')
  $html = $html -replace "`r?`n[ \t]*`r?`n[ \t]*`r?`n", "`r`n`r`n"

  $outputName = [System.IO.Path]::ChangeExtension($page.Name, ".html")
  Set-FileText (Join-Path $outputRoot $outputName) $html
}

Write-Host "Converted $($pages.Count) PHP pages to static HTML in $OutputDir"
