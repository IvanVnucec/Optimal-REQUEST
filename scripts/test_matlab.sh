#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cd ../matlab
flatpak run org.octave.Octave --no-gui test_optimal_req.m
