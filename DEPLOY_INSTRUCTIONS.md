# Hostinger Subdomain Deployment Guide

Follow these steps to deploy your application to a Hostinger subdomain (e.g., `sub.yourdomain.com`).

## 1. Prepare Deployment Package
Run the preparation script locally to create a clean zip file of your source code:
```bash
./prepare_upload.sh
```
This will create `release.zip`.

## 2. Upload to Hostinger
1.  Login to **Hostinger hPanel**.
2.  Go to **Websites** -> **Manage** -> **Files** -> **File Manager**.
3.  Navigate to your subdomain's folder: `domains/your-subdomain/public_html`.
4.  **Delete** any existing files in this directory (e.g., default `index.php`).
5.  **Upload** the `release.zip` file.
6.  **Extract** `release.zip` (Right-click -> Extract).
7.  Ensure the files are directly in `public_html` (not inside a subfolder). If they are in a subfolder, move them up.

## 3. Database Setup (MySQL)
1.  In hPanel, go to **Databases** -> **Management**.
2.  Create a **New MySQL Database** and User.
    - Note down: Database Name, Username, and Password.
3.  Go to **Files** -> **File Manager** -> `domains/your-subdomain/public_html`.
4.  Create a new file named `.env`.
5.  Add the following content (replace with your actual DB details):
    ```env
    NODE_ENV=production
    DB_HOST=localhost
    DB_USER=u123456789_user
    DB_PASSWORD=YourPassword123
    DB_NAME=u123456789_db
    NEXTAUTH_SECRET=changeme_to_random_string
    NEXTAUTH_URL=https://sub.yourdomain.com
    ```

## 4. Install and Build (via SSH)
It is highly recommended to use SSH for the build process to avoid complications.

1.  **Enable SSH** in hPanel (Advanced -> SSH Access).
2.  Connect to your server using a terminal:
    ```bash
    ssh -p 65002 u123456789@46.202.139.33
    ```
    (Replace with your actual SSH command from hPanel).
3.  Navigate to your subdomain folder:
    ```bash
    cd domains/your-subdomain/public_html
    ```
4.  **Install Dependencies**:
    ```bash
    npm install
    ```
5.  **Build the Application**:
    ```bash
    npm run build
    ```
6.  **Setup Database Tables**:
    ```bash
    npm run db:reset
    ```
    *Warning: This wipes existing data. Only run during initial setup.*

## 5. Configure Hostinger Startup
1.  In hPanel, go to **Advanced** -> **Node.js** (or "VPS" if using VPS, but for Cloud/Shared Hosting use Node.js selector).
    *Note: Hostinger Shared/Cloud hosting Node.js setup usually requires pointing to the application root.*
2.  **Application Root**: `domains/your-subdomain/public_html`
3.  **Application Startup File**: `server.js` (Next.js custom server) or `node_modules/next/dist/bin/next` with arguments `start`.
    *Recommended for Custom Server:* Ensure `server.js` exists (it should be in your uploaded files).
4.  **Install Dependencies** button (if you didn't do it via SSH).
5.  **Restart** the server.

## Troubleshooting
- **500 Error**: Check `npm run build` logs in SSH. Ensure `.env` is correct.
- **Database Connection Error**: Verify `DB_HOST` (usually `localhost` or specific IP) and credentials in `.env`.
- **Changes not showing**: Always **Restart** the Node.js server in hPanel after uploads.
