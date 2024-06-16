#!/bin/bash
wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
bash Anaconda3-2024.02-1-Linux-x86_64.sh
rm -v Anaconda3-2024.02-1-Linux-x86_64.sh

echo "# Deactivate conda" >> ~/.bashrc
echo "conda deactivate" >> ~/.bashrc
echo "" >> ~/.bashrc