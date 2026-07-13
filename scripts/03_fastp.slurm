#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=fastp
#SBATCH --output=fastp_%j.out
#SBATCH --error=fastp_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# Sample name
SAMPLE="sample1"

# Input file extension
EXT="fastq.gz"

# Input reads
READ1="${WORKDIR}/${SAMPLE}_1.${EXT}"
READ2="${WORKDIR}/${SAMPLE}_2.${EXT}"

# Output directories
TRIM_DIR="${WORKDIR}/trimmed_reads"
REPORT_DIR="${WORKDIR}/fastp_reports"

# Threads
THREADS=${SLURM_CPUS_PER_TASK}

############################################################
# LOAD MODULE
############################################################

module load fastp

############################################################
# CREATE OUTPUT DIRECTORIES
############################################################

mkdir -p "$TRIM_DIR"
mkdir -p "$REPORT_DIR"

############################################################
# CHECK INPUT FILES
############################################################

if [[ ! -f "$READ1" || ! -f "$READ2" ]]; then
    echo "ERROR: Input FASTQ files not found."
    echo "$READ1"
    echo "$READ2"
    exit 1
fi

############################################################
# RUN FASTP
############################################################

echo "========================================="
echo "fastp Trimming Started"
echo "Sample : $SAMPLE"
echo "Date   : $(date)"
echo "========================================="

fastp \
-i "$READ1" \
-I "$READ2" \
-o "${TRIM_DIR}/${SAMPLE}_1.trimmed.fastq.gz" \
-O "${TRIM_DIR}/${SAMPLE}_2.trimmed.fastq.gz" \
--detect_adapter_for_pe \
--thread "$THREADS" \
--html "${REPORT_DIR}/${SAMPLE}_fastp.html" \
--json "${REPORT_DIR}/${SAMPLE}_fastp.json"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "fastp completed successfully!"
echo "Trimmed reads : $TRIM_DIR"
echo "Reports       : $REPORT_DIR"
echo "Completed at  : $(date)"
echo "========================================="
