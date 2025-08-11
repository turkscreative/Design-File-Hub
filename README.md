# Design Asset Review Workflow

This repository is designed to streamline the review and feedback process for design assets. It uses a two-stage workflow to manage internal reviews and client feedback separately.

## How it Works

The workflow is built around two main folders: `staging` and `review`.

### 1. `staging` (Internal Review)

*   **Purpose:** This folder is the entry point for all new design assets that come from our external API.
*   **Workflow:**
    1.  An automated process (e.g., an n8n workflow) should be configured to download new assets and push them into this repository under the `staging/{ticketId}/` directory.
    2.  Files in the `staging` folder are intended for **internal review only**. Your team can discuss, iterate, and approve assets here before they are sent to the client.
    3.  **No client-facing review links or GitHub Issues are created for files in this folder.**

### 2. `review` (Client Feedback)

*   **Purpose:** This folder is for assets that have been internally approved and are now ready for client feedback.
*   **Workflow:**
    1.  To get client feedback on an asset, simply **move it** from the `staging/{ticketId}/` folder to the `review/{ticketId}/` folder. You can do this directly from the GitHub web interface.
    2.  As soon as a file is moved to the `review` folder, an automated GitHub Action will trigger.
    3.  This action will automatically create a new **GitHub Issue**.
    4.  The issue will contain the asset image and will serve as the **review link** that you can share with your client. All feedback and comments should be collected in this issue.

## Summary

| Folder | Purpose | Action | Result |
|---|---|---|---|
| `staging/` | Internal Review | Push new assets here from the API. | Asset is stored for the internal team. No issue created. |
| `review/` | Client Feedback | Move an asset here from `staging/`. | A new GitHub Issue is automatically created for client feedback. |

This process ensures that we have a clear separation between our internal work and client-facing reviews, and it automates the creation of review links to speed up the feedback loop.
