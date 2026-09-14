# Deploy changes to GitHub
Set-Location $PSScriptRoot
Write-Host "Checking for changes..." -ForegroundColor Cyan
# Check whether there are any changes
$status = git status --porcelain
if (-not $status) {
   Write-Host "No changes to commit." -ForegroundColor Yellow
   exit 0
}
Write-Host "Staging changes..." -ForegroundColor Cyan
git add .
# Create a timestamped commit message
$message = "Update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Write-Host "Creating commit..." -ForegroundColor Cyan
git commit -m $message
if ($LASTEXITCODE -ne 0) {
   Write-Host "Commit failed." -ForegroundColor Red
   exit 1
}
Write-Host "Pushing changes to GitHub..." -ForegroundColor Cyan
git push
if ($LASTEXITCODE -ne 0) {
   Write-Host "Push failed." -ForegroundColor Red
   exit 1
}
Write-Host ""
Write-Host "Done! Changes have been pushed to GitHub." -ForegroundColor Green
Write-Host "Cloudflare will automatically build and deploy the site." -ForegroundColor Green
