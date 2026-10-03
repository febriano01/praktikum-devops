#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_NAME
readonly VERSION="1.0.0"
THRESHOLD_DISK=80
FORMAT="text"

log() { printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$1"; }
die() { log "GALAT: $*"; exit 1; }

usage() {
    cat <<USAGE
$SCRIPT_NAME v$VERSION - laporan kesehatan sistem
Penggunaan: $SCRIPT_NAME [OPSI]
  -d N   Ambang peringatan pemakaian disk dalam persen (default: 80)
  -j     Keluarkan hasil dalam format JSON
  -h     Tampilkan bantuan ini
Exit code: 0 = sehat, 2 = melewati ambang, 1 = galat
USAGE
}

while getopts "d:jh" opt; do
  case "$opt" in
    d) THRESHOLD_DISK="$OPTARG" ;;
    j) FORMAT="json" ;;
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

DISK_USAGE=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')

EXIT_CODE=0
if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
    STATUS="PERINGATAN: Pemakaian disk melebihi ambang batas"
    EXIT_CODE=2
else
    STATUS="SEHAT"
fi

if [ "$FORMAT" = "json" ]; then
    cat <<JSON
{
  "script": "$SCRIPT_NAME",
  "version": "$VERSION",
  "disk_usage_percent": $DISK_USAGE,
  "threshold_disk": $THRESHOLD_DISK,
  "status": "$STATUS",
  "exit_code": $EXIT_CODE
}
JSON
else
    echo "=== LAPORAN KESEHATAN SISTEM ==="
    echo "Disk Usage : ${DISK_USAGE}% (Threshold: ${THRESHOLD_DISK}%)"
    echo "Status     : ${STATUS}"
fi

exit $EXIT_CODE
