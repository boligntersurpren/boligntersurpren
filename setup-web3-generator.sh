#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Web3 Project Generator Setup${NC}"
echo -e "${BLUE}================================${NC}\n"

# Create main project generator directory
PROJECT_GEN_DIR="$HOME/.web3-project-generator"
mkdir -p "$PROJECT_GEN_DIR"

echo -e "${GREEN}✅ Created directory: $PROJECT_GEN_DIR${NC}\n"

# Create the CLI tool
cat > "$PROJECT_GEN_DIR/generate-readme.js" << 'EOF'
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const question = (prompt) => new Promise((resolve) => {
  rl.question(prompt, resolve);
});

const projectTypes = {
  'smart-contract': 'Smart Contract Project',
  'web3-frontend': 'Web3 Frontend Tool',
  'defi-protocol': 'DeFi Protocol',
  'devops': 'DevOps/Infrastructure',
  'security': 'Security/Audit',
  'general': 'General Web3 Project'
};

const generateSmartContractREADME = (data) => `# ${data.projectName}

${data.description}

## 📋 Overview

${data.overview}

## 🎯 Key Features

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

**Smart Contracts**
\`Solidity\` \`${data.solidityVersion || 'v0.8.20'}\` \`Foundry\` \`OpenZeppelin\`

**Additional Tools**
${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Installation

\`\`\`bash
# Clone the repository
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}

# Install dependencies
npm install
# or
forge install
\`\`\`

## 🚀 Getting Started

### Compile Contracts

\`\`\`bash
forge build
\`\`\`

### Run Tests

\`\`\`bash
forge test
\`\`\`

### Deploy

\`\`\`bash
forge script script/Deploy.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast
\`\`\`

## 🔒 Security Considerations

${data.securityNotes.split('\n').map(s => s.trim() ? `- ${s.trim()}` : '').filter(s => s).join('\n')}

## 📄 License

${data.license || 'MIT'}

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Built with 🔗 on Ethereum. Security, scalability, and elegance.**
`;

const generateWeb3FrontendREADME = (data) => `# ${data.projectName}

${data.description}

## 🌐 Overview

${data.overview}

## ✨ Features

${data.features.split('\n').map(f => f.trim() ? `- ✅ ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

**Frontend**
\`React\` \`Next.js\` \`TypeScript\` \`Tailwind CSS\`

**Web3**
\`ethers.js\` \`Wagmi\` \`WalletConnect\` \`SIWE\`

**Additional**
${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Installation

\`\`\`bash
# Clone repository
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local
# Edit .env.local with your configuration
\`\`\`

## 🚀 Quick Start

\`\`\`bash
# Development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
\`\`\`

Open [http://localhost:3000](http://localhost:3000) in your browser.

## 🔑 Configuration

Create \`.env.local\`:

\`\`\`env
NEXT_PUBLIC_INFURA_ID=your_infura_id
NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID=your_wc_project_id
\`\`\`

## 📱 Supported Networks

${data.networks.split('\n').map(n => n.trim() ? `- ${n.trim()}` : '').filter(n => n).join('\n')}

## 🎨 Project Structure

\`\`\`
src/
├── pages/
├── components/
├── hooks/
├── utils/
└── styles/
\`\`\`

## 📄 License

${data.license || 'MIT'}

## 🤝 Contributing

Contributions are welcome! Please follow our contributing guidelines.

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **Twitter:** ${data.twitter || 'https://twitter.com/yourhandle'}

---

**Built for the Web3 ecosystem. 🚀**
`;

const generateDeFiProtocolREADME = (data) => `# ${data.projectName}

${data.description}

## 📊 Protocol Overview

${data.overview}

## 🎯 Core Mechanics

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🏗️ Architecture

\`\`\`
${data.architecture || 'Smart Contract Layer\n  ↓\nOracle Integration\n  ↓\nFrontend Interface'}
\`\`\`

## 💻 Tech Stack

**Smart Contracts**
\`Solidity\` \`Foundry\` \`OpenZeppelin\`

**Protocol Integration**
${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Installation & Setup

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}

npm install
forge install
\`\`\`

## 🚀 Deployment

\`\`\`bash
# Test deployment
forge script script/Deploy.s.sol --fork-url \$RPC_URL

# Mainnet deployment
forge script script/Deploy.s.sol --rpc-url \$MAINNET_RPC --private-key \$PRIVATE_KEY --broadcast --verify
\`\`\`

## 📈 Protocol Metrics

- **TVL:** ${data.tvl || 'TBD'}
- **Supported Chains:** ${data.networks || 'Ethereum, Arbitrum, Optimism'}
- **Governance:** ${data.governance || 'DAO'}

## 🔒 Security

${data.securityNotes.split('\n').map(s => s.trim() ? `- ${s.trim()}` : '').filter(s => s).join('\n')}

## 📖 Documentation

- [Whitepaper](./docs/whitepaper.md)
- [API Reference](./docs/api.md)
- [Governance](./docs/governance.md)

## 📄 License

${data.license || 'MIT'}

## 🤝 Contributing

We welcome community contributions. Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## 📞 Support

- **Discord:** ${data.discord || 'https://discord.gg/your-server'}
- **GitHub Issues:** [Report a Bug](https://github.com/${data.author}/${data.projectNameSlug}/issues)
- **Email:** ${data.email}

---

**Advancing DeFi with innovation and security. 🔗**
`;

const generateDevOpsREADME = (data) => `# ${data.projectName}

${data.description}

## 🏛️ Infrastructure Overview

${data.overview}

## 🎯 Components

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

**Infrastructure**
\`Docker\` \`Kubernetes\` \`Terraform\` \`AWS\`

**Monitoring & Logging**
${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Getting Started

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}

# Install dependencies
make install
\`\`\`

## 🚀 Deployment

### Docker

\`\`\`bash
docker build -t ${data.projectNameSlug}:latest .
docker run -p 8080:8080 ${data.projectNameSlug}:latest
\`\`\`

### Kubernetes

\`\`\`bash
kubectl apply -f k8s/
\`\`\`

### Terraform

\`\`\`bash
cd terraform/
terraform plan
terraform apply
\`\`\`

## 📊 Monitoring

- **Prometheus:** http://localhost:9090
- **Grafana:** http://localhost:3000
- **Logs:** ELK Stack / CloudWatch

## 🔍 Health Checks

\`\`\`bash
curl http://localhost:8080/health
\`\`\`

## 📈 Scaling

${data.scaling || '- Horizontal: Auto-scaling groups with load balancing\n- Vertical: Resource optimization and caching'}

## 📄 License

${data.license || 'MIT'}

## 🤝 Contributing

Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## 📞 Contact

- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Building reliable, scalable infrastructure. 🚀**
`;

const generateSecurityREADME = (data) => `# ${data.projectName}

${data.description}

## ���� Audit Scope

${data.overview}

## 📋 Findings Summary

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🎯 Severity Breakdown

- **Critical:** ${data.criticalCount || '0'}
- **High:** ${data.highCount || '0'}
- **Medium:** ${data.mediumCount || '0'}
- **Low:** ${data.lowCount || '0'}

## 🛠️ Audit Tools & Methods

${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📊 Detailed Findings

### Critical Issues

\`\`\`
${data.criticalIssues || 'None identified.'}
\`\`\`

### High Severity

\`\`\`
${data.highIssues || 'None identified.'}
\`\`\`

### Recommendations

${data.recommendations.split('\n').map(r => r.trim() ? `- ${r.trim()}` : '').filter(r => r).join('\n')}

## ✅ Remediation Status

| Issue | Status | Fix |
|-------|--------|-----|
| ${data.remediation || 'Pending Review' | 'In Progress' | 'N/A'} |

## 📄 License

${data.license || 'MIT'}

## 👥 Audit Team

- **Lead Auditor:** ${data.author}
- **Methodology:** Manual Review + Automated Analysis
- **Audit Date:** ${new Date().toISOString().split('T')[0]}

## 📞 Contact

- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Security first. Always. 🔒**
`;

const generateGeneralREADME = (data) => `# ${data.projectName}

${data.description}

## 📖 Overview

${data.overview}

## ✨ Features

${data.features.split('\n').map(f => f.trim() ? `- ✅ ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Installation

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}
npm install
\`\`\`

## 🚀 Quick Start

\`\`\`bash
npm run dev
\`\`\`

## 📚 Documentation

See [docs/](./docs/) for detailed documentation.

## 🤝 Contributing

Contributions welcome! Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## 📄 License

${data.license || 'MIT'}

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Built with passion for Web3. 🔗**
`;

const generators = {
  'smart-contract': generateSmartContractREADME,
  'web3-frontend': generateWeb3FrontendREADME,
  'defi-protocol': generateDeFiProtocolREADME,
  'devops': generateDevOpsREADME,
  'security': generateSecurityREADME,
  'general': generateGeneralREADME
};

async function main() {
  console.log('\n🎯 Web3 Project README Generator\n');
  
  // Ask for project type
  console.log('Available project types:');
  Object.entries(projectTypes).forEach(([key, value]) => {
    console.log(`  ${key}: ${value}`);
  });
  
  const projectType = await question('\nSelect project type (default: general): ') || 'general';
  
  if (!projectTypes[projectType]) {
    console.error('❌ Invalid project type');
    process.exit(1);
  }
  
  console.log(`\n✅ Selected: ${projectTypes[projectType]}\n`);
  
  // Collect data
  const data = {
    projectName: await question('📝 Project name: '),
    projectNameSlug: (await question('🔗 Project slug (URL-friendly name): ')) || '',
    description: await question('📄 Short description (1 line): '),
    overview: await question('📊 Detailed overview (2-3 sentences): '),
    features: await question('✨ Key features (one per line, enter twice when done):\n'),
    techStack: await question('\n🛠️  Tech stack/tools (one per line, enter twice when done):\n'),
    author: await question('\n👤 GitHub username: '),
    email: await question('📧 Email: '),
    license: await question('📜 License (default: MIT): ') || 'MIT',
  };
  
  // Type-specific questions
  if (projectType === 'smart-contract') {
    data.solidityVersion = await question('📌 Solidity version (default: v0.8.20): ') || 'v0.8.20';
    data.securityNotes = await question('🔒 Security considerations (one per line, enter twice when done):\n');
  } else if (projectType === 'web3-frontend') {
    data.networks = await question('🌐 Supported networks (one per line, enter twice when done):\n');
    data.twitter = await question('🐦 Twitter handle (optional): ');
  } else if (projectType === 'defi-protocol') {
    data.tvl = await question('📈 TVL (optional): ');
    data.networks = await question('🌐 Supported networks (optional): ');
    data.governance = await question('🗳️  Governance model (optional): ');
    data.securityNotes = await question('🔒 Security notes (one per line, enter twice when done):\n');
    data.discord = await question('💬 Discord server (optional): ');
  } else if (projectType === 'devops') {
    data.scaling = await question('📈 Scaling strategy (optional): ');
  } else if (projectType === 'security') {
    data.criticalCount = await question('🔴 Critical findings count: ');
    data.highCount = await question('🟠 High findings count: ');
    data.mediumCount = await question('🟡 Medium findings count: ');
    data.lowCount = await question('🟢 Low findings count: ');
    data.criticalIssues = await question('📋 Critical issues details (optional): ');
    data.highIssues = await question('📋 High issues details (optional): ');
    data.recommendations = await question('💡 Recommendations (one per line, enter twice when done):\n');
    data.remediation = await question('✅ Remediation status (optional): ');
  }
  
  rl.close();
  
  // Generate README
  const generator = generators[projectType];
  const readme = generator(data);
  
  // Create output directory
  const outputDir = `${process.cwd()}/${data.projectNameSlug || data.projectName.toLowerCase().replace(/\s+/g, '-')}`;
  
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  // Write README
  const readmePath = path.join(outputDir, 'README.md');
  fs.writeFileSync(readmePath, readme);
  
  console.log(`\n✅ README generated successfully!\n`);
  console.log(`📂 Location: ${readmePath}\n`);
  console.log(`🎉 Your project is ready to go!\n`);
}

main().catch(console.error);
EOF

chmod +x "$PROJECT_GEN_DIR/generate-readme.js"
echo -e "${GREEN}✅ Created CLI tool: generate-readme.js${NC}\n"

# Create package.json for the CLI tool
cat > "$PROJECT_GEN_DIR/package.json" << 'EOF'
{
  "name": "web3-project-generator",
  "version": "1.0.0",
  "description": "Generate professional Web3 project READMEs",
  "main": "generate-readme.js",
  "bin": {
    "web3-gen": "./generate-readme.js"
  },
  "type": "commonjs",
  "author": "boligntersurpren",
  "license": "MIT"
}
EOF

echo -e "${GREEN}✅ Created package.json${NC}\n"

# Create .gitkeep in project-gen directory for templates
mkdir -p "$PROJECT_GEN_DIR/templates"
touch "$PROJECT_GEN_DIR/templates/.gitkeep"

# Create a shell alias installer
cat > "$PROJECT_GEN_DIR/install-alias.sh" << 'EOF'
#!/bin/bash

SHELL_CONFIG=""

if [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
  SHELL_CONFIG="$HOME/.bash_profile"
fi

if [ -z "$SHELL_CONFIG" ]; then
  echo "⚠️  Could not detect shell configuration file"
  exit 1
fi

# Add alias to shell config
if ! grep -q "web3-gen" "$SHELL_CONFIG"; then
  echo "alias web3-gen='node $PROJECT_GEN_DIR/generate-readme.js'" >> "$SHELL_CONFIG"
  echo "✅ Added 'web3-gen' alias to $SHELL_CONFIG"
  echo "🔄 Run: source $SHELL_CONFIG"
else
  echo "✅ Alias already exists in $SHELL_CONFIG"
fi
EOF

chmod +x "$PROJECT_GEN_DIR/install-alias.sh"

echo -e "${GREEN}✅ Created alias installer${NC}\n"

# Create .github/workflows directory structure
WORKFLOWS_DIR="$PROJECT_GEN_DIR/github-workflows"
mkdir -p "$WORKFLOWS_DIR"

# Create GitHub Actions workflow
cat > "$WORKFLOWS_DIR/generate-readme.yml" << 'EOF'
name: Generate README on PR

on:
  pull_request:
    paths:
      - 'project.config.json'
  workflow_dispatch:

jobs:
  generate-readme:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install generator
        run: |
          npm install -g web3-project-generator || npm install
      
      - name: Generate README from config
        run: |
          node .github/workflows/process-config.js
      
      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v4
        with:
          commit-message: 'docs: auto-generate README.md'
          title: 'docs: auto-generated README'
          body: 'This README was auto-generated from project configuration'
          branch: auto/readme-update

EOF

echo -e "${GREEN}✅ Created GitHub Actions workflow${NC}\n"

# Create GitHub Actions config processor
cat > "$WORKFLOWS_DIR/process-config.js" << 'EOF'
#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Read project config
const configPath = path.join(process.cwd(), 'project.config.json');

if (!fs.existsSync(configPath)) {
  console.error('❌ project.config.json not found');
  process.exit(1);
}

const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));

console.log('📖 Generating README from config...');
console.log(`Project: ${config.projectName}`);

// Simple template processor
const readme = `# ${config.projectName}

${config.description}

## 📖 Overview

${config.overview}

## ✨ Features

${config.features.map(f => `- ✅ ${f}`).join('\n')}

## 🛠️ Tech Stack

${config.techStack.map(t => `\`${t}\``).join(' ')}

## 📦 Installation

\`\`\`bash
git clone https://github.com/${config.author}/${config.projectNameSlug}.git
cd ${config.projectNameSlug}
npm install
\`\`\`

## 🚀 Quick Start

\`\`\`bash
npm run dev
\`\`\`

## 📄 License

${config.license || 'MIT'}

## 📞 Contact

- **Author:** ${config.author}
- **Email:** ${config.email}
- **GitHub:** https://github.com/${config.author}

---

Auto-generated README. Last updated: ${new Date().toISOString()}
`;

// Write README
fs.writeFileSync(path.join(process.cwd(), 'README.md'), readme);
console.log('✅ README.md generated successfully!');

EOF

chmod +x "$WORKFLOWS_DIR/process-config.js"

echo -e "${GREEN}✅ Created GitHub Actions config processor${NC}\n"

# Create example project config
cat > "$WORKFLOWS_DIR/example-project.config.json" << 'EOF'
{
  "projectName": "My Awesome Web3 Project",
  "projectNameSlug": "awesome-web3-project",
  "projectType": "general",
  "description": "A powerful Web3 tool for the modern developer",
  "overview": "This project provides cutting-edge solutions for blockchain development with a focus on security and usability.",
  "features": [
    "Smart contract integration",
    "Multi-chain support",
    "User-friendly interface",
    "Production-ready code"
  ],
  "techStack": [
    "Solidity",
    "React",
    "TypeScript",
    "ethers.js",
    "Foundry"
  ],
  "author": "boligntersurpren",
  "email": "your-email@example.com",
  "license": "MIT"
}
EOF

echo -e "${GREEN}✅ Created example project config${NC}\n"

# Create setup instructions file
cat > "$PROJECT_GEN_DIR/SETUP_INSTRUCTIONS.md" << 'EOF'
# 🚀 Web3 Project Generator - Setup Complete!

## What Was Created

✅ **CLI Tool** - `generate-readme.js`
✅ **Package.json** - NPM configuration
✅ **GitHub Actions** - Automated README generation
✅ **Workflows** - CI/CD templates
✅ **Examples** - Sample configurations

## 📍 Location

All files are installed in: `~/.web3-project-generator`

## 🎯 Usage

### Method 1: Using the Alias (Recommended for Mac)

```bash
# Install the alias to your shell
bash ~/.web3-project-generator/install-alias.sh

# Reload your shell
source ~/.zshrc  # if using zsh
# or
source ~/.bash_profile  # if using bash

# Now use it anywhere
web3-gen
```

### Method 2: Using Node Directly

```bash
node ~/.web3-project-generator/generate-readme.js
```

### Method 3: Using NPM Global Install

```bash
cd ~/.web3-project-generator
npm install -g .

# Now use
web3-gen
```

## 📖 How to Use

1. Run the generator:
   ```bash
   web3-gen
   ```

2. Select your project type:
   - smart-contract
   - web3-frontend
   - defi-protocol
   - devops
   - security
   - general

3. Answer the interactive prompts

4. Your README.md is generated automatically! 🎉

## 🔧 Advanced: Using GitHub Actions

1. Copy the workflow to your repo:
   ```bash
   cp ~/.web3-project-generator/github-workflows/generate-readme.yml .github/workflows/
   ```

2. Create `project.config.json` in your repo root:
   ```json
   {
     "projectName": "Your Project",
     "projectNameSlug": "your-project",
     "description": "Description",
     "overview": "Overview",
     "features": ["Feature 1", "Feature 2"],
     "techStack": ["Tech1", "Tech2"],
     "author": "your-github-username",
     "email": "your-email@example.com",
     "license": "MIT"
   }
   ```

3. Push to trigger the workflow on PR changes

## 🗂️ Directory Structure

```
~/.web3-project-generator/
├── generate-readme.js          # Main CLI tool
├── package.json               # NPM config
├── install-alias.sh           # Alias installer
├── SETUP_INSTRUCTIONS.md      # This file
├── templates/                 # Template storage
└── github-workflows/
    ├── generate-readme.yml    # GitHub Actions workflow
    ├── process-config.js      # Config processor
    └── example-project.config.json
```

## 🎨 Supported Project Types

| Type | Best For |
|------|----------|
| `smart-contract` | Solidity contracts, protocols |
| `web3-frontend` | dApps, web3 interfaces |
| `defi-protocol` | DeFi protocols, yield strategies |
| `devops` | Infrastructure, deployment |
| `security` | Audits, security reports |
| `general` | Any other project |

## 🆘 Troubleshooting

### Command not found: web3-gen
```bash
# Reinstall the alias
bash ~/.web3-project-generator/install-alias.sh
source ~/.zshrc  # or ~/.bash_profile
```

### Permission denied
```bash
chmod +x ~/.web3-project-generator/generate-readme.js
chmod +x ~/.web3-project-generator/install-alias.sh
```

### Need to update tool
```bash
cd ~/.web3-project-generator
git pull  # if it's a git repo
npm update
```

## 📚 Examples

### Example 1: Smart Contract Project

```bash
web3-gen

# Select: smart-contract
# Project name: Permit2 Authorization
# Description: Advanced token permission flows
# Features: Gas optimization, batch transactions, EIP-712 signing
```

### Example 2: Web3 Frontend

```bash
web3-gen

# Select: web3-frontend
# Project name: DeFi Dashboard
# Description: Real-time DeFi analytics
# Tech Stack: React, Next.js, ethers.js, Wagmi
```

## 🔗 Additional Resources

- [Solidity Best Practices](https://docs.soliditylang.org/)
- [Ethereum Development](https://ethereum.org/en/developers/)
- [Web3.js Documentation](https://docs.web3js.org/)
- [ethers.js Documentation](https://docs.ethers.org/)

## 🤝 Contributing

Found an issue? Want to add a new template?

```bash
cd ~/.web3-project-generator
# Make your changes
# Test with: web3-gen
```

## 📞 Support

- GitHub Issues: [Report a bug]
- Twitter: [@boligntersurpren](https://twitter.com/boligntersurpren)
- Email: boligntersurpren@gmail.com

---

**Happy building! 🚀 Let's create amazing Web3 projects together.**

Generated: $(date)
EOF

echo -e "${GREEN}✅ Created setup instructions${NC}\n"

# Create a quick reference guide
cat > "$PROJECT_GEN_DIR/QUICK_REFERENCE.md" << 'EOF'
# Quick Reference Guide

## One-Liner Commands

```bash
# Setup alias (first time only)
bash ~/.web3-project-generator/install-alias.sh && source ~/.zshrc

# Generate a README
web3-gen

# Get help
node ~/.web3-project-generator/generate-readme.js --help

# List templates
ls ~/.web3-project-generator/templates/

# View setup instructions
cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md
```

## Common Workflows

### Create Smart Contract Project README

```bash
web3-gen
# Select: smart-contract
# Answer prompts...
# ✅ Done! README.md created
```

### Create Web3 Frontend Project README

```bash
web3-gen
# Select: web3-frontend
# Answer prompts...
# ✅ Done! README.md created
```

### Setup GitHub Actions in Your Repo

```bash
# Copy workflow
cp ~/.web3-project-generator/github-workflows/generate-readme.yml YOUR_REPO/.github/workflows/

# Copy example config
cp ~/.web3-project-generator/github-workflows/example-project.config.json YOUR_REPO/project.config.json

# Edit and customize project.config.json
nano YOUR_REPO/project.config.json

# Commit and push
cd YOUR_REPO
git add .
git commit -m "Setup: Add README auto-generation workflow"
git push
```

## Project Types Quick Guide

### Smart Contract ⛓️
For Solidity contracts, protocols, and EVM projects.
- Includes: Foundry setup, contract structure, deployment guide
- Output: Professional smart contract README

### Web3 Frontend 🌐
For dApps, dashboards, and web3 interfaces.
- Includes: React/Next.js setup, wallet integration, environment config
- Output: Modern frontend project README

### DeFi Protocol 💰
For yield farming, lending, and trading protocols.
- Includes: Protocol mechanics, architecture diagram, security notes
- Output: Comprehensive protocol documentation

### DevOps 🚀
For infrastructure, deployment, and scaling.
- Includes: Docker, K8s, monitoring, health checks
- Output: Production-ready infrastructure guide

### Security 🔒
For audits, security reviews, and threat analysis.
- Includes: Findings summary, severity breakdown, remediation
- Output: Professional audit report

### General 📝
For any other project type.
- Includes: Basic structure, getting started, contribution guidelines
- Output: General-purpose README

## Tips & Tricks

💡 **Pro Tip 1:** Answer "enter twice to finish" by pressing Enter twice at end of multi-line input

💡 **Pro Tip 2:** Use slugs without spaces (e.g., `my-awesome-project` not `my awesome project`)

💡 **Pro Tip 3:** Copy the generated README to your GitHub repo immediately

💡 **Pro Tip 4:** Use the same template for consistency across your projects

💡 **Pro Tip 5:** Customize the generated README further by editing directly

## File Locations

```
~/.web3-project-generator/
├── generate-readme.js                    # Main tool
├── package.json                         # Dependencies
├── install-alias.sh                     # Setup script
├── SETUP_INSTRUCTIONS.md                # Full guide
├── QUICK_REFERENCE.md                   # This file
├── templates/                           # Storage
└── github-workflows/
    ├── generate-readme.yml              # GitHub Actions
    ├── process-config.js                # Config processor
    └── example-project.config.json      # Example config
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Command not found | Run: `bash ~/.web3-project-generator/install-alias.sh` |
| Permission denied | Run: `chmod +x ~/.web3-project-generator/*.sh` |
| Node not found | Install Node.js from nodejs.org |
| Old version | Delete `~/.web3-project-generator` and reinstall |

---

**Created by: @boligntersurpren | Web3 Systems Engineer**

Happy generating! 🚀
EOF

echo -e "${GREEN}✅ Created quick reference guide${NC}\n"

# Create final installation summary
cat > "$PROJECT_GEN_DIR/INSTALLATION_SUMMARY.txt" << 'EOF'
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║   ✅ WEB3 PROJECT GENERATOR - INSTALLATION COMPLETE!              ║
║                                                                    ║
║   Version: 1.0.0                                                  ║
║   Created: $(date)                                   ║
║   Location: ~/.web3-project-generator                            ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝

📦 WHAT WAS INSTALLED:

  ✅ CLI Tool (generate-readme.js)
  ✅ Package Configuration (package.json)
  ✅ GitHub Actions Workflow (generate-readme.yml)
  ✅ Config Processor (process-config.js)
  ✅ Documentation & Guides
  ✅ Example Configurations

🚀 GETTING STARTED (3 STEPS):

  1. Install the alias (one-time setup):
     bash ~/.web3-project-generator/install-alias.sh

  2. Reload your shell:
     source ~/.zshrc  # or ~/.bash_profile

  3. Start generating:
     web3-gen

📚 DOCUMENTATION:

  • Full Setup Guide:
    cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md

  • Quick Reference:
    cat ~/.web3-project-generator/QUICK_REFERENCE.md

  • GitHub Workflows:
    cat ~/.web3-project-generator/github-workflows/generate-readme.yml

📂 DIRECTORY STRUCTURE:

  ~/.web3-project-generator/
  ├── generate-readme.js              ← Main CLI tool
  ├── package.json                   ← NPM config
  ├── install-alias.sh               ← Alias installer
  ├── SETUP_INSTRUCTIONS.md          ← Full documentation
  ├── QUICK_REFERENCE.md             ← Quick start guide
  ├── INSTALLATION_SUMMARY.txt       ← This file
  ├── templates/                     ← Template storage
  └── github-workflows/
      ├── generate-readme.yml        ← GitHub Actions
      ├── process-config.js          ← Config processor
      └── example-project.config.json ← Example config

🎯 SUPPORTED PROJECT TYPES:

  • smart-contract   → Solidity projects, protocols
  • web3-frontend    → dApps, dashboards
  • defi-protocol    → DeFi protocols, yield farms
  • devops           → Infrastructure, K8s
  • security         → Audits, security reviews
  • general          → Any other project type

💡 NEXT STEPS:

  1. Run the installer (you're already done!):
     ✅ COMPLETE

  2. Setup the alias:
     bash ~/.web3-project-generator/install-alias.sh

  3. Try it out:
     web3-gen

  4. Choose a project type and answer the prompts

  5. Your professional README.md will be generated! 🎉

🔗 USAGE EXAMPLES:

  $ web3-gen
  🎯 Web3 Project README Generator
  
  Available project types:
    smart-contract: Smart Contract Project
    web3-frontend: Web3 Frontend Tool
    defi-protocol: DeFi Protocol
    devops: DevOps/Infrastructure
    security: Security/Audit
    general: General Web3 Project
  
  Select project type (default: general): smart-contract
  ✅ Selected: Smart Contract Project
  
  📝 Project name: Permit2 Protocol
  🔗 Project slug: permit2-protocol
  📄 Short description: Advanced token permission system
  [... more prompts ...]
  
  ✅ README generated successfully!
  📂 Location: /Users/you/permit2-protocol/README.md
  🎉 Your project is ready to go!

⚠️  FIRST TIME SETUP:

  Run this ONCE:
  bash ~/.web3-project-generator/install-alias.sh

  Then reload your shell (pick one):
  - source ~/.zshrc        (for Zsh/macOS default)
  - source ~/.bash_profile (for Bash)
  - source ~/.bashrc       (for Linux Bash)

  After reloading, you can use:
  web3-gen

🆘 NEED HELP?

  • View setup guide:
    cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md

  • View quick reference:
    cat ~/.web3-project-generator/QUICK_REFERENCE.md

  • Check GitHub workflows:
    ls ~/.web3-project-generator/github-workflows/

  • Contact: boligntersurpren@gmail.com

✨ YOU'RE ALL SET! 

  🎉 Your Web3 Project Generator is ready to use!
  
  To get started:
    1. bash ~/.web3-project-generator/install-alias.sh
    2. source ~/.zshrc (or ~/.bash_profile)
    3. web3-gen
    4. Follow the prompts!

  Happy building! 🚀

═══════════════════════════════════════════════════════════════════════

Created with ❤️ for the Web3 developer community

Version: 1.0.0
Generated: $(date)
EOF

echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"

cat "$PROJECT_GEN_DIR/INSTALLATION_SUMMARY.txt"

echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"

# Final setup instructions
echo -e "${BLUE}📋 FINAL SETUP INSTRUCTIONS:${NC}\n"

echo -e "${YELLOW}Step 1: Install the shell alias${NC}"
echo -e "  ${GREEN}bash ~/.web3-project-generator/install-alias.sh${NC}\n"

echo -e "${YELLOW}Step 2: Reload your shell${NC}"
echo -e "  ${GREEN}source ~/.zshrc${NC}  (or ${GREEN}source ~/.bash_profile${NC})\n"

echo -e "${YELLOW}Step 3: Start using the generator${NC}"
echo -e "  ${GREEN}web3-gen${NC}\n"

echo -e "${GREEN}✅ Installation Complete!${NC}\n"

echo -e "${BLUE}📚 Documentation:${NC}"
echo -e "  • Full Guide: ${GREEN}cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md${NC}"
echo -e "  • Quick Ref: ${GREEN}cat ~/.web3-project-generator/QUICK_REFERENCE.md${NC}"
echo -e "  • Summary: ${GREEN}cat ~/.web3-project-generator/INSTALLATION_SUMMARY.txt${NC}\n"

echo -e "${BLUE}🚀 Ready to generate amazing Web3 project READMEs!${NC}\n"

exit 0
