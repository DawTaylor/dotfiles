# md-to-pdf

Generate a PDF from a markdown file, preserving all images and formatting.

## Usage

```
/md-to-pdf [markdown-file] [options]
```

## Arguments

- `markdown-file` (optional): Path to the markdown file. If not provided, will prompt for it.
- `--output` or `-o`: Output PDF file path (default: same name as input with .pdf extension)
- `--css`: Custom CSS file for styling
- `--no-open`: Don't open the PDF after generation

## Examples

```bash
# Generate PDF from current file
/md-to-pdf PROPOSTA_CLIENTE.md

# Specify output location
/md-to-pdf README.md -o docs/readme.pdf

# Use custom styling
/md-to-pdf proposal.md --css custom-style.css
```

## Instructions

You are a PDF generation specialist. When invoked:

1. **Identify the input file**:
   - If a file path is provided as an argument, use it
   - If no argument, ask the user which markdown file to convert
   - Validate the file exists and is a markdown file

2. **Set up the conversion environment**:
   - Check if required dependencies are installed (md-to-pdf npm package)
   - If not installed, install it temporarily or globally
   - Verify all referenced images in the markdown exist

3. **Process images**:
   - Scan the markdown for image references (both `![](image.png)` and `<img>` tags)
   - Convert relative paths to absolute paths
   - Ensure all images are accessible

4. **Generate the PDF**:
   - Use md-to-pdf or similar tool (puppeteer-based is preferred)
   - Apply proper styling for professional appearance
   - Handle code blocks, tables, and diagrams properly
   - Preserve syntax highlighting if present

5. **Default styling preferences** (unless custom CSS provided):
   - Font: System fonts (Arial/Helvetica for body, monospace for code)
   - Page size: A4
   - Margins: 2cm all sides
   - Headers: Clear hierarchy (h1, h2, h3 with proper spacing)
   - Code blocks: Light background, proper formatting
   - Tables: Borders and alternating row colors

6. **Output handling**:
   - Save to specified output path or default location
   - Show success message with output path
   - If not `--no-open`, open the PDF automatically
   - Report any warnings (missing images, formatting issues)

7. **Error handling**:
   - If images are missing, warn but continue
   - If conversion fails, provide clear error message
   - Suggest fixes for common issues

## Technical Implementation

Use one of these approaches (in order of preference):

1. **md-to-pdf** (npm): Simple, reliable, supports images
   ```bash
   npx md-to-pdf file.md --config-file pdf-config.json
   ```

2. **markdown-pdf**: Alternative with good image support
   ```bash
   npx markdown-pdf file.md -o output.pdf
   ```

3. **Pandoc** (if available): Most powerful option
   ```bash
   pandoc file.md -o output.pdf --pdf-engine=wkhtmltopdf
   ```

## Default Configuration

Create a temporary config file with these settings:

```json
{
  "pdf_options": {
    "format": "A4",
    "margin": {
      "top": "2cm",
      "right": "2cm",
      "bottom": "2cm",
      "left": "2cm"
    },
    "printBackground": true
  },
  "stylesheet_encoding": "utf-8",
  "marked_options": {
    "breaks": true,
    "gfm": true
  }
}
```

## Custom CSS Template

If no custom CSS is provided, use this default styling:

```css
body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  max-width: 100%;
  padding: 0;
  margin: 0;
}

h1, h2, h3, h4, h5, h6 {
  margin-top: 24px;
  margin-bottom: 16px;
  font-weight: 600;
  line-height: 1.25;
}

h1 { font-size: 2em; border-bottom: 2px solid #eee; padding-bottom: 0.3em; }
h2 { font-size: 1.5em; border-bottom: 1px solid #eee; padding-bottom: 0.3em; }
h3 { font-size: 1.25em; }

code {
  background-color: #f6f8fa;
  padding: 0.2em 0.4em;
  border-radius: 3px;
  font-family: 'Courier New', Courier, monospace;
  font-size: 85%;
}

pre {
  background-color: #f6f8fa;
  padding: 16px;
  border-radius: 6px;
  overflow-x: auto;
}

pre code {
  background-color: transparent;
  padding: 0;
}

table {
  border-collapse: collapse;
  width: 100%;
  margin: 16px 0;
}

table th, table td {
  border: 1px solid #ddd;
  padding: 8px 12px;
  text-align: left;
}

table th {
  background-color: #f6f8fa;
  font-weight: 600;
}

table tr:nth-child(even) {
  background-color: #f9f9f9;
}

img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 16px auto;
}

blockquote {
  border-left: 4px solid #ddd;
  padding-left: 16px;
  margin-left: 0;
  color: #666;
}

a {
  color: #0366d6;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

hr {
  border: 0;
  border-top: 1px solid #eee;
  margin: 24px 0;
}
```

## Success Criteria

- ✅ PDF generated successfully
- ✅ All images included and properly positioned
- ✅ Formatting preserved (headers, tables, code blocks)
- ✅ Professional appearance
- ✅ File saved to correct location
- ✅ User notified of completion

## Notes

- Always use absolute paths for images to avoid resolution issues
- Test that the PDF opens correctly before reporting success
- Provide file size of generated PDF
- Support both light and dark mode (use print-friendly colors)
