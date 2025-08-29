#!/bin/bash

# Design File Hub Setup Script
# This script demonstrates the workflow and can be used for testing

echo "=== Design File Hub Setup ==="
echo
echo "Repository structure:"
echo "├── staging/     <- Place new design assets here for internal review"
echo "├── review/      <- Move assets here to generate client review issues"
echo "└── .github/workflows/create_review_issue.yml <- Automated workflow"
echo
echo "Current repository status:"

echo
echo "Staging files:"
find staging -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.pdf" 2>/dev/null | head -10

echo
echo "Review files:"
find review -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.pdf" 2>/dev/null | head -10

echo
echo "To test the workflow:"
echo "1. Files are placed in staging/{ticketId}/ for internal review"
echo "2. When ready for client feedback, move files to review/{ticketId}/"
echo "3. GitHub Actions will automatically create an issue for client feedback"
echo
echo "Example: Move staging/ticket-001/sample-design-v1.jpg to review/ticket-001/"
echo "This will trigger the creation of a GitHub issue with the image preview."
echo
echo "=== Setup Complete ==="