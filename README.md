# LBNL Jekyll Template

A professional, wiki-style documentation template for Lawrence Berkeley National Laboratory research projects, built with the [Just the Docs](https://just-the-docs.com/) theme. It features LBNL brand-compliant styling, light/dark mode support, and a structured navigation system.

## 🚀 Quick Start

1. **Clone or Download the template**
2. **Install Dependencies**:
   ```bash
   bundle install
   ```
3. **Run Development Server**:
   ```bash
   bundle exec jekyll serve
   ```
4. **View your site**: Open [http://localhost:4000](http://localhost:4000) in your browser.

## ⚙️ Configuration

Most site settings are managed in `_config.yml`.

### Theme & Colors

Toggle between the LBNL light and dark color schemes:
```yaml
color_scheme: lbnl-light  # Or 'lbnl-dark'
```

### Branding & Logos

- **Project Logo**: Update `logo: "assets/logos/mosaiclogo.png"` in `_config.yml`.
- **Top Banner Links**: Customize the `aux_links` section in `_config.yml` to add official links to LBNL, AMCR, or your project.
- **Favicons**: To update the site icons, use a generator like [RealFaviconGenerator](https://realfavicongenerator.net/) or [favicon.io](https://favicon.io) and replace the files in `assets/favicon/`.

## ✍️ Creating Content

The template uses a wiki-style structure.

### Adding Documentation Pages

Create new Markdown files in the `docs/` directory. To ensure they appear in the sidebar, include the following in the front matter:

```yaml
---
layout: page
title: Your Page Title
parent: Documentation
nav_order: 1
---
```

- `parent`: Defines the hierarchy (e.g., "Documentation" for top-level docs).
- `nav_order`: Controls the sequence of pages in the sidebar.

### UI Components

- **Callouts**: Use Just the Docs callouts for highlights:
  ```markdown
  {: .note}
  > This is an informational note.
  ```
  Available types: `.note`, `.warning`, `.important`, `.highlight`, `.new`.
- **Mermaid Diagrams**: Use fenced code blocks with `mermaid` for diagrams:
  ```mermaid
  graph TD;
      A-->B;
  ```

## ⚖️ Footer & Legal Information

Footer branding, copyright notices, and funding acknowledgments are managed in:
`_includes/footer_custom.html`

Edit this file directly to add your specific project funding and legal disclaimers.

## 📁 Project Structure

```
.
├── _config.yml              # Site configuration & theme settings
├── Gemfile                  # Ruby dependencies
├── index.md                 # Home page
├── about.md                 # About page
├── contact.md               # Contact page
├── docs/                    # Wiki documentation pages
│   └── getting-started.md   # Example doc page
├── _includes/               # Custom header/footer components
│   ├── header_custom.html
│   └── footer_custom.html
├── _sass/                   # LBNL Brand styles
│   └── color_schemes/       # lbnl-light.scss and lbnl-dark.scss
└── assets/
    ├── logos/               # Project and LBNL branding logos
    └── favicon/             # Site icons
```

## 🛠️ Requirements

- Ruby 2.7+
- Bundler gem
- Jekyll 4.4.1+
