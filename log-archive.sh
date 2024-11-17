#!/bin/sh

# Archive logs in a directory
archive_logs() {
    log_directory=$1
    archive_name="logs_archive_$(date +'%Y%m%d_%H%M%S').tar.gz"
    tar -czf $archive_name $log_directory
    echo "Logs archived successfully in $archive_name"
}

# Log the date and time of the archive to a file
log_archive_time() {
    log_directory=$1
    archive_directory=$2
    archive_name="logs_archive_$(date +'%Y%m%d_%H%M%S').tar.gz"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Logs in $log_directory archived to $archive_name" >> $archive_directory/archive.log
}

# Store the compressed logs in a new directory
store_archive() {
    log_directory=$1
    archive_directory=$2
    archive_name="logs_archive_$(date +'%Y%m%d_%H%M%S').tar.gz"
    new_directory="archive_$(date +'%Y%m%d_%H%M%S')"
    mkdir -p $archive_directory/$new_directory
    mv $archive_name $archive_directory/$new_directory
    echo "Archive stored in $archive_directory/$new_directory"
}

# Function to display usage instructions
usage() {
    echo "Usage: log-archive -s <log_directory> -d <archive_directory>"
}

# Main function to handle command line arguments
main() {
    while getopts "s:d:" opt; do
        case $opt in
            s)
                log_directory=$OPTARG
                ;;
            d)
                archive_directory=$OPTARG
                ;;
            \?)
                usage
                exit 1
                ;;
        esac
    done

    if [ -z "$log_directory" ] || [ -z "$archive_directory" ]; then
        usage
        exit 1
    fi

    archive_logs $log_directory
    log_archive_time $log_directory $archive_directory
    store_archive $log_directory $archive_directory
}

main "$@"