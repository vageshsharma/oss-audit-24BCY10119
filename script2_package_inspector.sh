#!/bin/bash
# Script 2: FOSS Package Inspector - Apache HTTP Server
# Checks if Apache is installed and displays package information
# Author: [Your Name]

# Detect which package manager is used
if command -v dpkg &>/dev/null; then
    PACKAGE_MANAGER="dpkg"
    if dpkg -l apache2 2>/dev/null | grep -q "^ii"; then
        PACKAGE="apache2"
        INSTALLED=true
    elif dpkg -l httpd 2>/dev/null | grep -q "^ii"; then
        PACKAGE="httpd"
        INSTALLED=true
    else
        INSTALLED=false
        PACKAGE="apache2"
    fi
elif command -v rpm &>/dev/null; then
    PACKAGE_MANAGER="rpm"
    if rpm -q httpd 2>/dev/null | grep -q "httpd"; then
        PACKAGE="httpd"
        INSTALLED=true
    else
        INSTALLED=false
        PACKAGE="httpd"
    fi
else
    PACKAGE_MANAGER="unknown"
    INSTALLED=false
    PACKAGE="apache2"
fi

echo "=========================================="
echo "     FOSS PACKAGE INSPECTOR REPORT        "
echo "=========================================="
echo ""
echo "Target Software: Apache HTTP Server"
echo "Package Name:    $PACKAGE"
echo ""

if [ "$INSTALLED" = true ]; then
    echo "✓ $PACKAGE is INSTALLED on this system."
    echo ""
    echo "Package Details:"
    echo "----------------------------------------"
    
    if [ "$PACKAGE_MANAGER" = "dpkg" ]; then
        dpkg -l | grep "$PACKAGE" | head -3
        echo ""
        echo "Version Information:"
        apache2 -v 2>/dev/null || httpd -v 2>/dev/null
    elif [ "$PACKAGE_MANAGER" = "rpm" ]; then
        rpm -qi httpd 2>/dev/null | grep -E "Name|Version|License|Summary"
    fi
    
    echo ""
    echo "Service Status:"
    sudo systemctl status apache2 2>/dev/null || sudo systemctl status httpd 2>/dev/null | head -5
else
    echo "✗ $PACKAGE is NOT installed on this system."
    echo ""
    echo "To install Apache, run:"
    if [ "$PACKAGE_MANAGER" = "dpkg" ]; then
        echo "  sudo apt update && sudo apt install apache2 -y"
    elif [ "$PACKAGE_MANAGER" = "rpm" ]; then
        echo "  sudo yum install httpd -y"
    fi
fi

echo ""
echo "----------------------------------------"
echo "PHILOSOPHY NOTE"
echo "----------------------------------------"
cat << 'EOF'

The Apache HTTP Server represents a pivotal moment in open source history.

Origin: In 1995, a group of webmasters began sharing patches for the NCSA
HTTPd server. They called themselves the "Apache Group" (A Patchy Server).

Significance:
• First major open source project to rival commercial alternatives
• Proved community-driven development could produce enterprise-grade software
• Established the Apache License 2.0 - a permissive license with patent grants
• Created the Apache Software Foundation model for project governance

Key Freedom: The Apache 2.0 license grants the four essential freedoms:
1. Freedom to use the software for any purpose
2. Freedom to study how it works (source code available)
3. Freedom to modify and improve it
4. Freedom to distribute copies (modified or unmodified)

Today, Apache powers approximately 30% of all websites globally.
EOF

echo ""
echo "=========================================="



