#!/bin/bash

# Function to get installed Edge version
get_edge_version() {
    microsoft-edge --version | awk '{print $3}'
}

# Function to check if a version exists
check_version_exists() {
    local version=$1
    local base_url="https://msedgedriver.azureedge.net"
    curl --output /dev/null --silent --head --fail "$base_url/$version/edgedriver_linux64.zip"
}

# Function to perform binary search for valid version
find_valid_version() {
    local base_version=$1
    local major_minor=$(echo $base_version | cut -d. -f1-3)
    local patch_start=$(($(echo $base_version | cut -d. -f4) - 25))
    local patch_end=$((patch_start + 100))
    
    while [[ $patch_start -le $patch_end ]]; do
        local mid=$(( (patch_start + patch_end) / 2 ))
        local version="$major_minor.$mid"
        
        if check_version_exists $version; then
            echo $version
            return 0
        elif check_version_exists "$major_minor.$((mid+1))"; then
            echo "$major_minor.$((mid+1))"
            return 0
        elif check_version_exists "$major_minor.$((mid-1))"; then
            echo "$major_minor.$((mid-1))"
            return 0
        fi
        
        if curl --output /dev/null --silent --head --fail "https://msedgedriver.azureedge.net/$version/edgedriver_win32.zip"; then
            patch_start=$((mid + 1))
        else
            patch_end=$((mid - 1))
        fi
    done
    
    return 1
}

# Function to download WebDriver
download_webdriver() {
    local version=$1
    local install_dir=$2
    local base_url="https://msedgedriver.azureedge.net"
    
    echo "Downloading WebDriver version $version"
    mkdir -p "$install_dir"
    cd "$install_dir"
    wget "$base_url/$version/edgedriver_linux64.zip"
    unzip edgedriver_linux64.zip
    rm edgedriver_linux64.zip
    export EDGEDRIVER_VERSION=$version
    echo "##vso[task.setvariable variable=EDGEDRIVER_VERSION;]$version"
}

# Main script
if [ -z "$WEBDRIVER_INSTALL_DIR" ]; then
    if [ $# -eq 0 ]; then
        echo "Error: WEBDRIVER_INSTALL_DIR not set and no parameter provided"
        echo "Usage: $0 <install_directory>"
        exit 1
    else
        WEBDRIVER_INSTALL_DIR="$1"
    fi
fi

edge_version=$(get_edge_version)
if [ -z "$edge_version" ]; then
    echo "Failed to detect MS Edge version"
    exit 1
fi

echo "Detected MS Edge version: $edge_version"

valid_version=$(find_valid_version $edge_version)
if [ -n "$valid_version" ]; then
    echo "Found valid WebDriver version: $valid_version"
    download_webdriver $valid_version "$WEBDRIVER_INSTALL_DIR"
    echo "WebDriver downloaded successfully"
else
    echo "Failed to find a compatible WebDriver version"
    exit 1
fi