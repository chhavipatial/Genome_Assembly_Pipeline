#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=FastQC_Trimmed
#SBATCH --output=FastQC_Trimmed_%j.out
#SBATCH --error=FastQC_Trimmed_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# Sample name
SAMPLE="sample1"

# Threads
THREADS=${SLURM_CPUS_PER_TASK}

# Input directory (trimmed reads)
TRIM_DIR="${WORKDIR}/trimmed_reads"

# Output directory
FASTQC_DIR="${WORKDIR}/fastqc_trimmed_results"

############################################################
# LOAD MODULE
############################################################

module load fastqc

############################################################
# CREATE OUTPUT DIRECTORY
############################################################

mkdir -p "$FASTQC_DIR"

############################################################
# CHECK INPUT FILES
############################################################

READ1="${TRIM_DIR}/${SAMPLE}_1.trimmed.fastq.gz"
READ2="${TRIM_DIR}/${SAMPLE}_2.trimmed.fastq.gz"

if [[ ! -f "$READ1" || ! -f "$READ2" ]]; then
    echo "ERROR: Trimmed FASTQ files not found."
    echo "$READ1"
    echo "$READ2"
    exit 1
fi

############################################################
# RUN FASTQC
############################################################

echo "========================================="
echo "FastQC on Trimmed Reads Started"
echo "Sample : $SAMPLE"
echo "Date   : $(date)"
echo "========================================="

fastqc \
"$READ1" \
"$READ2" \
--threads "$THREADS" \
--outdir "$FASTQC_DIR"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "FastQC on Trimmed Reads completed!"
echo "Results saved in: $FASTQC_DIR"
echo "Completed at: $(date)"
echo "========================================="
