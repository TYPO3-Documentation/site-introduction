#!/usr/bin/bash

# Add DDEV’s GPG key to your keyring
sudo sh -c 'echo ""'
sudo apt-get update && sudo apt-get install -y curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
sudo chmod a+r /etc/apt/keyrings/ddev.gpg

# Add DDEV releases to your package repository
sudo sh -c 'echo ""'
echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list >/dev/null

# Update package information and install DDEV
sudo sh -c 'echo ""'
sudo apt-get update && sudo apt-get install -y ddev

# One-time initialization of mkcert
mkcert -install


# ### Custom
# Ensure required folders exist
mkdir -p /home/vscode/.ddev/commands/host
echo "
disable_http2: false
fail_on_hook_fail: false
instrumentation_opt_in: false
internet_detection_timeout_ms: 3000
last_started_version: ${LAST_STARTED_VERSION}
letsencrypt_email: ""
mkcert_caroot: /home/vscode/.local/share/mkcert
no_bind_mounts: false
omit_containers: []
performance_mode: none
project_tld: ddev.site
router: traefik
router_bind_all_interfaces: false
router_http_port: \"80\"
router_https_port: \"443\"
mailpit_http_port: \"8025\"
mailpit_https_port: \"8026\"
simple_formatting: false
table_style: default
traefik_monitor_port: \"10999\"
use_hardened_images: false
use_letsencrypt: false
wsl2_no_windows_hosts_mgt: false
web_environment: []
xdebug_ide_location: ""
" > /home/vscode/.ddev/global_config.yaml
