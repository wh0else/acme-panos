# ACME-PANOS with Docker Compose

This guide explains how to use **acme-panos** via Docker Compose to register an ACME account, issue certificates, and deploy them to PAN-OS.

## 1. Prepare the Environment

Make sure your `docker-compose.yml` is ready.  
Remember to rename `.env.example` → `.env` and fill in all required environment variables (DNS provider credentials, PAN-OS settings, etc.).

> **Note:** The `HTTPS_INSECURE` variable in `.env` disables TLS verification for both ACME requests and PAN-OS deployment steps. Use this only if necessary and only in trusted environments.

In PAN-OS 9.1+ create a new admin role with API permissions to import and commit. Create a user that will only be used for the purpose of deploying certs. Assign this user to the role you created.

## 2. Run the Required Commands

Execute the following commands in order:

```bash
docker compose up -d

docker compose run --rm acme-panos --set-default-ca --server letsencrypt

docker compose run --rm acme-panos --register-account -m <mail address>

docker compose run --rm acme-panos --issue -d <domain.tld> --dns dns_domeneshop

docker compose run --rm acme-panos --deploy -d <domain.tld> --deploy-hook panos --insecure
