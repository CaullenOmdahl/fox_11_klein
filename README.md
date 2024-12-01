# BlackShark 3 (codename: klein)

This is a device tree for building OrangeFox Recovery Project (OFRP) for BlackShark 3 (klein).

## Device specifications

| Feature                 | Specification                                                   |
| :---------------------- | :------------------------------------------------------------- |
| Chipset                 | Qualcomm SM8250 Snapdragon 865 (7 nm+)                        |
| CPU                     | Octa-core Kryo 300                                            |
| GPU                     | Adreno 650                                                    |
| Memory                  | 8/12 GB RAM                                                   |
| Storage                 | 128/256 GB                                                    |
| Battery                 | 4720 mAh                                                      |
| Dimensions             | 171.6 x 83.3 x 10.4 mm                                        |
| Display                | 1080 x 2400 pixels, AMOLED, 90Hz                              |
| Rear Camera            | 64 MP + 13 MP + 5 MP                                          |
| Front Camera           | 20 MP                                                         |
| Release Date           | March 2020                                                    |

## Features

- [x] Decryption
- [x] ADB
- [x] MTP
- [x] USB OTG
- [x] Backup/Restore
- [x] Flash Support

## Building on WSL2 Ubuntu 22.04 LTS

### 1. Install WSL2 and Ubuntu 22.04

```bash
# On Windows PowerShell (Admin):
wsl --install -d Ubuntu-22.04
```

### 2. Install Build Dependencies

```bash
# Update package lists
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python-is-python3

# Install OpenJDK 11
sudo apt install -y openjdk-11-jdk
```

### 3. Configure Git and Environment

```bash
# Configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Optional: Generate and add SSH key to GitLab if you prefer SSH
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
# Add this key to https://gitlab.com/-/user_settings/ssh_keys
```

### 4. Create and Setup Build Directory

```bash
# Create directory
mkdir -p ~/fox_11.0
cd ~/fox_11.0

# Clone OrangeFox Sync repo (HTTPS method)
git clone https://gitlab.com/OrangeFox/sync.git

# Or using SSH if you prefer
# git clone git@gitlab.com:OrangeFox/sync.git

# Move to sync folder and run the setup script
cd sync
./orangefox_sync.sh --branch 11.0 --path ~/fox_11.0
```

### 5. Clone Device Tree and Dependencies

```bash
# Clone device tree
git clone https://github.com/CaullenOmdahl/fox_11_klein device/blackshark/klein

# Create directories for prebuilt files
mkdir -p device/blackshark/klein/prebuilt

# Copy your prebuilt files (kernel, dtb.img, dtbo.img) to the prebuilt directory
```

### 6. Build OrangeFox Recovery

```bash
# Set up environment
source build/envsetup.sh

# Export variables
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"
export OF_MAINTAINER="Your_Name"
export FOX_VERSION="R11.1"
export FOX_BUILD_TYPE="Stable"
export TW_DEFAULT_LANGUAGE="en"

# Configure build
lunch omni_klein-eng

# Start the build
mka recoveryimage
```

The built recovery image will be located at:
```
out/target/product/klein/OrangeFox-*.zip
```

### Common Issues and Solutions

1. Sync Script Permission:

```bash
# If the sync script isn't executable
chmod +x sync/orangefox_sync.sh
```

2. Python Issues:

```bash
# If you encounter Python2 requirements
sudo apt install -y python-is-python3
sudo ln -sf /usr/bin/python3 /usr/bin/python
```

3. Permission Issues:

```bash
sudo chown -R $(whoami) ~/fox_11.0
```

4. Space Management:

```bash
# Check available space
df -h

# Clean build directory
make clean
make clobber
```

5. Java Issues:

```bash
# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
```

6. WSL2 Memory Management:
Create/Edit `%UserProfile%\.wslconfig` on Windows:
```
[wsl2]
memory=8GB
swap=8GB
processors=4
```

Then restart WSL2:

```powershell
wsl --shutdown
```

## Build Requirements
- Minimum 16GB RAM (32GB recommended)
- At least 100GB free storage (SSD recommended)
- Good internet connection
- WSL2 with Ubuntu 22.04 LTS
- Windows 10 version 2004 or higher (Build 19041 or higher)

## Notes
- This is an A/B device with dynamic partitions
- Uses File-Based Encryption (FBE)
- Based on Android 11 source
- Builds with OrangeFox Recovery Project fox_11.0 branch
- Uses prebuilt kernel, dtb, and dtbo
- For more information, visit [OrangeFox Wiki](https://wiki.orangefox.tech/en/dev/building)