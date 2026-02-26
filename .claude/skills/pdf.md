# pdf

Generate a professional PDF from a markdown file with images and formatting preserved.

## Usage

```
/pdf [markdown-file]
```

## Examples

```bash
/pdf PROPOSTA_CLIENTE.md
/pdf README.md
/pdf docs/proposal.md
```

## Instructions

You are a PDF generation assistant. When this skill is invoked:

1. **Identify the markdown file**:
   - Use the file path from arguments, or
   - Ask the user which file to convert if not specified
   - Verify the file exists

2. **Check dependencies**:
   - Verify Pandoc is installed (`which pandoc`)
   - Check for PDF engines in order: weasyprint, wkhtmltopdf, pdflatex
   - If none available, suggest installation

3. **Prepare styling**:
   - Create or use existing `pdf-style.css` in the same directory
   - Use professional, clean styling suitable for business documents
   - Ensure images, tables, and code blocks render properly

4. **Generate the PDF**:
   - Use this command structure:
     ```bash
     pandoc INPUT.md -o OUTPUT.pdf \
       --pdf-engine=weasyprint \
       --css=pdf-style.css \
       --embed-resources \
       --standalone \
       --metadata title="Document Title"
     ```
   - Output file should have same name as input with `.pdf` extension
   - Use absolute paths for images if needed

5. **Verify and report**:
   - Check the PDF was created successfully
   - Report file size
   - Open the PDF automatically (unless user specifies not to)
   - Show the full path to the generated PDF

6. **CSS Template** (if pdf-style.css doesn't exist):
   Create it with professional styling including:
   - Clean fonts (system fonts)
   - Proper heading hierarchy
   - Styled code blocks
   - Well-formatted tables
   - Centered, bordered images
   - Print-friendly colors

## Default CSS

```css
body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  padding: 20px;
}

h1, h2, h3 {
  margin-top: 24px;
  margin-bottom: 16px;
  font-weight: 600;
}

h1 {
  font-size: 2em;
  border-bottom: 2px solid #e1e4e8;
  padding-bottom: 0.3em;
}

h2 {
  font-size: 1.5em;
  border-bottom: 1px solid #e1e4e8;
  padding-bottom: 0.3em;
}

code {
  background-color: #f6f8fa;
  padding: 0.2em 0.4em;
  border-radius: 3px;
  font-family: 'Courier New', monospace;
  font-size: 85%;
}

pre {
  background-color: #f6f8fa;
  padding: 16px;
  border-radius: 6px;
}

table {
  border-collapse: collapse;
  width: 100%;
  margin: 16px 0;
}

table th, table td {
  border: 1px solid #dfe2e5;
  padding: 8px 12px;
}

table th {
  background-color: #f6f8fa;
  font-weight: 600;
}

img {
  max-width: 100%;
  display: block;
  margin: 16px auto;
  border: 1px solid #e1e4e8;
  border-radius: 4px;
  padding: 8px;
}
```

## Error Handling

- If pandoc not found: "Please install Pandoc: brew install pandoc"
- If weasyprint not found: "Install WeasyPrint for better PDF generation: pip install weasyprint"
- If file not found: "File [name] does not exist"
- If conversion fails: Show the error and suggest fixes

## Success Message

```
✅ PDF generated successfully!
📄 File: [full-path-to-pdf]
📊 Size: [file-size]
🔗 Opening PDF...
```
