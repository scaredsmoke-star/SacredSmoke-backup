# Firebase Deployment Setup

This repository is configured to automatically deploy to Firebase Hosting when changes are pushed to the `main` branch.

## Prerequisites

1. **Firebase Project**: The project is already configured to use `sacredsmoke-3b301`
2. **Firebase Token**: You need to create a Firebase token and add it as a GitHub secret

## Creating a Firebase Token

To enable the GitHub Actions workflow to deploy to Firebase, follow these steps:

### Step 1: Install Firebase CLI

```bash
npm install -g firebase-tools
```

### Step 2: Login to Firebase

```bash
firebase login
```

This will open a browser window for you to authenticate with your Google account.

### Step 3: Generate a CI Token

```bash
firebase login:ci
```

This command will generate a token that you can use for CI/CD deployments. Copy this token.

### Step 4: Add the Token to GitHub Secrets

1. Go to your repository on GitHub
2. Navigate to **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Name: `FIREBASE_TOKEN`
5. Value: Paste the token you copied in Step 3
6. Click **Add secret**

## Firebase Configuration

The repository includes the following Firebase configuration files:

- **firebase.json**: Defines hosting configuration
  - Public directory: `.` (root directory)
  - Ignores: Hidden files, node_modules, and backup scripts
  - Rewrites: All routes serve index.html (single-page app)

- **.firebaserc**: Specifies the Firebase project
  - Default project: `sacredsmoke-3b301`

## GitHub Actions Workflow

The deployment workflow (`.github/workflows/firebase-deploy.yml`) runs when:
- Changes are pushed to the `main` branch

### Workflow Steps:
1. Checkout code
2. Install Node.js 18
3. Install npm dependencies
4. Run build script (no-op for this static site)
5. Deploy to Firebase Hosting using the FIREBASE_TOKEN secret

## Manual Deployment

To manually deploy to Firebase:

```bash
# Install dependencies
npm install

# Deploy
firebase deploy --only hosting
```

## Project Structure

```
.
├── .firebaserc           # Firebase project configuration
├── .github/
│   └── workflows/
│       ├── deploy.yml            # GitHub Pages deployment (legacy)
│       └── firebase-deploy.yml   # Firebase deployment
├── .gitignore            # Git ignore rules
├── firebase.json         # Firebase hosting configuration
├── index.html            # Main HTML file
├── package.json          # Node.js package configuration
└── README.md             # Project documentation
```

## Troubleshooting

### Deployment fails with "Permission denied"
- Verify that the FIREBASE_TOKEN secret is correctly set in GitHub
- Ensure the token has not expired (regenerate if needed)

### Wrong project ID
- Check that `.firebaserc` contains the correct project ID: `sacredsmoke-3b301`
- Update the PROJECT_ID environment variable in the workflow if needed

### Files not deploying
- Check `firebase.json` to ensure the correct files are included
- Verify that ignored patterns don't exclude necessary files

## Security Notes

- Never commit the Firebase token to the repository
- Keep the FIREBASE_TOKEN secret secure in GitHub Secrets
- Regularly rotate tokens for security
