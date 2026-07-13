# Genome_Assembly_Pipeline
An automated SLURM based pipeline for quality control, read trimming, genome assembly, and assembly quality assessment.

## Overview

This repository contains a SLURM-based bioinformatics pipeline for processing Illumina paired-end sequencing data.

The pipeline performs:

- FastQC (Raw Read Quality Control)
- MultiQC (Quality Summary)
- fastp (Read Trimming)
- FastQC on Trimmed Reads
- MultiQC on Trimmed Reads
- SPAdes Genome Assembly
- QUAST Assembly Evaluation

## Workflow
Raw Reads
↓
FastQC
↓
MultiQC
↓
fastp
↓
FastQC
↓
MultiQC
↓
SPAdes
↓
QUAST

## Software
- FastQC
- MultiQC
- fastp
- SPAdes
- QUAST
- SLURM
## Author
Chhavi Patial
