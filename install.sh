#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
HOME_DIR="$HOME"

# --- OS Detection ---
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

# --- WSL Detection and Windows Home Directory ---
IS_WSL=false
WINDOWS_HOME_DIR=""

if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    IS_WSL=true
    echo -e "${YELLOW}Detected WSL environment.${NC}"
    WINDOWS_USERPROFILE_PATH=$(powershell.exe -Command 'echo $env:USERPROFILE' 2>/dev/null | tr -d '\r')
    if [ -n "$WINDOWS_USERPROFILE_PATH" ]; then
        WINDOWS_HOME_DIR=$(wslpath -u "$WINDOWS_USERPROFILE_PATH" 2>/dev/null)
        if [ -d "$WINDOWS_HOME_DIR" ]; then
            echo -e "${GREEN}Windows home directory: $WINDOWS_HOME_DIR${NC}"
        else
            echo -e "${RED}Could not resolve Windows home directory via USERPROFILE.${NC}"
            IS_WSL=false 
        fi
    else
        echo -e "${RED}Could not retrieve Windows USERPROFILE environment variable.${NC}"
        IS_WSL=false 
    fi
fi

mkdir -p "$CONFIG_DIR"

echo -e "${GREEN}Setting up dotfiles...${NC}"

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -L "$target" ] || [ -d "$target" ] || [ -f "$target" ]; then
        echo -e "${YELLOW}Removing existing: $target${NC}"
        rm -rf "$target"
    fi
    
    ln -sf "$source" "$target"
    echo -e "${GREEN}Created symlink: $target -> $source${NC}"
}

# Function to copy files (for Windows home directory)
copy_file() {
    local source="$1"
    local target="$2"
    
    if [ -d "$(dirname "$target")" ]; then
        if [ -f "$target" ]; then
            echo -e "${YELLOW}Removing existing file: $target${NC}"
            rm -f "$target"
        fi
        cp "$source" "$target"
        echo -e "${GREEN}Copied file: $target <- $source${NC}"
    else
        echo -e "${RED}Target directory for copying does not exist: $(dirname "$target")${NC}"
    fi
}

install_fonts() {
    if [ ! -d "$DOTFILES_DIR/fonts" ] || [ -z "$(ls -A "$DOTFILES_DIR/fonts")" ]; then
        echo -e "${YELLOW}No fonts directory or fonts found, skipping...${NC}"
        return
    fi

    echo -e "${GREEN}Installing fonts...${NC}"
    
    case $MACHINE in
        Linux)
            # Check if running in WSL, if so, skip Linux font installation
            # as fonts for native Windows apps are installed on Windows side.
            if $IS_WSL; then
                echo -e "${YELLOW}Running in WSL, skipping Linux font installation.${NC}"
                return
            fi
            
            FONT_DIR="$HOME/.local/share/fonts"
            mkdir -p "$FONT_DIR"
            cp "$DOTFILES_DIR"/fonts/* "$FONT_DIR/"
            echo -e "${GREEN}Fonts copied to $FONT_DIR${NC}"
            
            # Refresh font cache
            if command -v fc-cache >/dev/null 2>&1; then
                fc-cache -fv
                echo -e "${GREEN}Font cache refreshed${NC}"
            fi
            ;;
        Mac)
            FONT_DIR="$HOME/Library/Fonts"
            mkdir -p "$FONT_DIR"
            cp "$DOTFILES_DIR"/fonts/* "$FONT_DIR/"
            echo -e "${GREEN}Fonts copied to $FONT_DIR${NC}"
            ;;
        *)
            echo -e "${RED}Unsupported OS for automatic font installation: $MACHINE${NC}"
            echo -e "${YELLOW}Please manually install fonts from: $DOTFILES_DIR/fonts${NC}"
            ;;
    esac
}

# --- Main Logic ---

# Link config files and directories to ~/.config/
if [ -d "$DOTFILES_DIR/config" ]; then
    echo -e "${GREEN}Linking .config items...${NC}"
    for item in "$DOTFILES_DIR"/config/{*,.*}; do
        if [ -e "$item" ] && [[ $(basename "$item") != "." ]] && [[ $(basename "$item") != ".." ]]; then
            item_name=$(basename "$item")
            create_symlink "$item" "$CONFIG_DIR/$item_name"
        fi
    done
fi

# Link home files/directories to ~/ (for Linux/macOS or WSL's Linux home)
if [ -d "$DOTFILES_DIR/home" ]; then
    echo -e "${GREEN}Linking home files...${NC}"
    for item in "$DOTFILES_DIR"/home/{*,.*}; do
        if [ -e "$item" ] && [[ $(basename "$item") != "." ]] && [[ $(basename "$item") != ".." ]]; then
            item_name=$(basename "$item")
            create_symlink "$item" "$HOME_DIR/$item_name"
        fi
    done
fi

# Copy files to Windows Home Directory if running in WSL
if $IS_WSL && [ -d "$DOTFILES_DIR/windows-home" ]; then
    echo -e "${GREEN}Copying files to Windows home directory ($WINDOWS_HOME_DIR)...${NC}"
    if [ -n "$WINDOWS_HOME_DIR" ]; then
        for item in "$DOTFILES_DIR"/windows-home/{*,.*}; do
            if [ -e "$item" ] && [[ $(basename "$item") != "." ]] && [[ $(basename "$item") != ".." ]]; then
                item_name=$(basename "$item")
                copy_file "$item" "$WINDOWS_HOME_DIR/$item_name"
            fi
        done
    else
        echo -e "${RED}Windows home directory not found, skipping Windows file copy.${NC}"
    fi
fi

install_fonts

echo -e "${GREEN}Dotfiles setup complete!${NC}"
