# Changelog

## Unreleased (2026-11-16)

- README: added the Deploy on Railway button for the published template (`plantuml-server`). No change to the image or the service.

## v1.2026.10 (2026-11-16)

- First release of the template: PlantUML Server `v1.2026.10` (Jetty 12.1.6, Java 21, Graphviz 14.0.1), image `plantuml/plantuml-server:jetty-v1.2026.10@sha256:3719f4a9b0b061f1aa42d14d130388f831954ca65685d521b6c5b72301e993e6`.
- Jetty listens on Railway's `PORT` (default `8080`).
- Silenced the Jetty annotation scanner's duplicate-class warnings, which flooded the logs on every boot.
