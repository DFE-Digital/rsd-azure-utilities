FROM mcr.microsoft.com/azure-cli:azurelinux3.0
LABEL org.opencontainers.image.source="https://github.com/DFE-Digital/rsd-azure-utilities"
LABEL org.opencontainers.image.description="Azure CLI image for running automation tools"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Department for Education"

RUN mkdir -p ./bin ./support
COPY bin/ /home/nonroot/bin
COPY support/ /home/nonroot/support
COPY start /home/nonroot/start

RUN chmod +x /home/nonroot/bin/* /home/nonroot/support* \
    && chmod +x /home/nonroot/start \
    && chown -R nonroot:nonroot /home/nonroot

USER nonroot
WORKDIR /home/nonroot
ENV PATH="/home/nonroot/bin:$PATH"
