#!/bin/bash

# LBNL Jekyll Site Setup Script
# This script creates the complete directory structure and files for your Jekyll site

set -e

echo "🔬 Setting up LBNL Jekyll site with Bootstrap and Bootswatch..."
echo ""

# Function to display Bootswatch theme options
show_bootswatch_options() {
    echo "🎨 Available Bootswatch Themes:"
    echo "Visit https://bootswatch.com/ to preview all themes"
    echo ""
    echo "Popular options:"
    echo "1. Flatly (Default) - Clean, modern theme"
    echo "2. Spacelab - Professional look with subtle gradients"
    echo "3. Cosmo - Minimalist design"
    echo "4. Litera - Clean typography-focused theme"
    echo "5. Materia - Material Design inspired"
    echo "6. Sandstone - Warm, friendly appearance"
    echo "7. Simplex - Ultra-minimal design"
    echo "8. United - Ubuntu-inspired theme"
    echo "9. Custom - Enter your own theme name"
    echo ""
}

# Function to get theme name
get_theme_name() {
    local choice=$1
    case $choice in
        1|"") echo "flatly";;
        2) echo "spacelab";;
        3) echo "cosmo";;
        4) echo "litera";;
        5) echo "materia";;
        6) echo "sandstone";;
        7) echo "simplex";;
        8) echo "united";;
        9) 
            read -p "Enter custom theme name: " custom_theme
            echo "$custom_theme"
            ;;
        *) echo "flatly";;
    esac
}

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

# Ask user for theme preference
show_bootswatch_options
read -p "Choose your Bootswatch theme (1-9, or press Enter for Flatly): " theme_choice
bootswatch_theme=$(get_theme_name "$theme_choice")

echo ""
echo "🎨 Selected theme: $bootswatch_theme"
echo ""

# Ask user for color preference
show_color_options
read -p "Choose your accent color (1-9, or press Enter for Orange): " color_choice
accent_color=$(get_color_variables "$color_choice")
accent_color_name=$(get_color_name "$color_choice")

echo ""
echo "🎨 Selected accent color: $accent_color_name"
echo ""

# Ask for site configuration
echo "⚙️ Site Configuration:"
echo "Leave blank for automatic GitHub Pages detection"
echo ""
read -p "Enter baseurl (e.g., /my-repo-name): " site_baseurl
read -p "Enter full site URL (e.g., https://username.github.io): " site_url

echo ""
echo "📋 Configuration Summary:"
echo "  Theme: $bootswatch_theme"
echo "  Accent Color: $accent_color_name"
echo "  Base URL: ${site_baseurl:-'(automatic)'}"
echo "  Site URL: ${site_url:-'(automatic)'}"
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

gem "github-pages", group: :jekyll_plugins

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-sitemap"
end

platforms :windows, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", :platforms => [:windows]
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
EOF

# Create _config.yml
echo "⚙️ Creating _config.yml..."
cat > _config.yml << EOF
title: LBNL Research Project
description: Berkeley Lab Computing Research - Advancing Scientific Discovery
baseurl: "$site_baseurl"
url: "$site_url"

markdown: kramdown
highlighter: rouge
permalink: pretty

plugins:
  - jekyll-feed
  - jekyll-sitemap

include: ['pages']

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
  - .gitignore
EOF

# Create main CSS file with selected theme and accent color
echo "🎨 Creating main CSS file with $bootswatch_theme theme and $accent_color_name accent color..."
cat > assets/css/main.scss << EOF
---
---

// Import Bootswatch theme
@import url('https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/$bootswatch_theme/bootstrap.min.css');

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

// Logo styling
.navbar-brand img {
  max-height: 40px;
  width: auto;
}

// Footer logo styling
.sponsor-logos {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-wrap: wrap;
  justify-content: center;
}

@media (min-width: 768px) {
  .sponsor-logos {
    justify-content: flex-end;
  }
}

.sponsor-logo {
  height: 32px;
  width: auto;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}

.sponsor-logo:hover {
  opacity: 1;
}

.logo-link {
  display: inline-block;
  text-decoration: none;
}

.logo-link:hover {
  text-decoration: none;
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

// [Include all the dark mode CSS from previous response here]

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
<html lang="en" data-bs-theme="auto">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% if page.title %}{{ page.title }} - {% endif %}{{ site.title }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">
    <!-- Add LBNL favicon if available -->
    <link rel="icon" type="image/png" href="{{ '/assets/logos/project-icon.png' | relative_url }}">
</head>

<body class="d-flex flex-column min-vh-100">
    <a class="skip-link" href="#main-content">Skip to main content</a>

    {% include navbar.html %}

    <main id="main-content" class="flex-grow-1">
        {% if page.url == '/' %}
        {{ content }}
        {% else %}
        <div class="container my-5">
            <div class="col-lg-8 mx-auto">
                {{ content }}
            </div>
        </div>
        {% endif %}
    </main>

    <footer class="mt-auto py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="text-center text-md-start">
                        <p class="mb-1">&copy; {{ 'now' | date: "%Y" }} <a href="https://www.lbl.gov/" target="_blank">Lawrence Berkeley National Laboratory</a>. Built with
                            <a href="https://jekyllrb.com/" target="_blank">Jekyll</a> and <a href="https://getbootstrap.com/" target="_blank">Bootstrap</a>.</p>
                        <p class="mb-0"><small>This site follows the <a href="https://creative.lbl.gov/visual-identity/"
                                    target="_blank">LBNL Visual Identity Guidelines</a></small></p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-flex justify-content-center justify-content-md-end align-items-center flex-wrap">
                        <div class="sponsor-logos">
                            {% assign sorted_sponsors = site.data.sponsors.sponsors | sort: "order" | reverse %}
                            {% for sponsor in sorted_sponsors %}
                            <a href="{{ sponsor.url }}" target="_blank" class="logo-link" title="{{ sponsor.alt }}">
                                <img src="{{ '/assets/logos/' | append: sponsor.logo | relative_url }}"
                                    alt="{{ sponsor.alt }}" class="sponsor-logo">
                            </a>
                            {% endfor %}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Dark mode toggle functionality
        const getStoredTheme = () => localStorage.getItem('theme')
        const setStoredTheme = theme => localStorage.setItem('theme', theme)

        const getPreferredTheme = () => {
            const storedTheme = getStoredTheme()
            if (storedTheme) {
                return storedTheme
            }
            return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
        }

        const setTheme = theme => {
            if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                document.documentElement.setAttribute('data-bs-theme', 'dark')
            } else {
                document.documentElement.setAttribute('data-bs-theme', theme)
            }

            // Update icon
            const themeIcon = document.getElementById('theme-icon')
            if (theme === 'dark' || (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
                themeIcon.className = 'fas fa-moon'
            } else {
                themeIcon.className = 'fas fa-sun'
            }
        }

        setTheme(getPreferredTheme())

        const showActiveTheme = (theme, focus = false) => {
            const themeSwitcher = document.querySelector('#theme-toggle')
            if (!themeSwitcher) {
                return
            }

            setTheme(theme)

            if (focus) {
                themeSwitcher.focus()
            }
        }

        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
            const storedTheme = getStoredTheme()
            if (storedTheme !== 'light' && storedTheme !== 'dark') {
                setTheme(getPreferredTheme())
            }
        })

        window.addEventListener('DOMContentLoaded', () => {
            showActiveTheme(getPreferredTheme())

            document.querySelector('#theme-toggle').addEventListener('click', () => {
                const currentTheme = document.documentElement.getAttribute('data-bs-theme')
                const newTheme = currentTheme === 'dark' ? 'light' : 'dark'
                setStoredTheme(newTheme)
                showActiveTheme(newTheme, true)
            })
        })
    </script>
</body>

</html>
EOF

# Create navbar include
echo "🧭 Creating navbar include..."
cat > _includes/navbar.html << 'EOF'
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="{{ '/' | relative_url }}">
            <img src="{{ '/assets/logos/project-logo.png' | relative_url }}" alt="{{ site.title }}" height="40"
                class="me-2">
            <span class="d-none d-sm-inline">{{ site.title }}</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto me-3">
                <li class="nav-item">
                    <a class="nav-link{% if page.url == '/' %} active{% endif %}"
                        href="{{ '/' | relative_url }}">Home</a>
                </li>
                {% assign navbar_pages = site.pages | where: "navbar", true | sort: "order" %}
                {% for nav_page in navbar_pages %}
                <li class="nav-item">
                    <a class="nav-link{% if page.url == nav_page.url %} active{% endif %}"
                        href="{{ nav_page.url | relative_url }}">{{ nav_page.title }}</a>
                </li>
                {% endfor %}
            </ul>

            <!-- Dark mode toggle - rightmost -->
            <button class="btn btn-outline-secondary" id="theme-toggle" aria-label="Toggle dark mode">
                <i class="fas fa-sun" id="theme-icon"></i>
            </button>
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
            <a href="https://github.com/your-username/your-repo" class="btn btn-outline-light">View on GitHub</a>
        </div>
    </div>
</div>

<div class="container my-5">
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
            <div class="col-md-6 mb-3">
                <div class="card lbnl-card h-100">
                    <div class="card-body">
                        <h5 class="card-title">Open Science</h5>
                        <p class="card-text">Commitment to open-source development and reproducible research methodologies.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card lbnl-card h-100">
                    <div class="card-body">
                        <h5 class="card-title">Innovation</h5>
                        <p class="card-text">Pushing the boundaries of computational methodology and scientific discovery.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <div class="alert alert-lbnl-info mt-4" role="alert">
        <strong>Latest Updates:</strong> Check our GitHub repository for the most recent developments and contributions to this project.
    </div>
    
    <div class="text-center mt-5">
        <span class="lbnl-badge badge me-2">Berkeley Lab</span>
        <span class="lbnl-badge-dark badge me-2">Open Source</span>
        <span class="lbnl-badge badge">Research</span>
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
permalink: /about/
---

# About Our Research

This page contains information about our research project. Our work represents Berkeley Lab's commitment to advancing computational science and research excellence.

<div class="lbnl-accent">
    <h2>Project Goals</h2>
    <p>Our mission is to advance computational science through innovative research and collaboration, leveraging Berkeley Lab's world-class resources and expertise.</p>
</div>

## Research Areas

Our work spans multiple domains of computational science, including high-performance computing, parallel algorithms, and scientific software development. We collaborate with researchers worldwide to tackle some of the most challenging computational problems in science.

### Key Research Focus Areas

Our research encompasses several critical areas of computational science. We develop novel algorithms for high-performance computing environments, create innovative software tools for scientific discovery, and establish collaborative frameworks that enable researchers worldwide to work together effectively.

**High-Performance Computing**: We leverage cutting-edge HPC resources to solve complex scientific problems that require massive computational power. Our work includes developing scalable algorithms, optimizing performance on modern architectures, and creating tools that make HPC resources more accessible to researchers.

**Scientific Software Development**: We create robust, reliable software tools that enable scientific discovery across multiple disciplines. Our software development practices emphasize reproducibility, usability, and long-term sustainability.

**Collaborative Research**: We believe that the most significant scientific breakthroughs come from collaboration. Our platform provides tools and frameworks that facilitate collaboration among researchers, institutions, and disciplines.

## Key Features

- **Advanced Computing Resources**: Access to Berkeley Lab's state-of-the-art computational facilities
- **Collaborative Tools**: Platforms designed for seamless research collaboration
- **Open Science Practices**: Commitment to open-source development and reproducible research
- **Innovation Focus**: Pushing the boundaries of computational methodology and scientific discovery
- **Educational Outreach**: Training the next generation of computational scientists

<div class="alert alert-lbnl-success mt-4" role="alert">
    <strong>Collaboration Welcome:</strong> We welcome collaborations with researchers and institutions worldwide. Our interdisciplinary approach brings together experts from various fields to address complex scientific challenges.
</div>

## Our Approach

We believe in the power of computational science to drive discovery and innovation. Our approach combines theoretical rigor with practical application, ensuring that our research has real-world impact while advancing the fundamental understanding of computational methods.

### Methodology

Our research methodology emphasizes reproducibility, collaboration, and innovation. We use rigorous testing procedures, maintain comprehensive documentation, and share our findings with the broader scientific community through publications, conferences, and open-source software releases.

## Impact and Applications

Our research has applications across numerous scientific domains, from climate modeling and materials science to biology and astronomy. By developing general-purpose computational tools and methods, we enable researchers in diverse fields to tackle problems that were previously computationally intractable.

### Future Directions

Looking ahead, we continue to explore emerging technologies and computational paradigms. Our future research directions include quantum computing applications, machine learning integration, and next-generation high-performance computing architectures.

## Team and Collaborations

Our team consists of researchers, software developers, and students from diverse backgrounds, all united by a passion for computational science and scientific discovery. We maintain active collaborations with universities, national laboratories, and industry partners worldwide.

### Publications and Outputs

Our research outputs include peer-reviewed publications, open-source software packages, and contributions to scientific conferences. We believe in sharing our work openly to maximize its impact on the scientific community.

<div class="alert alert-lbnl-accent mt-4" role="alert">
    <strong>Learn More:</strong> For detailed information about our specific research projects and recent publications, please visit our publications page or contact us directly.
</div>
EOF

cat > pages/contact.md << 'EOF'
---
layout: default
title: Contact
navbar: true
order: 2
permalink: /contact/
---

# Contact Us

Get in touch with our research team for collaborations, questions, or more information about our computational science research.

<div class="row">
    <div class="col-md-6">
        <div class="lbnl-card card">
            <div class="card-body">
                <h3 class="card-title">General Inquiries</h3>
                <ul class="list-unstyled">
                    <li class="mb-2"><strong>Email:</strong> <a href="mailto:research-team@lbl.gov">research-team@lbl.gov</a></li>
                    <li class="mb-2"><strong>Phone:</strong> (510) 486-XXXX</li>
                    <li class="mb-2"><strong>GitHub:</strong> <a href="https://github.com/your-username" target="_blank">your-username</a></li>
                    <li class="mb-2"><strong>Office Hours:</strong> Monday-Friday, 9:00 AM - 5:00 PM (PT)</li>
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
                <p class="mt-3">
                    <strong>Mailing Address:</strong><br>
                    <small>Use the address above for all correspondence</small>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="lbnl-accent mt-4">
    <h2>Collaboration Opportunities</h2>
    <p>We're always interested in new collaborations and partnerships. Whether you're a researcher, student, or industry professional, we welcome opportunities to work together on advancing computational science and scientific discovery.</p>
</div>

## Research Partnerships

We actively seek partnerships with academic institutions, national laboratories, and industry organizations. Our collaborative research projects span multiple disciplines and leverage diverse expertise to address complex scientific challenges.

**Academic Collaborations**: We partner with universities worldwide to advance computational science research and education. These collaborations often involve joint research projects, student exchanges, and shared resources.

**Industry Partnerships**: We work with technology companies and research organizations to translate our research into practical applications and to access cutting-edge computational resources.

**International Collaborations**: Our research benefits from international partnerships that bring together diverse perspectives and expertise from around the globe.

## Student Opportunities

We offer various opportunities for students at all levels, from undergraduate internships to postdoctoral positions. Our programs provide hands-on experience with cutting-edge computational tools and methodologies.

### Available Positions

- **Undergraduate Internships**: Summer research programs for undergraduate students
- **Graduate Student Projects**: Thesis and dissertation research opportunities
- **Postdoctoral Fellowships**: Advanced research positions for recent PhD graduates
- **Visiting Scholar Programs**: Short-term positions for international researchers

### Application Process

Students and researchers interested in joining our team should submit a CV, research statement, and contact information for references. We encourage applications from candidates with diverse backgrounds and experiences.

<div class="row mt-4">
    <div class="col-md-6">
        <div class="alert alert-lbnl-info" role="alert">
            <strong>Research Inquiries:</strong> For questions about our research or potential collaborations, please email us with details about your interests and background.
        </div>
    </div>
    <div class="col-md-6">
        <div class="alert alert-lbnl-warning" role="alert">
            <strong>Technical Support:</strong> For technical questions about our software or tools, please check our documentation or submit an issue on GitHub.
        </div>
    </div>
</div>

## Visiting Berkeley Lab

Berkeley Lab welcomes visitors interested in learning about our research. All visitors must complete security procedures and obtain proper authorization before arrival.

### Visitor Information

- **Security Clearance**: Required for all visitors
- **Advance Notice**: Please contact us at least two weeks before your planned visit
- **Parking**: Limited on-site parking available; public transportation recommended
- **Accommodations**: We can provide information about nearby hotels and accommodations

## Connect With Us

Stay updated on our latest research and developments:

- **Newsletter**: Subscribe to our quarterly research newsletter
- **Social Media**: Follow us for regular updates and news
- **Conferences**: Meet us at scientific conferences and workshops
- **Seminars**: Attend our regular research seminars and presentations

<div class="alert alert-lbnl-accent mt-4" role="alert">
    <strong>Response Time:</strong> We typically respond to emails within 1-2 business days. For urgent matters, please call our main office number.
</div>

## Frequently Asked Questions

**Q: How can I access your research data or software?**
A: Most of our software is available through our GitHub repositories. Research data availability varies by project and may be subject to collaboration agreements.

**Q: Do you offer remote collaboration opportunities?**
A: Yes, we support remote collaborations and have experience working with distributed research teams.

**Q: What computational resources do you have available?**
A: We have access to Berkeley Lab's high-performance computing facilities, including specialized systems for different types of computational workloads.

**Q: How can students get involved in your research?**
A: We offer various programs for students at different levels. Please contact us with your CV and research interests for more information about available opportunities.
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

# Create .gitignore
echo "🚫 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Jekyll build files
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata

# Bundler
vendor/
Gemfile.lock

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Editor files
*.swp
*.swo
*~
.vscode/
.idea/

# Logs
*.log

# Installer Script
setup-lbnl-jekyll.sh
EOF

# Create sponsors data file
echo "📊 Creating sponsors data file..."
mkdir -p _data
cat > _data/sponsors.yaml << 'EOF'
# Sponsor configuration
# Order determines display order (right to left)
sponsors:
  - order: 1
    name: "lbnl"
    logo: "lbnl-logo.png"
    alt: "Lawrence Berkeley National Laboratory"
    url: "https://www.lbl.gov/"
    
  - order: 2
    name: "doe"
    logo: "doe-logo.png"
    alt: "U.S. Department of Energy"
    url: "https://www.energy.gov/"
    
  # Add additional sponsors as needed
  # - order: 3
  #   name: "nsf"
  #   logo: "nsf-logo.png"
  #   alt: "National Science Foundation"
  #   url: "https://www.nsf.gov/"
EOF

echo ""
echo "✅ LBNL Jekyll site setup complete!"
echo "🎨 Using $bootswatch_theme theme with $accent_color_name accent color"
echo ""
echo "Next steps:"
echo "1. Run: bundle install"
echo "2. Run: bundle exec jekyll serve --baseurl \"\""
echo "3. Open: http://localhost:4000"
echo ""
echo "To deploy to GitHub Pages:"
echo "1. Update GitHub URLs in index.md and _config.yml"
echo "2. git add ."
echo "3. git commit -m 'Initial LBNL Jekyll site with $bootswatch_theme theme'"
echo "4. git push origin main"
echo ""
echo "🔬 Happy coding with Berkeley Lab style!"
