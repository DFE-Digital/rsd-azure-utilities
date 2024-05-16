FROM mcr.microsoft.com/azure-cli
LABEL org.opencontainers.image.source=https://github.com/DFE-Digital/rsd-afd-custom-domain-validator

COPY afd-domain-scan.sh /
RUN chmod +x /afd-domain-scan.sh

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY notify.sh /
COPY slack-webhook.json /
RUN chmod +x /notify.sh
