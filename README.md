# Namecheap DDNS Updater

This container automatically updates your Namecheap Dynamic DNS records for multiple hosts at a specified interval.

## How It Works

- At container startup, it generates a bash script at `/app/entrypoint.sh`.
- This script updates all your specified subdomains via Namecheap's Dynamic DNS API.
- It checks your public IP address and updates it every X seconds (default: 600s / 10 minutes).

## Setup Requirements

Before using this container:
- Create an **A Record** for `@.yourdomain.com` in Namecheap DNS.
- Create **CNAME records** for each subdomain you want to manage (e.g., `admin.yourdomain.com`, `nextcloud.yourdomain.com`).
- Enable **Dynamic DNS** in Namecheap and copy your **API Key**.

## Environment Variables

| Variable   | Description |
|------------|-------------|
| `DOMAIN`   | Your domain name (e.g., `example.com`) |
| `API_KEY`  | Your Dynamic DNS API password (from Namecheap panel) |
| `HOSTS`    | Comma-separated list of hosts (e.g., `@,adminer,jellyfin`) |
| `INTERVAL` | Update interval in seconds (default: 600) |

## Credit

- Based on the tutorial: [How to Update Namecheap DNS with Docker (YouTube)](https://www.youtube.com/watch?v=9Wd2a_69QIw)
- Original project by [Daniel Boctor](https://github.com/daniel-boctor/)
- Docker icon sourced from [hernandito's unRAID Docker Folder Animated Icons - Pale Collection](https://github.com/hernandito/unRAID-Docker-Folder-Animated-Icons---Alternate-Colors)
