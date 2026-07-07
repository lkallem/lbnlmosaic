---
layout: page
title: Getting Started
parent: Documentation
permalink: /docs/getting-started
nav_order: 1
---

## Getting Started

Welcome to the Your Project documentation! This guide will help you get started with our wiki-style documentation system.

### Overview

This documentation system is built with Jekyll and Bootstrap, providing a clean and professional way to organize your project documentation.

#### Key Features

- **Responsive Design**: Works perfectly on desktop, tablet, and mobile devices
- **Automatic Navigation**: Sidebar navigation with active state highlighting
- **LBNL Branding**: Integrated with LBNL visual identity guidelines

### Quick Start

#### Creating New Wiki Pages

1. Create a new Markdown file in the `docs/` directory
2. Add the required front matter:
   ```yaml
   ---
   layout: page
   title: Your Page Title
   parent: Documentation
   nav_order: 2
   ---
   ```
3. Write your content using standard Markdown

### Content Guidelines

#### Headings

Use heading levels 2-4 for your content structure:

```markdown
## Main Section
### Subsection
#### Detail Level
```

#### Callout Boxes

Use [Just the Docs callouts](https://just-the-docs.com/docs/ui-components/callouts/) for important information:

```markdown
{: .note}
> This is an informational callout.
```

{: .note}
> This is an informational callout.

### Code Examples

Use fenced code blocks with syntax highlighting:

```javascript
function example() {
  console.log("Hello, world!");
}
```

## Best Practices

1. **Keep pages focused**: Each page should cover a specific topic
2. **Use descriptive titles**: Make page titles clear and searchable
3. **Add descriptions**: Include helpful descriptions in front matter
4. **Organize logically**: Use categories and ordering to structure content
5. **Link between pages**: Create connections between related topics

---

{: .new-title}
> Success!
>
> You're ready to start creating great documentation with this wiki system.
