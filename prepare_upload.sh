#!/bin/bash
echo "Creating release.zip..."
rm -f release.zip
# Zip source code only, excluding build artifacts and node_modules
zip -r release.zip . -x ".next/*" "node_modules/*" ".git/*" ".env" "*.zip" "database.sqlite"
echo "✅ release.zip created!"
echo "👉 Upload 'release.zip' to Hostinger File Manager in: domains/your-subdomain/public_html"
