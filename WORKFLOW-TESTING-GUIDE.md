# End-to-End Workflow Testing Guide

## Sample Project: DESIGN-2024-001

This guide demonstrates how to test the complete Design Asset Review Workflow using the sample project DESIGN-2024-001.

## Current Status: Staging Phase ✅

The sample project is currently in the **staging phase** with 4 design assets ready for internal review:

```
staging/DESIGN-2024-001/
├── PROJECT-README.md           # Project documentation
├── brand-logo-primary.jpg      # Logo design (2.7MB)
├── website-homepage-mockup.jpg # Homepage mockup (2.7MB)  
├── mobile-app-interface.jpg    # Mobile UI design (2.7MB)
└── print-brochure-layout.jpg   # Brochure layout (2.7MB)
```

## Testing the Complete Workflow

### Step 1: Verify Staging Setup
```bash
# Check current staging status
ls -la staging/DESIGN-2024-001/

# Review project documentation
cat staging/DESIGN-2024-001/PROJECT-README.md
```

### Step 2: Move to Client Review (Triggers GitHub Action)
```bash
# Create review directory
mkdir -p review/DESIGN-2024-001/

# Move all assets to review folder
mv staging/DESIGN-2024-001/*.jpg review/DESIGN-2024-001/
mv staging/DESIGN-2024-001/PROJECT-README.md review/DESIGN-2024-001/

# Commit and push to trigger GitHub Action
git add review/DESIGN-2024-001/
git commit -m "Move DESIGN-2024-001 to client review - trigger issue creation"
git push origin main
```

### Step 3: Monitor GitHub Action Execution
1. Go to **Actions** tab in GitHub repository
2. Look for "Create Review Issue" workflow
3. Monitor execution (typically takes 1-2 minutes)
4. Check for any errors in workflow logs

### Step 4: Verify Issue Creation
The GitHub Action should create **4 individual issues**:

1. **"Review Request: brand-logo-primary.jpg (DESIGN-2024-001)"**
2. **"Review Request: website-homepage-mockup.jpg (DESIGN-2024-001)"**  
3. **"Review Request: mobile-app-interface.jpg (DESIGN-2024-001)"**
4. **"Review Request: print-brochure-layout.jpg (DESIGN-2024-001)"**

### Step 5: Validate Issue Content
Each issue should include:
- ✅ Asset preview image embedded
- ✅ Direct download link to full-resolution file
- ✅ Project context (DESIGN-2024-001 label)
- ✅ Instructions for client feedback
- ✅ Proper issue title and formatting

## Expected Results

### GitHub Issues Created
- **Count**: 4 issues (one per design asset)
- **Labels**: Each tagged with "DESIGN-2024-001"  
- **Content**: Asset previews with download links
- **Status**: Open and ready for client feedback

### Repository State After Testing
```
review/DESIGN-2024-001/
├── PROJECT-README.md           # Moved from staging
├── brand-logo-primary.jpg      # Moved from staging
├── website-homepage-mockup.jpg # Moved from staging
├── mobile-app-interface.jpg    # Moved from staging
└── print-brochure-layout.jpg   # Moved from staging

staging/DESIGN-2024-001/
└── (empty - all files moved to review)
```

### Client Experience
- Receives email notifications for new GitHub Issues
- Can view design assets directly in browser
- Downloads full-resolution files if needed
- Leaves feedback as issue comments
- Design team gets notifications for all feedback

## Troubleshooting

### If GitHub Action Doesn't Trigger
- Verify files are in `review/` folder (not `staging/`)
- Ensure push was to `main` branch
- Check that files are committed (not just staged)
- Look for errors in Actions tab

### If Issues Aren't Created
- Check GitHub Action logs for errors
- Verify GitHub CLI permissions in workflow
- Confirm file paths follow `review/{ticketId}/{filename}` structure
- Check for existing issues with same ticket ID

### YAML Linting Issues
The workflow file has known linting warnings but is functionally working:
```bash
yamllint .github/workflows/create_review_issue.yml
# Shows warnings but workflow executes correctly
```

## Success Criteria

✅ **Workflow Triggered**: GitHub Action runs after pushing to `review/`  
✅ **Issues Created**: 4 individual issues for each design asset  
✅ **Asset Previews**: Images display correctly in issue descriptions  
✅ **Download Links**: Direct links work for full-resolution files  
✅ **Labels Applied**: DESIGN-2024-001 label on all related issues  
✅ **No Duplicates**: No duplicate issues created for same files  

This sample project provides a complete end-to-end test of the Design Asset Review Workflow automation system.