# toggle.sh - Nginx Site Enabler/Disabler Utility

## Overview
`toggle.sh` is a simple Bash script to enable, disable, report, or toggle the status of Nginx site configurations. It operates on the `sites-available` and `sites-enabled` directories in `/etc/nginx/`.

## Usage
Run the script with `sudo` to modify Nginx configurations.
```
sudo ./toggle.sh <cmd> <site-name>
```
### Commands
| Command | Description |
|---------|-------------|
| `on`    | Enable the specified site and reload Nginx. |
| `off`   | Disable the specified site and reload Nginx. |
| `rpt`   | Report whether the site is enabled or disabled. |
| `tgl`   | Toggle the site's status (enable if disabled, disable if enabled). |
| `help`  | Display usage instructions. |

## Examples

Enable a site:
```
sudo ./toggle.sh on example-site
```
Disable a site:
```
sudo ./toggle.sh off example-site
```
Report site status:
```
sudo ./toggle.sh rpt example-site
```
Toggle site status:
```
sudo ./toggle.sh tgl example-site
```
## Requirements
- Nginx installed and running
- Script must be made executable `chmod +x toggle.sh`
- Script must be executed with `sudo`
- Site configuration files should exist in `/etc/nginx/sites-available/`

## How It Works
- **Enabling a site** creates a symbolic link in `/etc/nginx/sites-enabled/` and reloads Nginx.
- **Disabling a site** removes the symbolic link and reloads Nginx.
- **Reporting** checks if the site exists in `sites-available/` and whether it is enabled.
- **Toggling** enables the site if it is disabled and disables it if enabled, then reloads Nginx.

## Notes
- If a site configuration file does not exist in `/etc/nginx/sites-available/`, the script will not attempt to enable it.
- Nginx is automatically reloaded by the script so that the changes will take effect.

## License
This script is provided as-is without warranty. Feel free to modify and distribute as needed.
