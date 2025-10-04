
# card-site (Hugo + aafu theme)

This repository contains a Hugo site using the `aafu` theme adapted as a local theme.

## What this repo contains

- `themes/aafu` — the aafu Hugo theme (portfolio/blog built with Tailwind/Tailwind CLI)
- `content/` — your site content (About, Experience, Projects, etc.)
- `hugo.toml` — site config (TOML) populated with your profile parameters
- `public/` — prebuilt site output (served by nginx via docker-compose)
- `Dockerfile` & `docker-compose.yml` — optional ways to build and serve the site

## Quick start (development)

1. Install Hugo (Extended) >= 0.150 locally.
2. Run local server for instant preview and editing:

```bash
hugo server -D
```

Open http://localhost:1313 to preview.

## Build and serve via Docker (current setup)

This project currently serves the prebuilt `public/` directory with nginx. That means you should build the static site locally then run the container:

```bash
# build site locally
hugo -D

# start nginx serving ./public on port 8088
docker compose up -d
```

The site will be available at http://localhost:8088.

Note: `docker-compose.yml` is configured to mount `./public` into the nginx container (read-only). If you prefer the image to build the site inside the container, see the notes below.

## Building inside Docker (CI-friendly)

If you want Docker to build the site inside the image (useful for CI), the Dockerfile must use a Hugo Extended image compatible with the theme and ensure Node/Tailwind devDependencies are available.

I attempted to pin `klakegg/hugo:0.150.1-ext`, but that tag may not exist on Docker Hub in all registries. The safe option used during development was to build locally and mount `public/` into nginx.

## Fixes applied

- Replaced deprecated `paginate` key with `pagination.pagerSize` in `hugo.toml`.
- Switched theme to `aafu` and populated `hugo.toml` params from user-provided profile data.
- Backed up/removed project layout overrides so theme templates render correctly.
- Fixed menu `Home` link to use relative URL (was using `Site.BaseURL` which sometimes produced localhost links when served via nginx with different base URL).
- Ensured `static/images/profile.jpg` contains user's profile photo and is being served.

## Next suggested steps

- (Optional) Run `npm install` and build Tailwind assets to match the theme demo exactly.
- Add more detailed content for projects/experience (I added placeholders).
- Add i18n content if you want both `ru-ru` and `en-us` versions.

## Troubleshooting

- If the theme complains about Tailwind or `TailwindCSS` fields during Docker builds, ensure the build environment provides Node modules (tailwind) or build the site locally as above.

If you want, I can:
- revert to building inside Docker and try alternative Hugo images until one works;
- add a small Makefile to automate `hugo -D` and `docker compose restart web` steps.

---

If you want any of the above automated now, tell me which and I'll implement it.