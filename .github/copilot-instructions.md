# Design Asset Review Workflow

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

This repository is a **workflow automation system** that uses GitHub as a file management platform for design asset reviews. It is NOT a traditional software development project with builds, tests, or dependencies. The automation creates GitHub Issues for client feedback when design assets are moved between specific folders.

## Working Effectively

### Repository Structure
- `staging/` - Internal review folder for new design assets
- `review/` - Client feedback folder that triggers GitHub Issue creation
- `.github/workflows/create_review_issue.yml` - Automated workflow for issue creation
- `README.md` - Complete workflow documentation
- `PREVIEW_2.jpg` - Sample design asset (5831x3000 JPEG, 2.7MB)

### File Operations (All operations complete in < 1 second)
- Create staging directory: `mkdir -p staging/{ticketId}/`
- Add asset to staging: `cp /path/to/asset.jpg staging/{ticketId}/`
- Move to review: `mkdir -p review/{ticketId}/ && mv staging/{ticketId}/asset.jpg review/{ticketId}/`
- File operations are near-instantaneous (< 1 second). No special timeout considerations needed.

### Validation and Testing
- YAML validation: `yamllint .github/workflows/create_review_issue.yml` (yamllint is available)
- **CURRENT YAML ISSUES**: The workflow file has linting issues (line length, syntax errors) but is functionally working
- Git status check: `git status` (shows untracked files in review/ when new assets are added)
- Directory verification: `ls -la staging/{ticketId}/ review/{ticketId}/`

### GitHub Action Workflow
- **Trigger**: Push to main branch with changes in `review/**` paths
- **Action**: Creates GitHub Issues for each new/moved file in review folder
- **Dependencies**: Uses `tj-actions/changed-files@v35` and GitHub CLI
- **Runtime**: Typically completes in 1-2 minutes when triggered
- **Prevents duplicates**: Checks for existing issues with same ticket ID and filename

## Manual Testing Scenarios

### Test the Asset Review Workflow
Always test the complete workflow after making changes to the GitHub Action:

1. **Setup test asset**:
   ```bash
   mkdir -p /tmp/test-assets
   cp PREVIEW_2.jpg /tmp/test-assets/test-design.jpg
   ```

2. **Add to staging**:
   ```bash
   mkdir -p staging/TEST-$(date +%s)
   cp /tmp/test-assets/test-design.jpg staging/TEST-$(date +%s)/
   ```

3. **Move to review** (this should trigger the GitHub Action on push):
   ```bash
   TICKET_ID="TEST-$(date +%s)"
   mkdir -p review/$TICKET_ID
   mv staging/$TICKET_ID/test-design.jpg review/$TICKET_ID/
   git add review/$TICKET_ID/
   git commit -m "Test asset for workflow validation"
   git push origin main  # This triggers the workflow
   ```

4. **Verify results**:
   - Check GitHub Actions tab for workflow execution
   - Verify new GitHub Issue was created with asset preview
   - Confirm issue has correct ticket ID label
   - Test direct download link in issue description

### Test GitHub Action Locally (Dry Run)
You cannot fully test the GitHub Action locally, but you can validate the script logic:

1. **Validate YAML syntax**:
   ```bash
   yamllint .github/workflows/create_review_issue.yml
   # Note: This will show warnings and errors but the workflow is functional
   ```

2. **Check GitHub CLI availability**:
   ```bash
   gh --version  # Should show version 2.78.0+
   gh auth status  # Verify authentication in CI environment
   ```

3. **Simulate file detection**:
   ```bash
   # Test the file path parsing logic used in the workflow
   FILE_PATH="review/TEST-123/design-mockup.jpg"
   TICKET_ID=$(echo "$FILE_PATH" | cut -d'/' -f2)
   FILENAME=$(basename "$FILE_PATH")
   echo "Ticket ID: $TICKET_ID, Filename: $FILENAME"
   ```

## Common Tasks

### Adding New Design Assets
1. Always add assets to `staging/{ticketId}/` first for internal review
2. Use descriptive filenames (avoid spaces, use hyphens)
3. Supported formats: JPG, PNG, GIF, SVG (anything that displays in GitHub)

### Moving to Client Review
1. Create review directory: `mkdir -p review/{ticketId}/`
2. Move asset: `mv staging/{ticketId}/asset.jpg review/{ticketId}/`
3. Commit and push to main branch to trigger automation
4. GitHub Action will create issue within 1-2 minutes

### Modifying the GitHub Action
1. Always validate YAML: `yamllint .github/workflows/create_review_issue.yml`
2. Test changes on a non-main branch first
3. Use descriptive commit messages for workflow changes
4. Monitor GitHub Actions tab after pushing changes

### Troubleshooting

#### Workflow Not Triggering
- Check that files are in `review/**` path (not `staging/**`)
- Verify push is to main branch (not feature branch)
- Check GitHub Actions tab for error messages
- Ensure files are properly committed (not just staged)

#### Issues Not Created
- Check GitHub Action logs in repository's Actions tab
- Verify GitHub CLI authentication in workflow environment
- Confirm file path structure: `review/{ticketId}/{filename}`
- Check for existing issues with same ticket ID to avoid duplicates

#### YAML Linting Errors
The current workflow file has several yamllint warnings/errors but is functionally working:
- Missing document start (`---`)
- Long lines (> 80 characters)
- Syntax warnings in multi-line strings

These can be ignored unless you're making changes to the workflow file.

## Files You'll Frequently Reference

### Repository root files
```
.
├── .github/
│   └── workflows/
│       └── create_review_issue.yml
├── README.md
├── PREVIEW_2.jpg (sample asset)
├── review/ (client review folder)
└── staging/ (internal review folder)
```

### Key workflow file locations
- Main workflow: `.github/workflows/create_review_issue.yml`
- Documentation: `README.md`
- Test assets: Use `PREVIEW_2.jpg` for testing (2.7MB JPEG)

## Important Notes
- This repository has NO traditional build, test, or dependency management
- All operations are file-based and complete in seconds
- The GitHub Action is the only "code" that requires validation
- Focus on file organization and workflow automation rather than software development
- Always test workflow changes by creating actual review assets and pushing to main branch