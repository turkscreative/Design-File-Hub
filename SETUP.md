# Design File Hub - Setup Guide

## Prerequisites

### Repository Permissions
- The repository needs to have **Issues** enabled
- Users need **write access** to move files between folders
- The GitHub Action requires **issues: write** and **contents: read** permissions (already configured)

### Dependencies
- The workflow uses:
  - `tj-actions/changed-files@v35` to detect file changes
  - `actions/checkout@v3` for repository checkout
  - GitHub CLI (`gh`) for issue creation

## Initial Setup

1. **Clone or fork this repository**
2. **Ensure Issues are enabled** in repository settings
3. **Run the setup script** (optional): `./setup.sh`
4. **Test the workflow** by following the testing steps below

## Testing the Workflow

### Step 1: Add a design file to staging
```bash
# Create a ticket folder in staging
mkdir -p staging/ticket-123

# Add your design file
cp your-design.jpg staging/ticket-123/
git add staging/ticket-123/your-design.jpg
git commit -m "Add design file for ticket-123"
git push
```

### Step 2: Move file to review when ready
```bash
# Create review folder for the ticket
mkdir -p review/ticket-123

# Move the file from staging to review
mv staging/ticket-123/your-design.jpg review/ticket-123/
git add .
git commit -m "Move design to review: ticket-123"
git push
```

### Step 3: Check for automatic issue creation
- Go to the **Issues** tab in your GitHub repository
- You should see a new issue titled "Review Asset: your-design.jpg"
- The issue will contain:
  - A preview of the image
  - Links to view and download the file
  - A label with the ticket ID

## Workflow Details

- **Trigger**: Push to `main` branch with changes in `review/**` path
- **Action**: Creates GitHub issues for new or moved files in the review folder
- **Issue Content**: Includes image preview, download links, and ticket ID
- **Duplicate Prevention**: Checks for existing issues to avoid duplicates

## Troubleshooting

### GitHub Action Not Running
- Check that the workflow file syntax is valid
- Ensure repository has Actions enabled
- Check Actions tab for error details

### Issues Not Being Created
- Verify GitHub CLI permissions
- Check that the file path follows `review/{ticketId}/{filename}` format
- Ensure Issues are enabled in repository settings

### Permission Denied Errors
- Check repository write permissions
- Verify that the GITHUB_TOKEN has necessary permissions

## File Organization

```
Design-File-Hub/
├── staging/
│   ├── ticket-001/
│   │   └── design-file.jpg
│   └── ticket-002/
│       └── logo.png
├── review/
│   └── ticket-001/
│       └── design-file.jpg    # Moved here triggers issue creation
├── .github/
│   └── workflows/
│       └── create_review_issue.yml
├── setup.sh                   # Setup and status script
└── README.md
```

## Support

If you encounter issues:
1. Check the Actions tab for workflow execution logs
2. Verify file permissions and repository settings
3. Review the workflow YAML for syntax errors
4. Test with the provided sample files first