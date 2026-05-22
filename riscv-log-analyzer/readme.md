# RISC-V Log Analyzer (Grand Assessment)

An automated, shell-based diagnostics and performance analysis tool designed to process RISC-V architectural simulation log files. This framework parses execution traces, extracts test state vectors, calculates exact execution floating-point runtimes, and outputs structured analytical reports.

This project validates the systems engineering core competencies from **MEDS Lab Module One**: Linux system environment tooling, advanced shell scripting architecture, automated compilation via Makefiles, and rigorous distributed version control tracking workflows.

---

## Repository Structure

The project directory follows the mandatory structure specified in the evaluation guidelines:

```text
riscv-log-analyzer/
├── README.md               # Project overview, installation, and sample outputs
├── Makefile                # Automation management system for setup, testing, and reports
├── .gitignore              # Explicit exclusions for build artifacts, text dumps, and IDE configurations
├── scripts/
│   ├── analyze.sh          # Main parsing and statistics processing bash engine
│   ├── setup_env.sh        # Workspace environment verification script
│   └── generate_report.sh  # Automated target reporting script
├── test_data/
│   ├── sample_sim.log      # Master target simulation log profile
│   ├── sample_pass.log     # Ideal simulation track with 100% test success rate
│   └── sample_fail.log     # Simulation trace containing failures and skips
├── output/                 # Destination directory for generated txt/csv dumps (Gitignored)
└── docs/
    └── USAGE.md            # Comprehensive user operation manual and flags documentation