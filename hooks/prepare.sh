#!/usr/bin/env bash

set -ex

# Prepare some common variables to be used
PRINTER_NAME="MockPrinter"

# Install CUPS if it is missing
if ! command -v cupsd &> /dev/null; then
    echo "CUPS is not installed. Installing..."
    sudo apt-get update && sudo apt-get install -y cups-pdf
else
    echo "CUPS is already installed."
fi

# Install LPR if it is missing
if ! command -v lpr &> /dev/null; then
    echo "LPR is not installed. Installing..."
    sudo apt-get update && sudo apt-get install -y cups-bsd
else
    echo "LPR is already installed."
fi

# Remove any previous printer service
if lpstat -p "$PRINTER_NAME" &>/dev/null; then
    sudo lpadmin -x "$PRINTER_NAME"
fi

# Create a mocked printer service
sudo lpadmin -p "$PRINTER_NAME" -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd
sudo lpadmin -d "$PRINTER_NAME"
echo "Virtual printer '$PRINTER_NAME' created successfully."
