FROM mcr.microsoft.com/azure-cli
LABEL org.opencontainers.image.source=https://github.com/DFE-Digital/rsd-afd-custom-domain-validator

COPY afd-domain-scan.sh /
COPY docker-entrypoint.sh /

CMD ["bash", "/docker-entrypoint.sh"]
