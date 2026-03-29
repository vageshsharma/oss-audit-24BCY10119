#!/bin/bash
# Script 3: Disk and Permission Auditor
# Audits important system directories with Apache focus
# Author: [Your Name]

# List of directories to audit
DIRS=(
    "/etc"
    "/var/log"
    "/home"
    "/usr/bin"
    "/tmp"
    "/var/www"
    "/etc/apache2"
    "/etc/httpd"
)

echo "=========================================="
echo "     DIRECTORY AUDIT REPORT               "
echo "=========================================="
echo ""
printf "%-30s %-40s %-12s\n" "DIRECTORY" "PERMISSIONS (OWNER:GROUP)" "SIZE"
echo "================================================================================"

# Loop through directories
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Get permissions, owner, group
        PERMS=$(ls -ld "$DIR" 2>/dev/null | awk '{print $1, $3, $4}')
        # Get disk usage
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "%-30s %-40s %-12s\n" "$DIR" "$PERMS" "$SIZE"
    else
        printf "%-30s %-40s %-12s\n" "$DIR" "Directory does not exist" "N/A"
    fi
done

echo ""
echo "=========================================="
echo "APACHE HTTP SERVER - DETAILED ANALYSIS"
echo "=========================================="

# Detect Apache configuration directory
if [ -d "/etc/apache2" ]; then
    APACHE_CONF="/etc/apache2"
    APACHE_USER="www-data"
    APACHE_GROUP="www-data"
elif [ -d "/etc/httpd" ]; then
    APACHE_CONF="/etc/httpd"
    APACHE_USER="apache"
    APACHE_GROUP="apache"
else
    APACHE_CONF=""
fi

if [ -n "$APACHE_CONF" ] && [ -d "$APACHE_CONF" ]; then
    echo ""
    echo "✓ Apache Configuration Directory: $APACHE_CONF"
    CONF_PERMS=$(ls -ld "$APACHE_CONF" | awk '{print $1, $3, $4}')
    echo "  Permissions: $CONF_PERMS"
    echo "  Number of .conf files: $(find $APACHE_CONF -name "*.conf" 2>/dev/null | wc -l)"
    
    # Check web root
    if [ -d "/var/www/html" ]; then
        echo ""
        echo "Web Root: /var/www/html"
        WEB_PERMS=$(ls -ld "/var/www/html" | awk '{print $1, $3, $4}')
        echo "  Permissions: $WEB_PERMS"
        
        # Security note
        if echo "$WEB_PERMS" | grep -q "www-data"; then
            echo "  ⚠ Security Note: Web root is owned by $APACHE_USER"
            echo "    This is standard but ensure write permissions are restricted"
        fi
    fi
    
    # Check log directory
    LOG_DIR="/var/log/apache2"
    if [ ! -d "$LOG_DIR" ]; then
        LOG_DIR="/var/log/httpd"
    fi
    
    if [ -d "$LOG_DIR" ]; then
        echo ""
        echo "Log Directory: $LOG_DIR"
        LOG_PERMS=$(ls -ld "$LOG_DIR" | awk '{print $1, $3, $4}')
        echo "  Permissions: $LOG_PERMS"
        echo "  Log files: $(ls -1 $LOG_DIR 2>/dev/null | wc -l) files"
    fi
else
    echo ""
    echo "✗ Apache HTTP Server is not installed on this system"
    echo "  Install with: sudo apt install apache2 (Ubuntu/Debian)"
fi

echo ""
echo "=========================================="
echo "SECURITY RECOMMENDATIONS"
echo "=========================================="
echo "1. Web root should not be writable by the web server user"
echo "2. Configuration files should be owned by root"
echo "3. Log directories should be writable only by root"
echo "4. Regular audit of file permissions is recommended"
echo "=========================================="
