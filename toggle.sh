#!/bin/bash

# Define paths
SITES_AVAILABLE="/etc/nginx/sites-available"
SITES_ENABLED="/etc/nginx/sites-enabled"

# Function to print usage instructions
print_help() {
    echo "Usage: sudo $0 <cmd> <site-name>"
    echo ""
    echo "Commands:"
    echo "  on    Enable the site and reload Nginx"
    echo "  off   Disable the site and reload Nginx"
    echo "  rpt   Report the status of the site (enabled or disabled)"
    echo "  tgl   Toggle the site's state (enable if disabled, disable if enabled)"
    echo "  help  Show this help message"
    echo ""
    echo "Examples:"
    echo "  sudo $0 on example-site"
    echo "  sudo $0 off example-site"
    echo "  sudo $0 rpt example-site"
    echo "  sudo $0 tgl example-site"
}

# Function to check if a site is enabled
is_enabled() {
    local site="$1"
    [[ -L "$SITES_ENABLED/$site" ]]
}

# Function to check if a site is available
is_available() {
    local site="$1"
    [[ -e "$SITES_AVAILABLE/$site" ]]
}

# Main logic
if [[ $# -lt 2 ]]; then
    print_help
    exit 1
fi

cmd="$1"
site="$2"

case "$cmd" in
    on)
        if is_available "$site"; then
            if is_enabled "$site"; then
                echo "Site $site is already enabled."
            else
                sudo ln -s "$SITES_AVAILABLE/$site" "$SITES_ENABLED/$site"
                echo "Site $site enabled."
                sudo systemctl reload nginx
                echo "Nginx reloaded."
            fi
        else
            echo "Site $site does not exist in $SITES_AVAILABLE."
        fi
        ;;
    off)
        if is_enabled "$site"; then
            sudo rm "$SITES_ENABLED/$site"
            echo "Site $site disabled."
            sudo systemctl reload nginx
            echo "Nginx reloaded."
        else
            echo "Site $site is not enabled or does not exist."
        fi
        ;;
    rpt)
        if is_available "$site"; then
            if is_enabled "$site"; then
                echo "Site $site is enabled."
            else
                echo "Site $site is available but not enabled."
            fi
        else
            echo "Site $site does not exist in $SITES_AVAILABLE."
        fi
        ;;
    tgl)
        if is_available "$site"; then
            if is_enabled "$site"; then
                sudo rm "$SITES_ENABLED/$site"
                echo "Site $site disabled."
            else
                sudo ln -s "$SITES_AVAILABLE/$site" "$SITES_ENABLED/$site"
                echo "Site $site enabled."
            fi
            sudo systemctl reload nginx
            echo "Nginx reloaded."
        else
            echo "Site $site does not exist in $SITES_AVAILABLE."
        fi
        ;;
    help|*)
        print_help
        ;;
esac
