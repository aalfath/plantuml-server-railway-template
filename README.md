[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/plantuml-server?utm_medium=integration&utm_source=button&utm_campaign=plantuml-server)

# PlantUML Server on Railway

This repo packages the official [PlantUML Server](https://github.com/plantuml/plantuml-server) image for one-click deployment on [Railway](https://railway.com).

PlantUML Server turns plain-text diagram descriptions (sequence, class, activity, component, state, deployment, Gantt, mind maps and more) into PNG, SVG or ASCII images. It has a web editor with a live preview, and an HTTP API that wikis, docs sites, IDE plugins and CI jobs can call.

## What it deploys

| Service | Builds from | Version |
|---|---|---|
| `PlantUML Server` | this repo (`Dockerfile`) | `plantuml/plantuml-server:jetty-v1.2026.10` pinned by digest `sha256:3719f4a9b0b061f1aa42d14d130388f831954ca65685d521b6c5b72301e993e6` |

One stateless service with a public Railway domain. No database and no volume: a diagram's source is encoded in its URL, so nothing is stored on the server.

The wrapper `Dockerfile` makes two small changes to the upstream image: Jetty listens on Railway's `PORT` (default `8080`) instead of a fixed 8080, and the Jetty annotation scanner's harmless duplicate-class warnings are silenced (they flood the logs on every boot).

## Variables

| Variable | Default | What it does |
|---|---|---|
| `PORT` | `8080` | Port Jetty listens on; the Railway domain points at it |

Optional upstream settings you can add on the service (see the [upstream list](https://github.com/plantuml/plantuml-server#how-to-set-plantuml-options)):

- `PLANTUML_LIMIT_SIZE` (default `4096`): maximum image width and height in pixels.
- `PLANTUML_SECURITY_PROFILE` (default `INTERNET`): don't set it lower. `SANDBOX` turns off all remote fetches (`!include` of URLs, the `proxy` endpoint).
- `BASE_URL`: serve under a sub-path such as `/plantuml`.
- `PLANTUML_STATS=on`: enable the statistics report.

By default the server refuses to fetch private, loopback and link-local addresses through `!include` or the `proxy` endpoint (`PLANTUML_ALLOW_PRIVATE_URLS=false`), so it can't be used to reach Railway's private network.

## Using it

- Web editor: `https://YOUR-DOMAIN/`
- Render an encoded diagram: `https://YOUR-DOMAIN/png/<encoded>`, `/svg/<encoded>`, `/txt/<encoded>`
- Example: `https://YOUR-DOMAIN/png/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000` (Bob → Alice: hello)
- Point integrations (Confluence, GitLab, MkDocs, Asciidoctor, VS Code) at `https://YOUR-DOMAIN/` as their PlantUML server URL.

The server is public by design and has no login. Anyone with the URL can render diagrams, which uses your Railway resources.

## Updates

Railway notifies everyone who deployed this template when a change is merged to `main`. Each update bumps the pinned image in the `Dockerfile` and is described in [CHANGELOG.md](CHANGELOG.md). Updating only rebuilds the image; there's no data to migrate.
