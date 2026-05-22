# Variables referencing local shell assets
SHELL       := /usr/bin/bash
ANALYZER    := ./scripts/analyze.sh
TEST_DIR    := test_data
OUT_DIR     := output

# Default target: executes analytical sequence over all found log tracks
.PHONY: all
all: setup
	@echo "== Running evaluation across all discovered simulation logs =="
	@for log in $(TEST_DIR)/*.log; do \
		echo "Processing file: $$log"; \
		$(ANALYZER) "$$log" --verbose; \
		echo "----------------------------------------"; \
	done

# Validates execution behavior over specific targets to confirm exact outputs match
.PHONY: test
test: setup
	@echo "== Validating Test Scenarios =="
	@echo "Testing standard pass criteria..."
	$(ANALYZER) $(TEST_DIR)/sample_pass.log --format text
	@echo "Testing standard error criteria..."
	! $(ANALYZER) $(TEST_DIR)/sample_fail.log --format text

# Builds a cleanly written textual analytical summary artifact into output folder
.PHONY: report
report: setup
	@echo "== Compiling analysis metrics to output folder =="
	$(ANALYZER) $(TEST_DIR)/sample_sim.log --format text --output $(OUT_DIR)/simulation_summary.txt
	$(ANALYZER) $(TEST_DIR)/sample_sim.log --format csv --output $(OUT_DIR)/simulation_summary.csv
	@echo "Reports generated successfully inside '$(OUT_DIR)/'."

# Sets up target dependencies and structures workspace
.PHONY: setup
setup:
	@mkdir -p $(OUT_DIR)
	@if [ ! -x $(ANALYZER) ]; then chmod +x $(ANALYZER); fi
	@echo "Verifying baseline tools configurations..."
	@command -v grep >/dev/null 2>&1 || { echo "Error: grep missing." >&2; exit 1; }
	@command -v awk >/dev/null 2>&1 || { echo "Error: awk missing." >&2; exit 1; }
	@echo "All prerequisite tool configurations are verified."

# Removes user runtime objects cleanly
.PHONY: clean
clean:
	@echo "Cleaning up generated assets..."
	@rm -rf $(OUT_DIR)
	@echo "Workspace clean completed."

# Prints help configuration documentation cleanly to the console screen
.PHONY: help
help:
	@echo "========================================================================"
	@echo "             RISC-V Log Analyzer Execution Workspace Automation"
	@echo "========================================================================"
	@echo "Available Targets:"
	@echo "  make all      - Run analysis across every discovered .log inside test_data/"
	@echo "  make test     - Validate analyzer behaviors against specific log vectors"
	@echo "  make report   - Generate analytical text/csv artifacts inside output/"
	@echo "  make setup    - Setup destination folder directories and verify system tools"
	@echo "  make clean    - Wipe the generated output/ directory tracking metrics"
	@echo "  make help     - Display this descriptive help screen layout"
	@echo "========================================================================"