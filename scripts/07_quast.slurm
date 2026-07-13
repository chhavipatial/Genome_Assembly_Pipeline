#!/bin/bash

############################################################
# SLURM RESOURCE REQUESTS
############################################################

#SBATCH --job-name=QUAST
#SBATCH --output=QUAST_%j.out
#SBATCH --error=QUAST_%j.err
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G

############################################################
# USER VARIABLES (EDIT ONLY THIS SECTION)
############################################################

# Working directory
WORKDIR="$HOME/project"

# SPAdes output directory
ASSEMBLY_DIR="${WORKDIR}/spades_output"

# QUAST output directory
QUAST_DIR="${WORKDIR}/quast_results"

# Threads
THREADS=${SLURM_CPUS_PER_TASK}

############################################################
# LOAD MODULE
############################################################

module load quast

############################################################
# CREATE OUTPUT DIRECTORY
############################################################

mkdir -p "$QUAST_DIR"

############################################################
# CHECK INPUT FILE
############################################################

ASSEMBLY="${ASSEMBLY_DIR}/contigs.fasta"

if [[ ! -f "$ASSEMBLY" ]]; then
    echo "ERROR: Assembly file not found."
    echo "$ASSEMBLY"
    exit 1
fi

############################################################
# RUN QUAST
############################################################

echo "========================================="
echo "QUAST Assembly Evaluation Started"
echo "Date : $(date)"
echo "========================================="

quast.py \
"$ASSEMBLY" \
-o "$QUAST_DIR" \
--threads "$THREADS"

############################################################
# FINISHED
############################################################

echo "========================================="
echo "QUAST completed successfully!"
echo "Results saved in: $QUAST_DIR"
echo "Completed at: $(date)"
echo "========================================="
