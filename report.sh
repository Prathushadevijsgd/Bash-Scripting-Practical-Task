#!/bin/bash
REPORT_FILE="report.txt"
{
echo "Current date and time is : $(date)"
echo "Name of current user : $(whoami)"
echo "Internal ip address : $(ipconfig getifaddr en0)"
echo "Hostname: $(hostname)"
echo "External IP Address: $(curl -s http://checkip.amazonaws.com || echo 'Could not fetch')"
echo "OS Version: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "System Uptime: $(uptime | awk -F'up ' '{print $2}' | awk '{print $1, $2}')"
echo "Disk Usage (in GB): $(df -h / | awk 'NR==2 {print $3 " used, " $4 " free"}')"
RAM_TOTAL=$(sysctl -n hw.memsize)
RAM_FREE=$(vm_stat | awk 'BEGIN {free=0} {if ($1 ~ /Pages_free:/) free=$2} END {print free * 4096}')
echo "Total RAM: $(echo "scale=2; $RAM_TOTAL/1073741824" | bc) GB"
echo "Free RAM: $(echo "scale=2; $RAM_FREE/1073741824" | bc) GB"

echo "CPU Info: $(sysctl -n hw.physicalcpu) cores $(sysctl -n hw.cpufrequency | awk '{print $2 / 1000000 " MHz"}')"
} > "$REPORT_FILE"

echo "Report generated: $REPORT_FILE"

