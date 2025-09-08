#!/bin/bash

# LBNL Jekyll Template Functions

# Global variables for user preferences
ACCENT_COLOR=""
ACCENT_COLOR_NAME=""
SITE_BASEURL=""
SITE_URL=""
SITE_TITLE=""
SITE_DESCRIPTION=""
GITHUB_USERNAME=""
GITHUB_REPO=""

# Function to display color options
show_color_options() {
    echo "📋 LBNL Secondary Color Palette:"
    echo "1. Orange (#D57800) - Default"
    echo "2. Green (#74AA50)"
    echo "3. Yellow (#EAAA00)"
    echo "4. Red (#E04E39)"
    echo "5. Dusty Rose (#E8927C)"
    echo "6. Olive Green (#AC9F3C)"
    echo "7. Blue (#4298B5)"
    echo "8. Purple (#5D4777)"
    echo "9. Burgundy (#672E45)"
    echo ""
}

# Function to get color variables
get_color_variables() {
    local choice=$1
    case $choice in
        1|"") echo "orange";;
        2) echo "green";;
        3) echo "yellow";;
        4) echo "red";;
        5) echo "dusty-rose";;
        6) echo "olive-green";;
        7) echo "blue";;
        8) echo "purple";;
        9) echo "burgundy";;
        *) echo "orange";;
    esac
}

# Function to get color name
get_color_name() {
    local choice=$1
    case $choice in
        1|"") echo "Orange";;
        2) echo "Green";;
        3) echo "Yellow";;
        4) echo "Red";;
        5) echo "Dusty Rose";;
        6) echo "Olive Green";;
        7) echo "Blue";;
        8) echo "Purple";;
        9) echo "Burgundy";;
        *) echo "Orange";;
    esac
}

# Function to get all user preferences
get_user_preferences() {
    # Color selection
    show_color_options
    read -p "Choose your accent color (1-9, or press Enter for Orange): " color_choice
    ACCENT_COLOR=$(get_color_variables "$color_choice")
    ACCENT_COLOR_NAME=$(get_color_name "$color_choice")
    
    echo ""
    echo "🎨 Selected accent color: $ACCENT_COLOR_NAME"
    echo ""
    
    # Site configuration
    echo "⚙️ Site Configuration:"
    echo ""
    read -p "Site title (default: 'LBNL Research Project'): " input_title
    SITE_TITLE="${input_title:-LBNL Research Project}"
    
    read -p "Site description (default: 'Berkeley Lab Computing Research'): " input_desc
    SITE_DESCRIPTION="${input_desc:-Berkeley Lab Computing Research - Advancing Scientific Discovery}"
    
    echo ""
    echo "🔗 GitHub Configuration (optional):"
    echo "Leave blank if you'll configure this later"
    echo ""
    
    # Try to detect GitHub info from git remote if available
    if git remote get-url origin > /dev/null 2>&1; then
        REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
        if [[ $REMOTE_URL =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
            DETECTED_USERNAME="${BASH_REMATCH[1]}"
            DETECTED_REPO="${BASH_REMATCH[2]}"
            echo "📡 Detected GitHub repository: $DETECTED_USERNAME/$DETECTED_REPO"
            read -p "Use detected repository? (Y/n): " use_detected
            if [[ ! $use_detected =~ ^[Nn]$ ]]; then
                GITHUB_USERNAME="$DETECTED_USERNAME"
                GITHUB_REPO="$DETECTED_REPO"
                # Auto-fill baseurl and url when Git repo is detected and accepted
                SITE_URL="https://${GITHUB_USERNAME}.github.io"
                SITE_BASEURL="/$GITHUB_REPO"
                echo "✅ Auto-configured URLs:"
                echo "   Site URL: $SITE_URL"
                echo "   Base URL: $SITE_BASEURL"
                echo ""
            fi
        fi
    fi
    
    # Manual input if not detected or user declined
    if [[ -z "$GITHUB_USERNAME" ]]; then
        read -p "GitHub username/organization: " GITHUB_USERNAME
    fi
    if [[ -z "$GITHUB_REPO" ]]; then
        read -p "Repository name: " GITHUB_REPO
    fi
    
    # Only prompt for URLs if they weren't auto-configured from Git detection
    if [[ -z "$SITE_URL" ]]; then
        read -p "Full site URL (e.g., https://user.github.io, leave blank for auto): " SITE_URL
    fi
    if [[ -z "$SITE_BASEURL" ]]; then
        read -p "Custom base URL (e.g., /my-repo, leave blank for auto): " SITE_BASEURL
    fi
    
    # Auto-detect GitHub URLs if username and repo provided but URLs still empty
    if [[ -n "$GITHUB_USERNAME" && -n "$GITHUB_REPO" ]]; then
        if [[ -z "$SITE_URL" ]]; then
            SITE_URL="https://${GITHUB_USERNAME}.github.io"
        fi
        
        if [[ -z "$SITE_BASEURL" ]]; then
            SITE_BASEURL="/$GITHUB_REPO"
        fi
    fi
}

# Function to find logo file (PNG or SVG)
find_logo_file() {
    local base_name="$1"
    local logo_dir="assets/logos"
    
    if [[ -f "$logo_dir/${base_name}.svg" ]]; then
        echo "${base_name}.svg"
    elif [[ -f "$logo_dir/${base_name}.png" ]]; then
        echo "${base_name}.png"
    else
        echo ""
    fi
}

# Function to check for required logos and warn if missing
check_required_logos() {
    echo "🖼️  Checking for required logos..."
    
    local missing_logos=()
    local optional_logos=()
    local found_logos=()
    
    # Check required logos (PNG or SVG)
    local project_logo=$(find_logo_file "project-logo")
    if [[ -z "$project_logo" ]]; then
        missing_logos+=("project-logo.(png|svg)")
    else
        found_logos+=("$project_logo")
    fi
    
    local project_icon=$(find_logo_file "project-icon")
    if [[ -z "$project_icon" ]]; then
        missing_logos+=("project-icon.(png|svg)")
    else
        found_logos+=("$project_icon")
    fi
    
    # Check optional sponsor logos
    local lbnl_logo=$(find_logo_file "lbnl-logo")
    if [[ -z "$lbnl_logo" ]]; then
        optional_logos+=("lbnl-logo.(png|svg)")
    else
        found_logos+=("$lbnl_logo")
    fi
    
    local doe_logo=$(find_logo_file "doe-logo")
    if [[ -z "$doe_logo" ]]; then
        optional_logos+=("doe-logo.(png|svg)")
    else
        found_logos+=("$doe_logo")
    fi
    
    # Report findings
    if [[ ${#found_logos[@]} -gt 0 ]]; then
        echo "   ✅ Found logos:"
        for logo in "${found_logos[@]}"; do
            echo "      - assets/logos/$logo"
        done
    fi
    
    if [[ ${#missing_logos[@]} -gt 0 ]]; then
        echo "   ⚠️  Missing required logos:"
        for logo in "${missing_logos[@]}"; do
            echo "      - assets/logos/$logo"
        done
    fi
    
    if [[ ${#optional_logos[@]} -gt 0 ]]; then
        echo "   ℹ️  Optional logos not found (footer sponsors will be empty):"
        for logo in "${optional_logos[@]}"; do
            echo "      - assets/logos/$logo"
        done
    fi
    
    # Show recommendations if any logos are missing
    if [[ ${#missing_logos[@]} -gt 0 || ${#optional_logos[@]} -gt 0 ]]; then
        echo ""
        echo "📝 Logo Guidelines (PNG or SVG supported):"
        echo "   • project-logo: Navigation bar logo (~200x40px)"
        echo "   • project-icon: Browser favicon (32x32px or 64x64px)"
        echo "   • lbnl-logo: Berkeley Lab logo for footer (optional)"
        echo "   • doe-logo: Department of Energy logo for footer (optional)"
        echo ""
        echo "💡 SVG format recommended for crisp display at all sizes"
        echo "💡 PNG with transparency also works well"
    fi
    
    echo ""
}

# Function to create placeholder logos (optional)
create_placeholder_logos() {
    echo "🎨 Creating placeholder logo files..."
    
    # Create a simple SVG that can be converted to PNG
    # This is a fallback - users should replace with real logos
    
    cat > assets/logos/project-logo.svg << 'EOF'
<svg width="200" height="40" xmlns="http://www.w3.org/2000/svg">
  <rect width="200" height="40" fill="#00313C"/>
  <text x="100" y="25" fill="white" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" font-weight="bold">PROJECT LOGO</text>
</svg>
EOF

    cat > assets/logos/project-icon.svg << 'EOF'
<svg width="32" height="32" xmlns="http://www.w3.org/2000/svg">
  <rect width="32" height="32" fill="#00313C"/>
  <text x="16" y="20" fill="white" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold">PL</text>
</svg>
EOF

    echo "   ✓ Created placeholder SVG files"
    echo "   ℹ️  Convert to PNG or replace with your actual logos"
}

# Function to offer to create placeholder logos
offer_placeholder_logos() {
    if [[ ! -f "assets/logos/project-logo.png" || ! -f "assets/logos/project-icon.png" ]]; then
        echo "🤔 Would you like to create placeholder logo files?"
        echo "   These are simple SVG placeholders you can replace later."
        read -p "Create placeholders? (y/N): " create_placeholders
        
        if [[ $create_placeholders =~ ^[Yy]$ ]]; then
            create_placeholder_logos
        fi
    fi
}

# Function to show configuration summary
show_configuration_summary() {
    echo ""
    echo "📋 Configuration Summary:"
    echo "========================"
    echo "Site Title: $SITE_TITLE"
    echo "Description: $SITE_DESCRIPTION"
    echo "Accent Color: $ACCENT_COLOR_NAME"
    echo "Base URL: ${SITE_BASEURL:-'(automatic)'}"
    echo "Site URL: ${SITE_URL:-'(automatic)'}"
    if [[ -n "$GITHUB_USERNAME" && -n "$GITHUB_REPO" ]]; then
        echo "GitHub: ${GITHUB_USERNAME}/${GITHUB_REPO}"
    fi
    echo ""
}

# Function to create necessary directories
create_directories() {
    echo "📁 Creating asset directories..."
    mkdir -p assets/images assets/logos
}

# Function to process template files
process_templates() {
    echo "📄 Processing template files..."
    
    local template_dir="$SCRIPT_DIR/templates"
    
    # Find all .template files recursively and process them
    while IFS= read -r -d '' template_file; do
        # Get the relative path from the templates directory
        local relative_path="${template_file#$template_dir/}"
        # Remove the .template extension to get the output path
        local output_path="${relative_path%.template}"
        
        # Special case: gitignore.template -> .gitignore
        if [[ "$output_path" == "gitignore" ]]; then
            output_path=".gitignore"
        fi
        
        process_template "$template_file" "$output_path"
    done < <(find "$template_dir" -name "*.template" -type f -print0)
}

# Function to process a single template file
process_template() {
    local template_file="$1"
    local output_file="$2"
    
    if [[ ! -f "$template_file" ]]; then
        echo "⚠️  Template file not found: $template_file"
        return 1
    fi
    
    # Create parent directories if they don't exist
    local output_dir=$(dirname "$output_file")
    if [[ "$output_dir" != "." ]]; then
        mkdir -p "$output_dir"
    fi
    
    # Use a safer delimiter for sed that's unlikely to appear in URLs
    # We'll use the pipe character | as delimiter and escape any pipes in the content
    local safe_title=$(printf '%s\n' "$SITE_TITLE" | sed 's/|/\\|/g')
    local safe_description=$(printf '%s\n' "$SITE_DESCRIPTION" | sed 's/|/\\|/g')
    local safe_baseurl=$(printf '%s\n' "$SITE_BASEURL" | sed 's/|/\\|/g')
    local safe_url=$(printf '%s\n' "$SITE_URL" | sed 's/|/\\|/g')
    local safe_github_username=$(printf '%s\n' "$GITHUB_USERNAME" | sed 's/|/\\|/g')
    local safe_github_repo=$(printf '%s\n' "$GITHUB_REPO" | sed 's/|/\\|/g')
    
    # Replace template variables using | as delimiter
    sed -e "s|{{SITE_TITLE}}|$safe_title|g" \
        -e "s|{{SITE_DESCRIPTION}}|$safe_description|g" \
        -e "s|{{SITE_BASEURL}}|$safe_baseurl|g" \
        -e "s|{{SITE_URL}}|$safe_url|g" \
        -e "s|{{ACCENT_COLOR}}|$ACCENT_COLOR|g" \
        -e "s|{{ACCENT_COLOR_NAME}}|$ACCENT_COLOR_NAME|g" \
        -e "s|{{GITHUB_USERNAME}}|$safe_github_username|g" \
        -e "s|{{GITHUB_REPO}}|$safe_github_repo|g" \
        "$template_file" > "$output_file"
    
    echo "   ✓ Created $output_file"
}


# Function to show deployment instructions
show_deployment_instructions() {
    if [[ -n "$GIT_ROOT" ]]; then
        echo "5. Deploy to GitHub Pages:"
        echo "   git add ."
        echo "   git commit -m 'Add LBNL Jekyll site'"
        echo "   git push origin main"
        echo ""
        echo "   Then enable GitHub Pages in repository settings:"
        echo "   Settings → Pages → Source: Deploy from branch → main"
    else
        echo "5. Initialize git repository and deploy:"
        echo "   git init"
        echo "   git add ."
        echo "   git commit -m 'Initial LBNL Jekyll site'"
        echo "   git remote add origin https://github.com/USERNAME/REPO.git"
        echo "   git branch -M main"
        echo "   git push -u origin main"
        echo ""
        echo "   Then enable GitHub Pages in repository settings"
    fi
}

# Function to cleanup template files after setup
cleanup_template_files() {
    echo "🧹 Cleaning up template files..."
    
    # Remove template directories if they exist
    if [[ -d "templates" ]]; then
        rm -rf templates
        echo "   ✓ Removed templates directory"
    fi
    
    if [[ -d "scripts" ]]; then
        rm -rf scripts  
        echo "   ✓ Removed scripts directory"
    fi
    
    # Remove setup script itself
    if [[ -f "setup.sh" ]]; then
        rm setup.sh
        echo "   ✓ Removed setup.sh"
    fi
}
