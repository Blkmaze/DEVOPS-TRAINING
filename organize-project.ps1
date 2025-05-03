# Set base path
$basePath = "C:\DEVOPS-TRAINING"

# Ensure folder structure
New-Item -ItemType Directory -Force -Path "$basePath\app", "$basePath\web", "$basePath\db", "$basePath\.github\workflows"

# Move app files
Copy-Item "$basePath\app.py" -Destination "$basePath\app\app.py" -Force
Copy-Item "$basePath\requirements.txt" -Destination "$basePath\app\requirements.txt" -Force
Copy-Item "$basePath\Dockerfile" -Destination "$basePath\app\Dockerfile" -Force

# Move web files
Copy-Item "$basePath\index.html" -Destination "$basePath\web\index.html" -Force
Copy-Item "$basePath\default.conf" -Destination "$basePath\web\default.conf" -Force

# Move db files
Copy-Item "$basePath\init.sql" -Destination "$basePath\db\init.sql" -Force

# Move GitHub Actions workflow
Copy-Item "$basePath\docker-ci.yml" -Destination "$basePath\.github\workflows\docker-ci.yml" -Force

# Git commit and push
cd $basePath
git add .
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "🔥 Auto-deploy update $timestamp"
git push origin main

Write-Host "`n✅ All files moved and deployment triggered!"
