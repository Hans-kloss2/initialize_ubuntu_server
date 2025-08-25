# initialize_ubuntu_server
 small initilization script for server, to save time


## Installation

Direct install
```bash
curl -fsSL https://raw.githubusercontent.com/Hans-kloss2/initialize_ubuntu_server/main/install.sh | sudo bash
```

Download and then install
```bash
curl -fsSL -o install.sh https://raw.githubusercontent.com/Hans-kloss2/initialize_ubuntu_server/main/install.sh && chmod +x install.sh && sudo ./install.sh
```

Problems with curl not fetching newest version, try this (Thanks to ChatGPT)
```bash
curl -fsSL "https://raw.githubusercontent.com/Hans-kloss2/initialize_ubuntu_server/main/install.sh?$(date +%s)" | sudo bash
```

### Improvements:
- ...