#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=FastQC
#SBATCH --output=FastQC_%j.out
#SBATCH --error=FastQC_%j.err
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# Sample name (without _1/_2.fastq.gz)
SAMPLE="sample1"

# Input file extension
EXT="fastq.gz"

# Input reads
READ1="${WORKDIR}/${SAMPLE}_1.${EXT}"
READ2="${WORKDIR}/${SAMPLE}_2.${EXT}"

# Number of threads
THREADS=${SLURM_CPUS_PER_TASK}

# Output directory
OUTDIR="${WORKDIR}/fastqc_results"

############################################################
# LOAD MODULE
############################################################

module load fastqc

############################################################
# CREATE OUTPUT DIRECTORY
############################################################

mkdir -p "$OUTDIR"

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
# RUN FASTQC
############################################################

echo "========================================="
echo "FastQC Analysis Started"
echo "Sample   : $SAMPLE"
echo "Date     : $(date)"
echo "========================================="

fastqc \
"$READ1" \
"$READ2" \
--threads "$THREADS" \
--outdir "$OUTDIR"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "FastQC completed successfully!"
echo "Results saved in: $OUTDIR"
echo "Completed at: $(date)"
echo "========================================="
