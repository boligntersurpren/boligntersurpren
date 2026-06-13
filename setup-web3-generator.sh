#!/bin/bash

################################################################################
#                                                                              #
#  WEB3 PROJECT README GENERATOR - COMPLETE AUTOMATED SETUP                   #
#  Senior Developer Automation | Production Ready | Zero Manual Steps         #
#                                                                              #
#  This script creates a fully functional Web3 project README generator       #
#  with CLI tool, GitHub Actions, and templates - all in one shot.           #
#                                                                              #
################################################################################

set -e

# Color palette
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║      WEB3 PROJECT GENERATOR - COMPLETE SETUP v1.0             ║
║      Senior Developer | 20+ Years Automation Experience       ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}\n"

# Setup directories
PROJECT_GEN_DIR="$HOME/.web3-project-generator"
mkdir -p "$PROJECT_GEN_DIR"/{templates,github-workflows}

# ============================================================================
# 1. CREATE MAIN CLI GENERATOR TOOL
# ============================================================================

cat > "$PROJECT_GEN_DIR/generate-readme.js" << 'EOFJS'
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
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}
npm install && forge install
\`\`\`

## 🚀 Getting Started

### Compile
\`\`\`bash
forge build
\`\`\`

### Test
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

Contributions welcome! Please submit a Pull Request.

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Built with 🔗 on Ethereum. Security, scalability, elegance.**
`;

const generateWeb3FrontendREADME = (data) => `# ${data.projectName}

${data.description}

## 🌐 Overview

${data.overview}

## ✨ Features

${data.features.split('\n').map(f => f.trim() ? `- ✅ ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

**Frontend:** \`React\` \`Next.js\` \`TypeScript\` \`Tailwind CSS\`
**Web3:** \`ethers.js\` \`Wagmi\` \`WalletConnect\` \`SIWE\`
**Additional:** ${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Installation

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}
npm install
cp .env.example .env.local
\`\`\`

## 🚀 Quick Start

\`\`\`bash
npm run dev
\`\`\`

Open [http://localhost:3000](http://localhost:3000)

## 📱 Supported Networks

${data.networks.split('\n').map(n => n.trim() ? `- ${n.trim()}` : '').filter(n => n).join('\n')}

## 📄 License

${data.license || 'MIT'}

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **Twitter:** ${data.twitter || 'https://twitter.com/yourhandle'}

---

**Web3 Frontend Excellence. 🚀**
`;

const generateDeFiProtocolREADME = (data) => `# ${data.projectName}

${data.description}

## 📊 Protocol Overview

${data.overview}

## 🎯 Core Mechanics

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 💻 Tech Stack

**Contracts:** \`Solidity\` \`Foundry\` \`OpenZeppelin\`
**Integration:** ${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Setup

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}
npm install && forge install
\`\`\`

## 🚀 Deployment

\`\`\`bash
forge script script/Deploy.s.sol --rpc-url \$RPC_URL --private-key \$PRIVATE_KEY --broadcast
\`\`\`

## 📈 Protocol Metrics

- **TVL:** ${data.tvl || 'TBD'}
- **Chains:** ${data.networks || 'Ethereum, Arbitrum, Optimism'}
- **Governance:** ${data.governance || 'DAO'}

## 🔒 Security

${data.securityNotes.split('\n').map(s => s.trim() ? `- ${s.trim()}` : '').filter(s => s).join('\n')}

## 📄 License

${data.license || 'MIT'}

## 📞 Support

- **Discord:** ${data.discord || 'https://discord.gg/your-server'}
- **Email:** ${data.email}

---

**DeFi Innovation. Security First. 🔗**
`;

const generateDevOpsREADME = (data) => `# ${data.projectName}

${data.description}

## 🏛️ Infrastructure Overview

${data.overview}

## 🎯 Components

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🛠️ Tech Stack

**Infrastructure:** \`Docker\` \`Kubernetes\` \`Terraform\` \`AWS\`
**Monitoring:** ${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📦 Getting Started

\`\`\`bash
git clone https://github.com/${data.author}/${data.projectNameSlug}.git
cd ${data.projectNameSlug}
make install
\`\`\`

## 🚀 Deployment

**Docker:** \`docker build -t ${data.projectNameSlug}:latest . && docker run -p 8080:8080 ${data.projectNameSlug}:latest\`
**K8s:** \`kubectl apply -f k8s/\`
**Terraform:** \`cd terraform/ && terraform plan && terraform apply\`

## 📊 Monitoring

- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000
- ELK Stack for logs

## 📄 License

${data.license || 'MIT'}

## 📞 Contact

- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Production-Grade Infrastructure. 🚀**
`;

const generateSecurityREADME = (data) => `# ${data.projectName}

${data.description}

## 🔍 Audit Scope

${data.overview}

## 📋 Findings Summary

${data.features.split('\n').map(f => f.trim() ? `- ${f.trim()}` : '').filter(f => f).join('\n')}

## 🎯 Severity Breakdown

| Level | Count |
|-------|-------|
| Critical | ${data.criticalCount || '0'} |
| High | ${data.highCount || '0'} |
| Medium | ${data.mediumCount || '0'} |
| Low | ${data.lowCount || '0'} |

## 🛠️ Tools & Methods

${data.techStack.split('\n').map(t => t.trim() ? `\`${t.trim()}\`` : '').filter(t => t).join(' ')}

## 📊 Findings

**Critical Issues:** ${data.criticalIssues || 'None identified.'}

**High Severity:** ${data.highIssues || 'None identified.'}

## 💡 Recommendations

${data.recommendations.split('\n').map(r => r.trim() ? `- ${r.trim()}` : '').filter(r => r).join('\n')}

## 📄 License

${data.license || 'MIT'}

## 👥 Audit Info

- **Lead:** ${data.author}
- **Date:** ${new Date().toISOString().split('T')[0]}
- **Email:** ${data.email}

---

**Security First. Always. 🔒**
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

## 📄 License

${data.license || 'MIT'}

## 📞 Contact

- **Author:** ${data.author}
- **Email:** ${data.email}
- **GitHub:** https://github.com/${data.author}

---

**Built with ❤️ for Web3. 🚀**
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
  
  const data = {
    projectName: await question('📝 Project name: '),
    projectNameSlug: (await question('🔗 Project slug: ')) || '',
    description: await question('📄 Description: '),
    overview: await question('📊 Overview: '),
    features: await question('✨ Features (one per line, finish with blank line):\n'),
    techStack: await question('\n🛠️  Tech stack (one per line, finish with blank line):\n'),
    author: await question('\n👤 GitHub username: '),
    email: await question('📧 Email: '),
    license: await question('📜 License (default: MIT): ') || 'MIT',
  };
  
  if (projectType === 'smart-contract') {
    data.solidityVersion = await question('📌 Solidity version (default: v0.8.20): ') || 'v0.8.20';
    data.securityNotes = await question('🔒 Security notes (one per line, finish with blank line):\n');
  } else if (projectType === 'web3-frontend') {
    data.networks = await question('🌐 Networks (one per line, finish with blank line):\n');
    data.twitter = await question('🐦 Twitter (optional): ');
  } else if (projectType === 'defi-protocol') {
    data.tvl = await question('📈 TVL (optional): ');
    data.networks = await question('🌐 Networks (optional): ');
    data.governance = await question('🗳️  Governance (optional): ');
    data.securityNotes = await question('🔒 Security notes (one per line, finish with blank line):\n');
    data.discord = await question('💬 Discord (optional): ');
  } else if (projectType === 'devops') {
    data.scaling = await question('📈 Scaling strategy (optional): ');
  } else if (projectType === 'security') {
    data.criticalCount = await question('🔴 Critical count: ');
    data.highCount = await question('🟠 High count: ');
    data.mediumCount = await question('🟡 Medium count: ');
    data.lowCount = await question('🟢 Low count: ');
    data.criticalIssues = await question('📋 Critical issues (optional): ');
    data.highIssues = await question('📋 High issues (optional): ');
    data.recommendations = await question('💡 Recommendations (one per line, finish with blank line):\n');
  }
  
  rl.close();
  
  const generator = generators[projectType];
  const readme = generator(data);
  const outputDir = `${process.cwd()}/${data.projectNameSlug || data.projectName.toLowerCase().replace(/\s+/g, '-')}`;
  
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  fs.writeFileSync(path.join(outputDir, 'README.md'), readme);
  
  console.log(`\n✅ README generated!\n📂 ${path.join(outputDir, 'README.md')}\n`);
}

main().catch(console.error);
EOFJS

chmod +x "$PROJECT_GEN_DIR/generate-readme.js"
echo -e "${GREEN}✅ CLI Tool created${NC}"

# ============================================================================
# 2. CREATE PACKAGE.JSON
# ============================================================================

cat > "$PROJECT_GEN_DIR/package.json" << 'EOFPKG'
{
  "name": "web3-project-generator",
  "version": "1.0.0",
  "description": "Web3 Project README Generator",
  "main": "generate-readme.js",
  "bin": {
    "web3-gen": "./generate-readme.js"
  },
  "type": "commonjs",
  "author": "boligntersurpren",
  "license": "MIT"
}
EOFPKG

echo -e "${GREEN}✅ Package.json created${NC}"

# ============================================================================
# 3. CREATE GITHUB ACTIONS WORKFLOW
# ============================================================================

cat > "$PROJECT_GEN_DIR/github-workflows/generate-readme.yml" << 'EOFWF'
name: Generate README

on:
  pull_request:
    paths:
      - 'project.config.json'
  workflow_dispatch:

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: node .github/workflows/process-config.js
EOFWF

echo -e "${GREEN}✅ GitHub Actions workflow created${NC}"

# ============================================================================
# 4. CREATE CONFIG PROCESSOR
# ============================================================================

cat > "$PROJECT_GEN_DIR/github-workflows/process-config.js" << 'EOFPROC'
#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const configPath = path.join(process.cwd(), 'project.config.json');
if (!fs.existsSync(configPath)) {
  console.error('❌ project.config.json not found');
  process.exit(1);
}

const config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
console.log(`📖 Generating README for: ${config.projectName}`);

const readme = `# ${config.projectName}

${config.description}

## 📖 Overview
${config.overview}

## ✨ Features
${config.features.map(f => `- ${f}`).join('\n')}

## 🛠️ Tech Stack
${config.techStack.map(t => `\`${t}\``).join(' ')}

## 📦 Installation
\`\`\`bash
git clone https://github.com/${config.author}/${config.projectNameSlug}.git
cd ${config.projectNameSlug}
npm install
\`\`\`

## 📄 License
${config.license || 'MIT'}

## 📞 Contact
- **Author:** ${config.author}
- **Email:** ${config.email}

Auto-generated: ${new Date().toISOString()}
`;

fs.writeFileSync(path.join(process.cwd(), 'README.md'), readme);
console.log('✅ README.md generated!');
EOFPROC

chmod +x "$PROJECT_GEN_DIR/github-workflows/process-config.js"
echo -e "${GREEN}✅ Config processor created${NC}"

# ============================================================================
# 5. CREATE EXAMPLE CONFIG
# ============================================================================

cat > "$PROJECT_GEN_DIR/github-workflows/example-project.config.json" << 'EOFCFG'
{
  "projectName": "My Web3 Project",
  "projectNameSlug": "my-web3-project",
  "description": "A powerful Web3 solution",
  "overview": "This project provides cutting-edge blockchain solutions.",
  "features": ["Smart contracts", "Multi-chain", "User-friendly"],
  "techStack": ["Solidity", "React", "ethers.js"],
  "author": "boligntersurpren",
  "email": "your-email@example.com",
  "license": "MIT"
}
EOFCFG

echo -e "${GREEN}✅ Example config created${NC}"

# ============================================================================
# 6. CREATE SHELL ALIAS INSTALLER
# ============================================================================

cat > "$PROJECT_GEN_DIR/install-alias.sh" << 'EOFALIAS'
#!/bin/bash

SHELL_CONFIG=""
if [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
  SHELL_CONFIG="$HOME/.bash_profile"
fi

if [ -z "$SHELL_CONFIG" ]; then
  echo "❌ Could not detect shell"
  exit 1
fi

PROJECT_GEN_DIR="$HOME/.web3-project-generator"

if ! grep -q "web3-gen" "$SHELL_CONFIG"; then
  echo "alias web3-gen='node $PROJECT_GEN_DIR/generate-readme.js'" >> "$SHELL_CONFIG"
  echo "✅ Alias installed!"
  echo "🔄 Run: source $SHELL_CONFIG"
else
  echo "✅ Alias already exists"
fi
EOFALIAS

chmod +x "$PROJECT_GEN_DIR/install-alias.sh"
echo -e "${GREEN}✅ Alias installer created${NC}"

# ============================================================================
# 7. CREATE DOCUMENTATION
# ============================================================================

cat > "$PROJECT_GEN_DIR/README.md" << 'EOFDOC'
# Web3 Project Generator

Professional README generator for Web3 projects.

## Installation

```bash
bash ~/.web3-project-generator/install-alias.sh
source ~/.zshrc  # or ~/.bash_profile
```

## Usage

```bash
web3-gen
```

## Project Types

- **smart-contract** - Solidity contracts
- **web3-frontend** - dApps & dashboards
- **defi-protocol** - DeFi protocols
- **devops** - Infrastructure
- **security** - Security audits
- **general** - Any project

## Documentation

- Full setup: `cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md`
- Quick ref: `cat ~/.web3-project-generator/QUICK_REFERENCE.md`

## GitHub Actions

Copy workflow to `.github/workflows/` and create `project.config.json` in repo root.

---

**Made with ❤️ for Web3 developers**
EOFDOC

# ============================================================================
# 8. CREATE SETUP GUIDE
# ============================================================================

cat > "$PROJECT_GEN_DIR/SETUP_INSTRUCTIONS.md" << 'EOFGUIDE'
# Setup Instructions

## Installation

Run the alias installer:

```bash
bash ~/.web3-project-generator/install-alias.sh
```

Reload your shell:

```bash
source ~/.zshrc  # or ~/.bash_profile
```

## Usage

### Generate a README

```bash
web3-gen
```

Select your project type and answer the prompts.

### Using GitHub Actions

1. Copy workflow: `cp ~/.web3-project-generator/github-workflows/generate-readme.yml .github/workflows/`
2. Create `project.config.json` in your repo root
3. Push to GitHub

## Project Types

| Type | Use Case |
|------|----------|
| smart-contract | Solidity projects |
| web3-frontend | dApps, dashboards |
| defi-protocol | DeFi protocols |
| devops | Infrastructure |
| security | Security audits |
| general | Any project |

## Troubleshooting

**Command not found:**
```bash
bash ~/.web3-project-generator/install-alias.sh
source ~/.zshrc
```

**Permissions issue:**
```bash
chmod +x ~/.web3-project-generator/*.sh
chmod +x ~/.web3-project-generator/generate-readme.js
```

---

Questions? Contact: boligntersurpren@gmail.com
EOFGUIDE

echo -e "${GREEN}✅ Setup guide created${NC}"

# ============================================================================
# 9. CREATE QUICK REFERENCE
# ============================================================================

cat > "$PROJECT_GEN_DIR/QUICK_REFERENCE.md" << 'EOFQREF'
# Quick Reference

## One-Liner Setup

```bash
bash ~/.web3-project-generator/install-alias.sh && source ~/.zshrc && web3-gen
```

## Commands

```bash
# Generate README
web3-gen

# Install alias
bash ~/.web3-project-generator/install-alias.sh

# View guide
cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md
```

## Project Types

- `smart-contract` - Solidity/EVM
- `web3-frontend` - React/dApps
- `defi-protocol` - DeFi protocols
- `devops` - Infrastructure/K8s
- `security` - Audits/security
- `general` - Anything else

---

**Fast. Simple. Powerful.**
EOFQREF

echo -e "${GREEN}✅ Quick reference created${NC}"

# ============================================================================
# 10. DISPLAY COMPLETION BANNER
# ============================================================================

echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"

cat << "EOF"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║    ✅ WEB3 PROJECT GENERATOR - COMPLETE                       ║
║                                                                ║
║    All files created and ready to use!                        ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
EOF

echo -e "\n${BLUE}📂 Location: $PROJECT_GEN_DIR${NC}\n"

echo -e "${YELLOW}🚀 THREE QUICK STEPS:${NC}\n"
echo -e "  1. ${GREEN}bash ~/.web3-project-generator/install-alias.sh${NC}"
echo -e "  2. ${GREEN}source ~/.zshrc${NC}"
echo -e "  3. ${GREEN}web3-gen${NC}\n"

echo -e "${BLUE}📚 Documentation:${NC}"
echo -e "  • Setup: ${GREEN}cat ~/.web3-project-generator/SETUP_INSTRUCTIONS.md${NC}"
echo -e "  • Quick: ${GREEN}cat ~/.web3-project-generator/QUICK_REFERENCE.md${NC}\n"

echo -e "${GREEN}✨ You're all set! Ready to generate amazing READMEs.${NC}\n"

echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"

exit 0
