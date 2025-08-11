#!/bin/bash

# Simple solution to find the longest Mars mission security code
echo "Finding the longest successful Mars mission..."

awk -F'|' '
BEGIN { 
    max_duration = 0
    security_code = ""
}
# Skip comments and headers
!/^#/ && !/^SYSTEM:/ && !/^CONFIG:/ && !/^CHECKSUM:/ && !/^CHECKPOINT:/ && NF >= 8 {
    # Clean up fields by removing leading/trailing spaces
    for (i = 1; i <= NF; i++) {
        gsub(/^ +| +$/, "", $i)
    }
    
    # Check if destination is Mars and status is Completed
    if ($3 == "Mars" && $4 == "Completed") {
        duration = $6 + 0  # Convert to number
        if (duration > max_duration) {
            max_duration = duration
            security_code = $8
            mission_id = $2
            date = $1
        }
    }
}
END {
    print "Answer: " security_code
    print ""
    print "Details:"
    print "Mission ID: " mission_id
    print "Date: " date 
    print "Duration: " max_duration " days"
}' space_missions.log
