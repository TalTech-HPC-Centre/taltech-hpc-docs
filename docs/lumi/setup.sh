#!/bin/bash

mkdir -p $SINGULARITY_TMPDIR
mkdir -p $SINGULARITY_CACHEDIR
singularity pull --dir $SCRATCH docker://rocm/pytorch:latest 