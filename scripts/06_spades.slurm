#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=SPAdes
#SBATCH --output=SPAdes_%j.out
#SBATCH --error=SPAdes_%j.err
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# Sample name
SAMPLE="sample1"

# Input directory containing trimmed reads
TRIM_DIR="${WORKDIR}/trimmed_reads"

# Output directory
ASSEMBLY_DIR="${WORKDIR}/spades_output"

# Threads and memory
THREADS=${SLURM_CPUS_PER_TASK}
MEMORY=64

############################################################
# LOAD MODULE
############################################################

module load spades

############################################################
# CREATE OUTPUT DIRECTORY
############################################################

mkdir -p "$ASSEMBLY_DIR"

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
# RUN SPADES
############################################################

echo "========================================="
echo "SPAdes Genome Assembly Started"
echo "Sample : $SAMPLE"
echo "Date   : $(date)"
echo "========================================="

spades.py \
-1 "$READ1" \
-2 "$READ2" \
-o "$ASSEMBLY_DIR" \
-t "$THREADS" \
-m "$MEMORY"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "SPAdes Assembly completed successfully!"
echo "Assembly output saved in: $ASSEMBLY_DIR"
echo "Completed at: $(date)"
echo "========================================="
