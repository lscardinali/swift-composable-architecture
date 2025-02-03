#!/bin/bash
# This script searches recursively for .md files in all subdirectories
# but excludes any directories named "migrationGuides" and "Deprecations".
# It then concatenates all found markdown files into a single file.

# Set output file name
output_file="documentation.md"

# Remove the output file if it already exists
[ -f "$output_file" ] && rm "$output_file"

# Use find to search for markdown files, excluding the specified directories
# The -prune option tells find not to descend into these directories.
find . \( -name "migrationGuides" -o -name "Deprecations" \) -prune -o -type f -name "*.md" -print | sort | while read -r file; do
    echo "Appending $file..."
    # Optionally, insert a header for each file in the output.
    echo "### File: $file" >> "$output_file"
    echo "" >> "$output_file"
    cat "$file" >> "$output_file"
    echo -e "\n\n" >> "$output_file"
done

echo "All markdown files have been concatenated into $output_file."