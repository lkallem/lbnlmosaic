#!/bin/bash

# LBNL Jekyll Template Setup
# Sets up a Jekyll site with LBNL branding and Bootstrap

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Welcome message
echo "🔬 LBNL Jekyll Template Setup"
echo "=============================="
echo ""

# Check if functions file exists and source it
if [[ ! -f "$SCRIPT_DIR/scripts/functions.sh" ]]; then
    echo "❌ Error: functions.sh not found at $SCRIPT_DIR/scripts/functions.sh"
    echo "Make sure you have the complete template package."
    exit 1
fi

source "$SCRIPT_DIR/scripts/functions.sh"

# Check if directory already has Jekyll files
if [[ -f "_config.yml" || -f "index.md" || -f "Gemfile" ]]; then
    echo "⚠️  This directory appears to already have Jekyll files."
    read -p "Continue anyway? This will overwrite existing files. (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
    echo ""
fi

# Detect if we're in a subdirectory of a git repo
GIT_ROOT=""
if git rev-parse --show-toplevel > /dev/null 2>&1; then
    GIT_ROOT=$(git rev-parse --show-toplevel)
    CURRENT_DIR=$(pwd)
    
    if [[ "$GIT_ROOT" != "$CURRENT_DIR" ]]; then
        echo "📁 Detected git repository at: $(basename "$GIT_ROOT")"
        echo "   Current directory: $(basename "$CURRENT_DIR")"
        echo ""
    fi
fi

# Get user preferences
get_user_preferences

# Show configuration summary
show_configuration_summary

# Confirm before proceeding
read -p "Proceed with setup? (Y/n): " proceed
if [[ $proceed =~ ^[Nn]$ ]]; then
    echo "Setup cancelled."
    exit 0
fi

echo ""
echo "🚀 Setting up your LBNL Jekyll site..."

# Create directories
create_directories

# Process and copy template files
process_templates

# Create .gitignore
create_gitignore

# Cleanup: Remove template files if they exist
cleanup_template_files

# Setup complete
echo ""
echo "✅ LBNL Jekyll site setup complete!"
echo ""
echo "📋 Configuration:"
echo "   Theme: $BOOTSWATCH_THEME"
echo "   Accent Color: $ACCENT_COLOR_NAME"
echo "   Base URL: ${SITE_BASEURL:-'(automatic)'}"
echo "   Site URL: ${SITE_URL:-'(automatic)'}"
echo ""
echo "🔄 Next steps:"
echo "1. Install dependencies:"
echo "   bundle install"
echo ""
echo "   📝 Note: Using github-pages gem for full GitHub Pages compatibility"
echo "   If you get missing gem errors with Ruby 3.4+, they're already included"
echo ""
echo "2. Start development server:"
echo "   bundle exec jekyll serve --baseurl \"\""
echo ""
echo "3. View your site:"
echo "   http://localhost:4000"
echo ""
echo "4. Your site will deploy exactly as it appears locally!"
echo ""
echo "5. Customize your content:"
echo "   - Edit _config.yml for site details"
echo "   - Update index.md for your home page"
echo "   - Modify pages/about.md and pages/contact.md"
echo "   - Add sponsor logos to assets/logos/"
echo "   - Configure sponsors in _data/sponsors.yaml"

# Show deployment instructions based on setup
show_deployment_instructions

echo ""
echo "🔬 Happy coding with Berkeley Lab style!"
