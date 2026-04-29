param(
  [string]$BaseHref = "/"
)

$ErrorActionPreference = "Stop"

if (-not $BaseHref.StartsWith("/")) {
  throw "BaseHref must start with '/'."
}

if (-not $BaseHref.EndsWith("/")) {
  $BaseHref = "$BaseHref/"
}

$flutter = (Get-Command flutter).Source

Write-Host "Building Flutter Web with base href: $BaseHref"
& $flutter build web --release --base-href $BaseHref

if ($LASTEXITCODE -ne 0) {
  throw "flutter build web failed."
}

Write-Host "Build completed: build/web"
