# Namecheap DDNS Updater

[![Docker Pulls](https://img.shields.io/docker/pulls/tranceer/namecheap-ddns-updater?style=flat-square)](https://hub.docker.com/r/tranceer/namecheap-ddns-updater)
[![Docker Image Size](https://img.shields.io/docker/image-size/tranceer/namecheap-ddns-updater/latest?style=flat-square)](https://hub.docker.com/r/tranceer/namecheap-ddns-updater)

Automatically updates your Namecheap Dynamic DNS records for multiple hosts at a specified interval.

---

## 📦 Features
- Easy to configure
- Lightweight container
- Supports multiple hosts
- Simple logging output
- Fully customizable `entrypoint.sh` script inside the container

---

## 🛠️ Usage

You can deploy this container easily via Unraid Community Applications.

**Environment Variables:**

| Variable  | Description |
|:----------|:------------|
| `DOMAIN`  | Your domain name (e.g., `yourdomain.com`) |
| `API_KEY` | Your Namecheap Dynamic DNS API key |
| `HOSTS`   | Comma-separated list of hosts to update (e.g., `@,www,admin`) |
| `INTERVAL`| How often to update the DNS records, in seconds (e.g., `600`) |

---

## 🖥️ Setup Example

```bash
docker run -d \
  --name=namecheap-ddns-updater \
  -e DOMAIN=yourdomain.com \
  -e API_KEY=your_api_key \
  -e HOSTS=@,www,admin \
  -e INTERVAL=600 \
  tranceer/namecheap-ddns-updater:latest
