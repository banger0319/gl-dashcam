# Web Deployment

This project can be deployed as a static Flutter Web site.

## Build

Deploy at the site root:

```powershell
.\scripts\build-web.ps1
```

Deploy under a sub-path such as `/dashcam/`:

```powershell
.\scripts\build-web.ps1 -BaseHref /dashcam/
```

The output directory is `build/web`.

## GitHub Pages

This repository includes a GitHub Actions workflow at `.github/workflows/deploy-pages.yml`.

Deployment steps:

1. Push the repository to GitHub.
2. Open `Settings -> Pages`.
3. Set `Source` to `GitHub Actions`.
4. Push to the `main` branch, or run the `Deploy Flutter Web to GitHub Pages` workflow manually.

How the workflow builds:

- For a repository like `https://github.com/<user>/gl-dashcam`, it builds with `--base-href /gl-dashcam/`.
- For a user site repository like `https://github.com/<user>/<user>.github.io`, it builds with `--base-href /`.

Default Pages URL for this repository pattern:

- `https://<user>.github.io/gl-dashcam/`

## Nginx

Use [nginx/gl-dashcam.conf](./nginx/gl-dashcam.conf) as a starting point.

Recommended document root:

- `/var/www/gl-dashcam`

Deployment steps:

1. Upload all files inside `build/web` to the server document root.
2. Enable the Nginx server config.
3. Reload Nginx.

Example commands on the server:

```bash
sudo mkdir -p /var/www/gl-dashcam
sudo cp -r build/web/* /var/www/gl-dashcam/
sudo cp deploy/nginx/gl-dashcam.conf /etc/nginx/conf.d/gl-dashcam.conf
sudo nginx -t
sudo systemctl reload nginx
```

## Notes

- Do not open `build/web/index.html` directly with `file://`.
- Serve it with HTTP or HTTPS.
- If you deploy to a sub-path, build with the matching `BaseHref`.
- Some mock images load from `images.unsplash.com`; the server and client network must be able to access that domain.
