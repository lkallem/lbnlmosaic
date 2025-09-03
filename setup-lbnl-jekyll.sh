#!/bin/bash

# LBNL Jekyll Site Setup Script
# This script creates the complete directory structure and files for your Jekyll site

set -e

echo "🔬 Setting up LBNL Jekyll site with Bootstrap and Bootswatch..."
echo ""

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

# Function to get color variables based on selection
get_color_variables() {
    local choice=$1
    case $choice in
        1|"") 
            echo "orange"
            ;;
        2)
            echo "green"
            ;;
        3)
            echo "yellow"
            ;;
        4)
            echo "red"
            ;;
        5)
            echo "dusty-rose"
            ;;
        6)
            echo "olive-green"
            ;;
        7)
            echo "blue"
            ;;
        8)
            echo "purple"
            ;;
        9)
            echo "burgundy"
            ;;
        *)
            echo "orange"
            ;;
    esac
}

# Function to get color name for display
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

# Ask user for color preference
show_color_options
read -p "Choose your accent color (1-9, or press Enter for Orange): " color_choice

accent_color=$(get_color_variables "$color_choice")
accent_color_name=$(get_color_name "$color_choice")

echo ""
echo "🎨 Selected accent color: $accent_color_name"
echo ""

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p _layouts
mkdir -p _includes
mkdir -p _sass
mkdir -p assets/css
mkdir -p pages

# Create Gemfile
echo "📦 Creating Gemfile..."
cat > Gemfile << 'EOF'
source "https://rubygems.org"

gem "jekyll", "~> 4.3.0"
gem "github-pages", group: :jekyll_plugins

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-sitemap"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
EOF

# Create _config.yml
echo "⚙️ Creating _config.yml..."
cat > _config.yml << 'EOF'
title: BXE Project
description: Berkeley Lab Computing Research - Advancing Scientific Discovery
baseurl: ""
url: "https://lbnlcomputerarch.github.io/bxe.github.io"

markdown: kramdown
highlighter: rouge
permalink: pretty

plugins:
  - jekyll-feed
  - jekyll-sitemap

collections:
  pages:
    output: true
    permalink: /:name/

defaults:
  - scope:
      path: "pages"
      type: "pages"
    values:
      layout: "default"

exclude:
  - Gemfile
  - Gemfile.lock
  - README.md
  - setup-lbnl-jekyll.sh
EOF

# Create main CSS file with selected accent color
echo "🎨 Creating main CSS file with $accent_color_name accent color..."
cat > assets/css/main.scss << EOF
---
---

// Import Bootswatch theme (using Flatly as base, but we'll customize with LBNL colors)
@import url('https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/flatly/bootstrap.min.css');

// Official LBNL Color Scheme (2025)
:root {
  // Primary Palette
  --lbnl-dark-blue: #00313C;      // Primary brand color
  --lbnl-teal: #007681;
  --lbnl-light-gray: #B1B3B3;
  --lbnl-dark-gray: #63666A;
  
  // Secondary Palette
  --lbnl-orange: #D57800;
  --lbnl-green: #74AA50;
  --lbnl-yellow: #EAAA00;
  --lbnl-red: #E04E39;
  --lbnl-dusty-rose: #E8927C;
  --lbnl-olive-green: #AC9F3C;
  --lbnl-blue: #4298B5;
  --lbnl-purple: #5D4777;
  --lbnl-burgundy: #672E45;
  
  // Project accent color (selected: $accent_color_name)
  --lbnl-accent: var(--lbnl-$accent_color);
  
  // Neutral Colors
  --lbnl-white: #ffffff;
  --lbnl-black: #000000;
}

// Override Bootstrap variables with official LBNL colors
.navbar {
  background-color: var(--lbnl-white) !important;
  border-bottom: 3px solid var(--lbnl-accent);
  box-shadow: 0 2px 4px rgba(0, 49, 60, 0.1);
}

.navbar-brand {
  color: var(--lbnl-dark-blue) !important;
  font-weight: bold;
  font-size: 1.5rem;
}

.navbar-nav .nav-link {
  color: var(--lbnl-dark-blue) !important;
  font-weight: 500;
}

.navbar-nav .nav-link:hover,
.navbar-nav .nav-link:focus {
  color: var(--lbnl-accent) !important;
}

.navbar-nav .nav-link.active {
  color: var(--lbnl-accent) !important;
  font-weight: 600;
}

// Primary buttons use Dark Blue
.btn-primary {
  background-color: var(--lbnl-dark-blue);
  border-color: var(--lbnl-dark-blue);
  color: var(--lbnl-white);
  font-weight: 500;
}

.btn-primary:hover,
.btn-primary:focus {
  background-color: var(--lbnl-teal);
  border-color: var(--lbnl-teal);
  color: var(--lbnl-white);
}

// Secondary buttons use selected accent color
.btn-secondary {
  background-color: var(--lbnl-accent);
  border-color: var(--lbnl-accent);
  color: var(--lbnl-white);
  font-weight: 500;
}

.btn-secondary:hover,
.btn-secondary:focus {
  background-color: var(--lbnl-dark-blue);
  border-color: var(--lbnl-dark-blue);
  color: var(--lbnl-white);
}

// Outline buttons
.btn-outline-primary {
  color: var(--lbnl-dark-blue);
  border-color: var(--lbnl-dark-blue);
}

.btn-outline-primary:hover {
  background-color: var(--lbnl-dark-blue);
  border-color: var(--lbnl-dark-blue);
  color: var(--lbnl-white);
}

.btn-outline-secondary {
  color: var(--lbnl-accent);
  border-color: var(--lbnl-accent);
}

.btn-outline-secondary:hover {
  background-color: var(--lbnl-accent);
  border-color: var(--lbnl-accent);
  color: var(--lbnl-white);
}

// Typography following LBNL guidelines
h1, h2, h3, h4, h5, h6 {
  color: var(--lbnl-dark-blue);
  font-weight: 600;
}

// Links use Teal for better accessibility
a {
  color: var(--lbnl-teal);
  text-decoration: none;
}

a:hover,
a:focus {
  color: var(--lbnl-dark-blue);
  text-decoration: underline;
}

// LBNL-specific components
.lbnl-header {
  background: linear-gradient(135deg, var(--lbnl-dark-blue), var(--lbnl-teal));
  color: var(--lbnl-white);
  padding: 3rem 0;
}

.lbnl-header h1 {
  color: var(--lbnl-white);
  font-weight: 300;
  font-size: 3rem;
}

.lbnl-header .lead {
  color: var(--lbnl-light-gray);
  font-size: 1.25rem;
  opacity: 0.9;
}

.lbnl-accent {
  border-left: 4px solid var(--lbnl-accent);
  padding-left: 1.5rem;
  margin: 2rem 0;
}

.lbnl-card {
  border: 1px solid var(--lbnl-light-gray);
  border-top: 4px solid var(--lbnl-accent);
}

.lbnl-badge {
  background-color: var(--lbnl-accent);
  color: var(--lbnl-white);
  font-weight: 600;
}

.lbnl-badge-dark {
  background-color: var(--lbnl-dark-blue);
  color: var(--lbnl-white);
  font-weight: 600;
}

// Alert variations using LBNL colors
.alert-lbnl-info {
  background-color: rgba(0, 118, 129, 0.1);
  border-color: var(--lbnl-teal);
  color: var(--lbnl-dark-blue);
  border-left: 4px solid var(--lbnl-teal);
}

.alert-lbnl-warning {
  background-color: rgba(234, 170, 0, 0.1);
  border-color: var(--lbnl-yellow);
  color: var(--lbnl-dark-blue);
  border-left: 4px solid var(--lbnl-yellow);
}

.alert-lbnl-success {
  background-color: rgba(116, 170, 80, 0.1);
  border-color: var(--lbnl-green);
  color: var(--lbnl-dark-blue);
  border-left: 4px solid var(--lbnl-green);
}

.alert-lbnl-accent {
  background-color: rgba(213, 120, 0, 0.1);
  border-color: var(--lbnl-accent);
  color: var(--lbnl-dark-blue);
  border-left: 4px solid var(--lbnl-accent);
}

// Footer styling
footer {
  background-color: var(--lbnl-dark-blue) !important;
  color: var(--lbnl-white);
  border-top: 3px solid var(--lbnl-accent);
}

footer p {
  color: var(--lbnl-light-gray);
  margin-bottom: 0;
}

footer a {
  color: var(--lbnl-accent);
}

footer a:hover {
  color: var(--lbnl-white);
  text-decoration: underline;
}

// Code blocks and syntax highlighting
pre, code {
  background-color: rgba(177, 179, 179, 0.1);
  border: 1px solid var(--lbnl-light-gray);
  color: var(--lbnl-dark-blue);
}

.highlight {
  background-color: rgba(177, 179, 179, 0.05);
}

// Tables
.table-lbnl {
  border-top: 2px solid var(--lbnl-accent);
}

.table-lbnl th {
  background-color: var(--lbnl-dark-blue);
  color: var(--lbnl-white);
  border-color: var(--lbnl-teal);
}

.table-lbnl td {
  border-color: var(--lbnl-light-gray);
}

.table-lbnl tbody tr:hover {
  background-color: rgba(213, 120, 0, 0.05);
}

// Progress bars
.progress-lbnl .progress-bar {
  background-color: var(--lbnl-accent);
}

// Custom utility classes
.text-lbnl-primary {
  color: var(--lbnl-dark-blue) !important;
}

.text-lbnl-accent {
  color: var(--lbnl-accent) !important;
}

.bg-lbnl-primary {
  background-color: var(--lbnl-dark-blue) !important;
  color: var(--lbnl-white);
}

.bg-lbnl-accent {
  background-color: var(--lbnl-accent) !important;
  color: var(--lbnl-white);
}

.border-lbnl-accent {
  border-color: var(--lbnl-accent) !important;
}

// Responsive adjustments
@media (max-width: 768px) {
  .lbnl-header h1 {
    font-size: 2rem;
  }
  
  .lbnl-header {
    padding: 2rem 0;
  }
  
  .lbnl-accent {
    padding-left: 1rem;
  }
}

// Accessibility improvements
:focus {
  outline: 2px solid var(--lbnl-accent);
  outline-offset: 2px;
}

// Skip to content link for accessibility
.skip-link {
  position: absolute;
  top: -40px;
  left: 6px;
  background: var(--lbnl-accent);
  color: var(--lbnl-white);
  padding: 8px;
  text-decoration: none;
  border-radius: 4px;
  font-weight: bold;
}

.skip-link:focus {
  top: 6px;
}

// Print styles
@media print {
  .navbar, footer {
    display: none;
  }
  
  body {
    color: var(--lbnl-black);
  }
  
  a {
    color: var(--lbnl-black);
    text-decoration: underline;
  }
  
  .lbnl-header {
    background: none !important;
    color: var(--lbnl-black) !important;
  }
}
EOF

# Create default layout
echo "🏗️ Creating default layout..."
cat > _layouts/default.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% if page.title %}{{ page.title }} - {% endif %}{{ site.title }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
    <!-- Add LBNL favicon if available -->
    <link rel="icon" type="image/x-icon" href="{{ '/assets/favicon.ico' | relative_url }}">
</head>
<body>
    <a class="skip-link" href="#main-content">Skip to main content</a>
    
    {% include navbar.html %}
    
    <main id="main-content">
        {{ content }}
    </main>
    
    <footer class="mt-5 py-4">
        <div class="container text-center">
            <p>&copy; {{ 'now' | date: "%Y" }} Lawrence Berkeley National Laboratory. Built with Jekyll and Bootstrap.</p>
            <p><small>This site follows the <a href="https://creative.lbl.gov/visual-identity/" target="_blank">LBNL Visual Identity Guidelines</a></small></p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF

# Create navbar include
echo "🧭 Creating navbar include..."
cat > _includes/navbar.html << 'EOF'
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <a class="navbar-brand" href="{{ '/' | relative_url }}">{{ site.title }}</a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link{% if page.url == '/' %} active{% endif %}" href="{{ '/' | relative_url }}">Home</a>
                </li>
                {% assign navbar_pages = site.pages | where: "navbar", true | sort: "order" %}
                {% for page in navbar_pages %}
                    <li class="nav-item">
                        <a class="nav-link{% if page.url == current_page.url %} active{% endif %}" href="{{ page.url | relative_url }}">{{ page.title }}</a>
                    </li>
                {% endfor %}
            </ul>
        </div>
    </div>
</nav>
EOF

# Create index page
echo "🏠 Creating index page..."
cat > index.md << EOF
---
layout: default
title: Home
---

<div class="lbnl-header">
    <div class="container">
        <h1>{{ site.title }}</h1>
        <p class="lead">Berkeley Lab Computing Research - Advancing Scientific Discovery</p>
        <div class="mt-4">
            <a href="#features" class="btn btn-secondary me-3">Learn More</a>
            <a href="https://github.com/lbnlcomputerarch/bxe.github.io" class="btn btn-outline-light">View on GitHub</a>
        </div>
    </div>
</div>

<div class="container my-5">
    <div class="row">
        <div class="col-md-8">
            <div class="lbnl-accent">
                <h2>About This Project</h2>
                <p>This project represents Berkeley Lab's commitment to advancing computational science and research excellence. Built with modern web technologies and following LBNL's official visual identity guidelines with $accent_color_name as the accent color.</p>
            </div>
            
            <section id="features">
                <h2>Project Features</h2>
                
                <p>Our platform provides cutting-edge computational resources designed for scientific research and collaboration. Key capabilities include high-performance computing integration, collaborative research tools, and seamless data management solutions.</p>
                
                <div class="row mt-4">
                    <div class="col-md-6 mb-3">
                        <div class="card lbnl-card h-100">
                            <div class="card-body">
                                <h5 class="card-title">High Performance Computing</h5>
                                <p class="card-text">Leveraging Berkeley Lab's world-class HPC resources for computational research.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card lbnl-card h-100">
                            <div class="card-body">
                                <h5 class="card-title">Collaborative Platform</h5>
                                <p class="card-text">Tools designed to facilitate collaboration among researchers worldwide.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            
            <div class="alert alert-lbnl-info mt-4" role="alert">
                <strong>Latest Updates:</strong> Check our GitHub repository for the most recent developments and contributions to the BXE project.
            </div>
            
        </div>
        <div class="col-md-4">
            <div class="lbnl-card card">
                <div class="card-body">
                    <h3 class="card-title">Quick Access</h3>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="https://github.com/lbnlcomputerarch/bxe.github.io">GitHub Repository</a></li>
                        <li class="mb-2"><a href="/about/">About the Project</a></li>
                        <li class="mb-2"><a href="/contact/">Contact Information</a></li>
                        <li class="mb-2"><a href="https://www.lbl.gov/" target="_blank">Berkeley Lab</a></li>
                    </ul>
                    
                    <div class="mt-4">
                        <button class="btn btn-primary btn-sm me-2">Get Started</button>
                        <button class="btn btn-outline-secondary btn-sm">Documentation</button>
                    </div>
                </div>
            </div>
            
            <div class="mt-4">
                <span class="lbnl-badge badge me-2">Berkeley Lab</span>
                <span class="lbnl-badge-dark badge">Open Source</span>
            </div>
        </div>
    </div>
</div>
EOF

# Create sample pages
echo "📄 Creating sample pages..."
cat > pages/about.md << 'EOF'
---
layout: default
title: About
navbar: true
order: 1
---

# About BXE

This page contains information about the BXE project. You can write your content here using Markdown.

<div class="lbnl-accent">
    <h2>Project Goals</h2>
    <p>Our mission is to advance computational science through innovative research and collaboration.</p>
</div>

## Research Areas

Our work spans multiple domains of computational science, including high-performance computing, parallel algorithms, and scientific software development. We collaborate with researchers worldwide to tackle some of the most challenging computational problems in science.

## Key Features

- **High Performance Computing**: Leveraging cutting-edge HPC resources
- **Collaborative Research**: Tools for worldwide scientific collaboration  
- **Open Science**: Commitment to open-source development and reproducible research
- **Innovation**: Pushing the boundaries of computational methodology

<div class="alert alert-lbnl-success mt-4" role="alert">
    <strong>Collaboration Welcome:</strong> We welcome collaborations with researchers and institutions worldwide.
</div>

## Team

Information about your team members can go here. You can include photos, biographies, and contact information for key personnel.

### Publications

List your recent publications and research outputs here, following standard academic citation formats.
EOF

cat > pages/contact.md << 'EOF'
---
layout: default
title: Contact
navbar: true
order: 2
---

# Contact Us

Get in touch with the BXE team for collaborations, questions, or more information about our research.

<div class="row">
    <div class="col-md-6">
        <div class="lbnl-card card">
            <div class="card-body">
                <h3 class="card-title">General Inquiries</h3>
                <ul class="list-unstyled">
                    <li><strong>Email:</strong> <a href="mailto:your-email@lbl.gov">your-email@lbl.gov</a></li>
                    <li><strong>Phone:</strong> (510) 486-XXXX</li>
                    <li><strong>GitHub:</strong> <a href="https://github.com/lbnlcomputerarch" target="_blank">lbnlcomputerarch</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-6">
        <div class="lbnl-card card">
            <div class="card-body">
                <h3 class="card-title">Address</h3>
                <address>
                    Lawrence Berkeley National Laboratory<br>
                    1 Cyclotron Road<br>
                    Berkeley, CA 94720<br>
                    United States
                </address>
            </div>
        </div>
    </div>
</div>

<div class="lbnl-accent mt-4">
    <h2>Collaboration Opportunities</h2>
    <p>We're always interested in new collaborations and partnerships. Whether you're a researcher, student, or industry professional, we welcome opportunities to work together on advancing computational science.</p>
</div>

## Research Partnerships

If you're interested in collaborating on research projects, please reach out with details about your work and how we might collaborate effectively.

## Student Opportunities

We offer various opportunities for students at all levels, from undergraduate internships to postdoctoral positions. Contact us to learn about current openings.

<div class="alert alert-lbnl-accent mt-4" role="alert">
    <strong>Note:</strong> Please allow 1-2 business days for email responses. For urgent matters, please call our main office.
</div>
EOF

# Create README with color information
echo "📖 Creating README..."
cat > README.md << EOF
# BXE Project Website

A Jekyll-based website for the BXE project, built with Bootstrap and following LBNL's visual identity guidelines.

## Color Scheme

This site uses the official LBNL color palette with **$accent_color_name** as the accent color:
- **Dark Blue (#00313C)** - Primary brand color
- **$accent_color_name** - Selected accent color
- **Teal (#007681)** - Links and interactions
- **Light Gray (#B1B3B3)** and **Dark Gray (#63666A)** - Supporting colors

## Setup

1. Install dependencies:
   \`\`\`bash
   bundle install
   \`\`\`

2. Run locally:
   \`\`\`bash
   bundle exec jekyll serve
   \`\`\`

3. Visit \`http://localhost:4000\` to view the site.

## Adding Pages

To add new pages to the navigation:

1. Create a new Markdown file in the \`pages/\` directory
2. Add the following frontmatter:
   \`\`\`yaml
   ---
   layout: default
   title: Page Title
   navbar: true
   order: 3
   ---
   \`\`\`
3. The page will automatically appear in the navigation bar

## Customizing Colors

The accent color is defined as \`--lbnl-accent\` in the CSS variables. To change it:

1. Edit \`assets/css/main.scss\`
2. Update the \`--lbnl-accent\` variable to point to your desired color
3. Available LBNL secondary colors: orange, green, yellow, red, dusty-rose, olive-green, blue, purple, burgundy

## Deployment

This site is configured for GitHub Pages deployment from the \`gh-pages\` branch.

## LBNL Brand Compliance

This site follows the [LBNL Visual Identity Guidelines](https://creative.lbl.gov/visual-identity/).
EOF

echo ""
echo "✅ LBNL Jekyll site setup complete!"
echo "🎨 Using $accent_color_name as the accent color"
echo ""
echo "Next steps:"
echo "1. Run: bundle install"
echo "2. Run: bundle exec jekyll serve"
echo "3. Open: http://localhost:4000"
echo ""
echo "To deploy to GitHub Pages:"
echo "1. git add ."
echo "2. git commit -m 'Initial LBNL Jekyll site with $accent_color_name accent'"
echo "3. git push origin gh-pages"
echo ""
echo "🔬 Happy coding with Berkeley Lab style!"
