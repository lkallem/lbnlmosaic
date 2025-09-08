#!/bin/bash

# LBNL Jekyll Template Setup
# Sets up a Jekyll site with LBNL branding and Bootstrap

set -e

# Parse command line arguments
AUTO_YES=false
if [[ "$1" == "-y" ]]; then
    AUTO_YES=true
elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "LBNL Jekyll Template Setup"
    echo ""
    echo "Usage: $0 [-y] [-h|--help]"
    echo ""
    echo "Options:"
    echo "  -y          Use default settings (flatly theme, orange accent,"
    echo "              create placeholder logos, keep templates directory)"
    echo "  -h, --help  Show this help message"
    echo ""
    exit 0
fi

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
    if [[ "$AUTO_YES" == "false" ]]; then
        read -p "Continue anyway? This will overwrite existing files. (y/N): " confirm
        if [[ ! $confirm =~ ^[Yy]$ ]]; then
            echo "Setup cancelled."
            exit 0
        fi
    else
        echo "Auto-mode: Continuing with overwrite..."
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
if [[ "$AUTO_YES" == "true" ]]; then
    echo "🚀 Auto-mode: Using default settings..."
    ACCENT_COLOR=$(get_color_variables "1")
    ACCENT_COLOR_NAME=$(get_color_name "1")
    SITE_TITLE="My Research Project"
    SITE_DESCRIPTION="A research project from Lawrence Berkeley National Laboratory"
    SITE_BASEURL=""
    SITE_URL=""
    GITHUB_USERNAME=""
    GITHUB_REPO=""
    echo "   ✓ Accent Color: $ACCENT_COLOR_NAME"
    echo "   ✓ Site Title: $SITE_TITLE"
    echo "   ✓ Funding Acknowledgment: (none - legal footer disabled)"
else
    get_user_preferences
    
    # Show configuration summary
    show_configuration_summary
    
    # Confirm before proceeding
    read -p "Proceed with setup? (Y/n): " proceed
    if [[ $proceed =~ ^[Nn]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
fi

echo ""
echo "🚀 Setting up your LBNL Jekyll site..."

# Create directories
create_directories

# Process and copy template files
process_templates

# Check for required logos
check_required_logos

# Offer to create placeholders if needed
if [[ "$AUTO_YES" == "true" ]]; then
    echo "🖼️  Auto-mode: Creating placeholder logos..."
    create_placeholder_logos
else
    offer_placeholder_logos
fi

# Cleanup: Remove template files if they exist (unless -y flag is used)
if [[ "$AUTO_YES" == "false" ]]; then
    cleanup_template_files
else
    echo "🔧 Auto-mode: Keeping templates directory for future use..."
fi

# Setup complete
echo ""
echo "✅ LBNL Jekyll site setup complete!"
echo ""
echo "📋 Configuration:"
echo "   Accent Color: $ACCENT_COLOR_NAME"
echo "   Base URL: ${SITE_BASEURL:-'(automatic)'}"
echo "   Site URL: ${SITE_URL:-'(automatic)'}"
echo ""

# Check logos one more time for final reminder
if [[ ! -f "assets/logos/project-logo.png" || ! -f "assets/logos/project-icon.png" ]]; then
    echo "⚠️  Don't forget to add your logos before going live!"
    echo ""
fi

echo "🔄 Next steps:"
echo "1. Add your project logos (if not done yet):"
echo "   - assets/logos/project-logo.png (navigation, ~200x40px)"
echo "   - assets/logos/project-icon.png (favicon, 32x32px)"
echo ""
echo "2. Install dependencies:"
echo "   bundle install"
echo ""
echo "3. Start development server:"
echo "   bundle exec jekyll serve --baseurl \"\""
echo ""
echo "4. View your site:"
echo "   http://localhost:4000"
echo ""
echo "5. Customize your content:"
echo "   - Edit _config.yml for site details"
echo "   - Update index.md for your home page"
echo "   - Modify pages/about.md and pages/contact.md"
echo "   - Configure sponsors in _data/sponsors.yaml"
echo "   - Add funding_acknowledgment in _config.yml to enable legal footer"

# Show deployment instructions based on setup
show_deployment_instructions

echo ""
echo "🔬 Happy coding with Berkeley Lab style!"
