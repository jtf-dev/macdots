#!/bin/bash

# Exit on error
set -e

# Function to check if Homebrew is installed
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed"
    fi
}

# Function to install applications from Brewfile
install_brewfile() {
    echo "Installing applications from Brewfile..."
    # Make sure Homebrew is up to date first
    brew update
    brew bundle --file="$1"
}

# Function to set up GitHub credentials (e.g., SSH keys or personal access token)
setup_github_credentials() {
    echo "Setting up GitHub credentials..."
    # Example: Add SSH key to GitHub (if you have one)
    if [ ! -f "$HOME/.ssh/id_rsa" ]; then
        echo "No SSH key found. Generating SSH key..."
        ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$HOME/.ssh/id_rsa" -N ""
        echo "Adding SSH key to the SSH agent..."
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_rsa"
        # Display SSH public key to copy to GitHub
        cat "$HOME/.ssh/id_rsa.pub"
    else
        echo "SSH key already exists."
    fi

    # Optionally, set up Git user name and email
    git config --global user.name "jtf-dev"
    git config --global user.email "jtomfletcher@gmail.com"
}

# Function to use GNU Stow to symlink dotfiles
symlink_dotfiles() {
    echo "Symlinking dotfiles using GNU Stow..."
    cd "$HOME/dotfiles" || exit
    # Run Stow for each directory of dotfiles (e.g., 'vim', 'zsh', etc.)
    for dir in */; do
        # Skip directories that don't contain dotfiles
        if [ -d "$HOME/dotfiles/$dir" ]; then
            echo "Stowing $dir..."
            stow "$dir"
        fi
    done
}

# Main setup function
main() {
    # Install Homebrew (if not already installed)
    install_homebrew

    # Install applications from Brewfile (pass path to Brewfile)
    install_brewfile "$HOME/dotfiles/Brewfile"

    # Clone dotfiles repository (if not already cloned)
    if [ ! -d "$HOME/dotfiles" ]; then
        clone_dotfiles
    fi

    # Set up GitHub credentials
    setup_github_credentials

    # Use GNU Stow to symlink dotfiles
    symlink_dotfiles

    echo "Setup complete!"
}

# Run the setup
main
