# PlantUML Server for Railway
# Upstream: https://github.com/plantuml/plantuml-server (official image, Jetty flavour)
FROM plantuml/plantuml-server:jetty-v1.2026.10@sha256:3719f4a9b0b061f1aa42d14d130388f831954ca65685d521b6c5b72301e993e6

# Railway routes traffic to the port in $PORT. The image's pre-generated Jetty
# start command has no port, so Jetty always listens on 8080. Add
# jetty.http.port=${PORT:-8080} to it: the base entrypoint sources this file
# with sh, so the variable is expanded at container start.
USER root
RUN set -eu; \
    f=/var/lib/jetty/jetty.start; \
    grep -q 'org.eclipse.jetty.xml.XmlConfiguration ' "$f"; \
    sed -i 's#org.eclipse.jetty.xml.XmlConfiguration #org.eclipse.jetty.xml.XmlConfiguration jetty.http.port=${PORT:-8080} #' "$f"; \
    grep -q 'jetty.http.port=${PORT:-8080}' "$f"; \
    touch "$f"
USER jetty

ENV PORT=8080 \
    PLANTUML_SECURITY_PROFILE=INTERNET

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["java", "-jar", "/usr/local/jetty/start.jar"]
