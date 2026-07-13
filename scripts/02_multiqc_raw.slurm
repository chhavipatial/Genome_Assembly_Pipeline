#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=MultiQC_Raw
#SBATCH --output=MultiQC_Raw_%j.out
#SBATCH --error=MultiQC_Raw_%j.err
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# FastQC output directory
FASTQC_DIR="${WORKDIR}/fastqc_results"

# MultiQC output directory
MULTIQC_DIR="${WORKDIR}/multiqc_results"

############################################################
# LOAD MODULE
############################################################

module load multiqc

############################################################
# CREATE OUTPUT DIRECTORY
############################################################

mkdir -p "$MULTIQC_DIR"

############################################################
# CHECK INPUT DIRECTORY
############################################################

if [[ ! -d "$FASTQC_DIR" ]]; then
    echo "ERROR: FastQC results directory not found."
    echo "$FASTQC_DIR"
    exit 1
fi

############################################################
# RUN MULTIQC
############################################################

echo "========================================="
echo "MultiQC Analysis Started"
echo "Date : $(date)"
echo "========================================="

multiqc \
"$FASTQC_DIR" \
--outdir "$MULTIQC_DIR"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "MultiQC completed successfully!"
echo "Results saved in: $MULTIQC_DIR"
echo "Completed at: $(date)"
echo "========================================="
