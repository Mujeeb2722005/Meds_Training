#!/usr/bin/env bash

# Bash configuration for robust error handling
# -e: Exit immediately if a command exits with a non-zero status
# -u: Treat unset variables as an error
# -o pipefail: Pipeline exit status is that of the last command to fail
set -euo pipefail

# --- Default State Initialization ---
LOG_FILE=""
FORMAT="text"
OUTPUT_TARGET="stdout"
VERBOSE=0

# --- Helper Functions ---
print_usage() {
    cat << EOF
Usage: $(basename "$0") [path/to/log_file] [OPTIONS]

A shell-based log analyzer tool for RISC-V simulation outputs.

Arguments:
  \$1                          Path to the target log file (Required if not using --help)

Options:
  --format [text|csv]         Define output presentation layout (Default: text)
  --output <path>             Redirect analysis dump away from stdout to file
  --verbose                   Enable runtime informational console logs
  --help                      Print this complete technical usage layout
EOF
}

log_verbose() {
    if [[ "$VERBOSE" -eq 1 ]]; then
        echo -e "[VERBOSE INFO] $*" >&2
    fi
}

# --- Parameter Parsing Logic ---
# Ensure we have at least one valid input parameter
if [[ $# -eq 0 ]]; then
    echo "Error: Missing arguments." >&2
    print_usage
    exit 1
fi

# Manual argument parsing loop to cleanly capture arguments alongside positional parameters
while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            print_usage
            exit 0
            ;;
        --format)
            if [[ -n "${2:-}" && "$2" =~ ^(text|csv)$ ]]; then
                FORMAT="$2"
                shift 2
            else
                echo "Error: --format requires 'text' or 'csv'." >&2
                exit 1
            fi
            ;;
        --output)
            if [[ -n "${2:-}" ]]; then
                OUTPUT_TARGET="$2"
                shift 2
            else
                echo "Error: --output requires a valid file path target." >&2
                exit 1
            fi
            ;;
        --verbose)
            VERBOSE=1
            shift
            ;;
        -*)
            echo "Error: Unknown execution flag encountered: $1" >&2
            print_usage
            exit 1
            ;;
        *)
            if [[ -z "$LOG_FILE" ]]; then
                LOG_FILE="$1"
                shift
            else
                echo "Error: Multiple target files provided: $1" >&2
                exit 1
            fi
            ;;
    esac
done

# Validate target log file entry presence and file visibility constraints
if [[ -z "$LOG_FILE" ]]; then
    echo "Error: Target simulation log file parameter is required." >&2
    exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: The target file path '$LOG_FILE' does not exist or is inaccessible." >&2
    exit 1
fi

log_verbose "Analysis initiated on target reference: $LOG_FILE"
log_verbose "Target Formatting Selection: $FORMAT"
log_verbose "Target Destination Profile: $OUTPUT_TARGET"

# --- CORE PARSING ENGINE ---
analyze_log_metrics() {
    # Extract total lines matching structural log declarations
    local total_runs
    total_runs=$(grep -c "TEST START:" "$LOG_FILE" || true)
    
    if [[ "$total_runs" -eq 0 ]]; then
        echo "Error: No matching RISC-V execution tests found within the provided log target." >&2
        exit 1
    fi

    # Core execution counters
    local passed_runs failed_runs skipped_runs
    passed_runs=$(grep -c "TEST PASS:" "$LOG_FILE" || true)
    failed_runs=$(grep -c "TEST FAIL:" "$LOG_FILE" || true)
    skipped_runs=$(grep -c "TEST SKIP:" "$LOG_FILE" || true)

    # Calculate exact Floating Point Math ratios cleanly through an Awk pipeline
    local pass_pct fail_pct skip_pct
    pass_pct=$(awk -v p="$passed_runs" -v t="$total_runs" 'BEGIN {printf "%.1f", (p/t)*100}')
    fail_pct=$(awk -v f="$failed_runs" -v t="$total_runs" 'BEGIN {printf "%.1f", (f/t)*100}')
    skip_pct=$(awk -v s="$skipped_runs" -v t="$total_runs" 'BEGIN {printf "%.1f", (s/t)*100}')

    # Process names of failed test cases
    local failed_test_names
    failed_test_names=$(grep "TEST FAIL:" "$LOG_FILE" | awk '{print $5}' || true)

    # Calculate Timing Statistics using Awk (Extracts numbers within parenthesis)
    # Formats tracked lookups matching line properties like: TEST PASS: rv32i-add (0.82s)
    local timing_metrics
    timing_metrics=$(grep -E "TEST (PASS|FAIL):" "$LOG_FILE" | grep -oE "\([0-9.]+s\)" | tr -d '(s)' || true)

    local min_time="0.0" max_time="0.0" avg_time="0.0" min_test="N/A" max_test="N/A"
    
    if [[ -n "$timing_metrics" ]]; then
        # Use awk processing to find min, max, average and trace their respective tests simultaneously
        eval "$(grep -E "TEST (PASS|FAIL):" "$LOG_FILE" | awk '
            {
                for(i=1;i<=NF;i++){
                    if($i ~ /\([0-9.]+s\)/){
                        val=$i; gsub(/[(s)]/, "", val);
                        testname=$(i-1);
                        if(nr==0) {min=val; max=val; min_t=testname; max_t=testname;}
                        if(val<min) {min=val; min_t=testname;}
                        if(val>max) {max=val; max_t=testname;}
                        sum+=val;
                        nr++;
                    }
                }
            }
            END {
                if(nr>0) printf "min_time=\"%.2f\"; max_time=\"%.2f\"; avg_time=\"%.2f\"; min_test=\"%s\"; max_test=\"%s\";", min, max, sum/nr, min_t, max_t;
            }
        ')"
    fi

    # Determine Verdict Status Code
    local final_verdict="PASS"
    local exit_status_code=0
    if [[ "$failed_runs" -gt 0 ]]; then
        final_verdict="FAIL"
        exit_status_code=1
    fi

    # --- RENDER FORMAT DISPATCHER ---
    generate_formatted_output() {
        local current_date
        current_date=$(date +"%Y-%m-%d %H:%M:%S")

        if [[ "$FORMAT" == "text" ]]; then
            cat << EOF
=== RISC-V Simulation Log Analysis ===
Log file: $LOG_FILE
Analysis date: $current_date

--- Results Summary ---
Total tests: $total_runs
Passed:      $passed_runs  ( $pass_pct%)
Failed:      $failed_runs  ( $fail_pct%)
Skipped:     $skipped_runs  ( $skip_pct%)

--- Failed Tests ---
EOF
            if [[ "$failed_runs" -gt 0 ]]; then
                local idx=1
                while read -r name; do
                    if [[ -n "$name" ]]; then
                        echo "  $idx. $name"
                        idx=$((idx + 1))
                    fi
                done <<< "$failed_test_names"
            else
                echo "  None"
            fi

            cat << EOF

--- Timing Statistics ---
Min time:  ${min_time}s ($min_test)
Max time:  ${max_time}s ($max_test)
Avg time:  ${avg_time}s

--- Verdict: $final_verdict ---
Exit code: $exit_status_code
EOF

        elif [[ "$FORMAT" == "csv" ]]; then
            # Clean comma separated export layout
            echo "Metric,Value,Percentage"
            echo "Log File,$LOG_FILE,N/A"
            echo "Analysis Date,$current_date,N/A"
            echo "Total Tests,$total_runs,100.0"
            echo "Passed Tests,$passed_runs,$pass_pct"
            echo "Failed Tests,$failed_runs,$fail_pct"
            echo "Skipped Tests,$skipped_runs,$skip_pct"
            echo "Min Execution Time,${min_time}s,$min_test"
            echo "Max Execution Time,${max_time}s,$max_test"
            echo "Average Execution Time,${avg_time}s,N/A"
            echo "Verdict,$final_verdict,$exit_status_code"
        fi
    }

    # Dispatch to final destination file descriptor or standard output buffer
    if [[ "$OUTPUT_TARGET" == "stdout" ]]; then
        generate_formatted_output
    else
        mkdir -p "$(dirname "$OUTPUT_TARGET")"
        generate_formatted_output > "$OUTPUT_TARGET"
        log_verbose "Analysis metrics written out to file target: $OUTPUT_TARGET"
    fi

    return "$exit_status_code"
}

# Execute processing core
analyze_log_metrics