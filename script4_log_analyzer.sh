#!/bin/bash# Script 4: Log File Analyzer
# Analyzes Apache logs and system logs for patterns
# Author: [Your Name]

# Color codes for output (optional)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to analyze a log file
analyze_log() {
    local LOGFILE="$1"
    local KEYWORD="$2"
    local COUNT=0
    local -a LAST_MATCHES
    
    echo "----------------------------------------"
    echo "File: $(basename $LOGFILE)"
    echo "Pattern: $KEYWORD"
    echo ""
    
    if [ ! -f "$LOGFILE" ]; then
        echo -e "${RED}✗ Log file not found: $LOGFILE${NC}"
        return 1
    fi
    
    # Get file size
    FILE_SIZE=$(du -h "$LOGFILE" | cut -f1)
    echo "File size: $FILE_SIZE"
    echo ""
    
    # Count matches
    while IFS= read -r LINE; do
        if echo "$LINE" | grep -iqE "$KEYWORD"; then
            COUNT=$((COUNT + 1))
            # Keep last 5 matches
            LAST_MATCHES+=("$LINE")
            if [ ${#LAST_MATCHES[@]} -gt 5 ]; then
                LAST_MATCHES=("${LAST_MATCHES[@]:1}")
            fi
        fi
    done < "$LOGFILE"
    
    echo -e "${GREEN}Total matches found: $COUNT${NC}"
    
    if [ $COUNT -gt 0 ]; then
        echo ""
        echo "Last 5 matching entries:"
        echo "------------------------"
        for MATCH in "${LAST_MATCHES[@]}"; do
            echo "$MATCH"
        done
    fi
    echo ""
    return 0
}

echo "=========================================="
echo "     LOG FILE ANALYZER REPORT             "
echo "=========================================="
echo ""

# Check if user provided a specific log file
if [ -n "$1" ] && [ -f "$1" ]; then
    LOGFILE="$1"
    KEYWORD="${2:-error}"
    echo "Analyzing user-specified file..."
    echo ""
    analyze_log "$LOGFILE" "$KEYWORD"
else
    echo "Scanning for Apache logs..."
    echo ""
    
    # Try to find and analyze Apache logs
    FOUND_LOGS=false
    
    # Check common Apache log locations
    for LOG_DIR in "/var/log/apache2" "/var/log/httpd"; do
        if [ -d "$LOG_DIR" ]; then
            echo "Found Apache logs in: $LOG_DIR"
            echo ""
            
            # Analyze error log
            if [ -f "$LOG_DIR/error.log" ]; then
                FOUND_LOGS=true
                analyze_log "$LOG_DIR/error.log" "error|fatal|critical"
            fi
            
            # Analyze access log
            if [ -f "$LOG_DIR/access.log" ]; then
                FOUND_LOGS=true
                analyze_log "$LOG_DIR/access.log" "404|500|403"
            fi
        fi
    done
    
    if [ "$FOUND_LOGS" = false ]; then
        echo -e "${YELLOW}No Apache logs found.${NC}"
        echo ""
        echo "Common log files you can analyze:"
        echo "  /var/log/syslog      - System messages"
        echo "  /var/log/auth.log    - Authentication attempts"
        echo "  /var/log/kern.log    - Kernel messages"
        echo ""
        echo "Usage: $0 <logfile> [keyword]"
        echo "Example: $0 /var/log/syslog error"
    fi
fi

echo ""
echo "=========================================="
