#!/bin/sh

readonly LOG_ARCHIVE_URL="https://raw.githubusercontent.com/faridlamaul/log-archive-tool/main/log-archive.sh"
readonly LOG_ARCHIVE_DIRECTORY="/usr/local/bin"

if [ ${EUID} -ne 0 ]; then
    echo "This script must be run as root. Cancelling" >&2
    exit 1
fi

if [ -f "${LOG_ARCHIVE_DIRECTORY}/log-archive" ]; then
    echo "Log archive tool is already installed."
    exit 0
fi

echo "Installing log archive tool..."

curl -sL "${LOG_ARCHIVE_URL}" -o "${LOG_ARCHIVE_DIRECTORY}/log-archive"
chmod +x "${LOG_ARCHIVE_DIRECTORY}/log-archive"

echo "Log archive tool has been installed to ${LOG_ARCHIVE_DIRECTORY}/log-archive" 