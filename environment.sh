export INSTALL_DIR=~/opt/f4pga
export F4PGA_INSTALL_DIR=$INSTALL_DIR
export FPGA_FAM=xc7
source "$INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh"

if [ $1 = "--activate" ]; then
    echo "Activating environment..."
    conda activate xc7
fi

if [ $1 = "--deactivate" ]; then
    echo "Deactivating environment..."
    conda deactivate
fi