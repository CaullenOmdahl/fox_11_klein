# **Extracted Device Information and Recommendations for OrangeFox Recovery Build for Black Shark 3 (klein)**

---

## **Table of Contents**

1. [Introduction](#introduction)
2. [Device Information](#device-information)
   - [1. Partition Layout](#1-partition-layout)
   - [2. Mounted Filesystems](#2-mounted-filesystems)
   - [3. Encryption Status](#3-encryption-status)
   - [4. Boot Properties](#4-boot-properties)
   - [5. APEX Modules](#5-apex-modules)
3. [Key Observations](#key-observations)
4. [Recommendations for OrangeFox Recovery Build](#recommendations-for-orangefox-recovery-build)
   - [1. Update `recovery.fstab`](#1-update-recoveryfstab)
   - [2. Enable Support for File-Based Encryption (FBE)](#2-enable-support-for-file-based-encryption-fbe)
   - [3. Adjust Kernel Configuration](#3-adjust-kernel-configuration)
   - [4. Include Support for Dynamic Partitions](#4-include-support-for-dynamic-partitions)
   - [5. Verify SELinux Policies](#5-verify-selinux-policies)
   - [6. Handle APEX Modules Properly](#6-handle-apex-modules-properly)
5. [Conclusion](#conclusion)
6. [Legal and Ethical Considerations](#legal-and-ethical-considerations)

---

## **Introduction**

This document summarizes the relevant information extracted from the provided data of the Black Shark 3 (`klein`) device. It aims to assist in resolving the mounting and decryption issues encountered while building OrangeFox Recovery for this device.

---

## **Device Information**

### **1. Partition Layout**

**Partition Naming Directory:**

- Located at: `/dev/block/platform/soc/1d84000.ufshc/by-name/`
- The `by-name` directory contains symbolic links to various partitions mapped to block devices.

**Key Partitions:**

- **`userdata`** (User Data Partition):
  - Symlink: `/dev/block/platform/soc/1d84000.ufshc/by-name/userdata` ➔ `/dev/block/sda18`
  - Stores user data; encrypted using File-Based Encryption (FBE).
- **`super`** (Dynamic Partitions Container):
  - Symlink: `/dev/block/platform/soc/1d84000.ufshc/by-name/super` ➔ `/dev/block/sda6`
  - Contains dynamic partitions like `system`, `vendor`, `product`, etc.

**Example Partition Entries:**

| Partition Name     | Block Device         |
|--------------------|----------------------|
| `userdata`         | `/dev/block/sda18`   |
| `super`            | `/dev/block/sda6`    |
| `metadata`         | `/dev/block/sda11`   |
| `boot_a`           | `/dev/block/sde11`   |
| `boot_b`           | `/dev/block/sde33`   |

### **2. Mounted Filesystems**

The device utilizes dynamic partitions and multiple logical volumes managed by `dm-` devices.

**Key Mount Points:**

- **Root (`/`):**
  - Mounted from: `/dev/block/dm-10`
  - Filesystem: `ext4`
  - Mount Options: `ro,seclabel,relatime,discard`
- **Data (`/data`):**
  - Mounted from: `/dev/block/dm-15`
  - Filesystem: `f2fs`
  - Mount Options: `rw,lazytime,seclabel,nosuid,nodev,noatime,background_gc=on,discard,...`
- **System Partitions:**
  - `/system_ext`: `/dev/block/dm-11`
  - `/product`: `/dev/block/dm-12`
  - `/vendor`: `/dev/block/dm-13`
  - `/odm`: `/dev/block/dm-14`
  - All use `ext4` filesystem and are mounted as read-only.

**Dynamic Partitions:**

- Indicated by devices like `/dev/block/dm-*`, which are logical partitions managed by the system.

### **3. Encryption Status**

- **Encryption State:**
  - Property: `ro.crypto.state`
  - Value: `encrypted`
  - Interpretation: The `/data` partition is encrypted.
- **Encryption Type:**
  - Property: `ro.crypto.type`
  - Value: `file`
  - Interpretation: The device uses **File-Based Encryption (FBE)**.
- **Android SDK Version:**
  - Property: `ro.build.version.sdk`
  - Value: `30`
  - Interpretation: The device is running **Android 11**.

### **4. Boot Properties**

- **Bootloader State:**
  - `ro.boot.flash.locked`: `0` (Unlocked)
  - `ro.boot.verifiedbootstate`: `orange`
  - Interpretation: Bootloader is unlocked, which is required for custom recovery installation.
- **SELinux Mode:**
  - `ro.boot.selinux`: `permissive`
  - Interpretation: SELinux is in permissive mode during boot.
- **Dynamic Partitions Support:**
  - `ro.boot.dynamic_partitions`: `true`
  - Indicates the use of dynamic partitions managed by the Logical Partition system.

### **5. APEX Modules**

APEX modules are used for modular system components in Android 10 and above. The device has several APEX modules mounted under `/apex/`.

**List of APEX Modules:**

- `com.android.adbd`
- `com.android.apex.cts.shim`
- `com.android.art`
- `com.android.cellbroadcast`
- `com.android.conscrypt`
- `com.android.extservices`
- `com.android.i18n`
- `com.android.ipsec`
- `com.android.media`
- `com.android.media.swcodec`
- `com.android.mediaprovider`
- `com.android.neuralnetworks`
- `com.android.os.statsd`
- `com.android.permission`
- `com.android.resolv`
- `com.android.runtime`
- `com.android.sdkext`
- `com.android.tethering`
- `com.android.tzdata`
- `com.android.vndk.v30`
- `com.android.wifi`

---

## **Key Observations**

- **Dynamic Partitions:** The device uses dynamic partitions, indicated by the presence of the `super` partition and multiple `dm-` devices.
- **File-Based Encryption (FBE):** The `/data` partition is encrypted using FBE, which is standard in Android 10 and above.
- **Filesystem Types:**
  - `/data`: `f2fs`
  - System partitions: `ext4`
- **Bootloader Unlocked:** Necessary for installing custom recovery images like OrangeFox Recovery.
- **SELinux in Permissive Mode:** May impact security but can aid in development and debugging.

---

## **Recommendations for OrangeFox Recovery Build**

Based on the extracted information, the following recommendations are made to adjust the OrangeFox Recovery build:

### **1. Update `recovery.fstab`**

Ensure that `recovery.fstab` accurately reflects the device's partition layout and encryption settings.

**Sample `recovery.fstab`:**

```fstab
# Platform: UFS storage
/dev/block/bootdevice/by-name/system     /system         ext4    ro,logical
/dev/block/bootdevice/by-name/vendor     /vendor         ext4    ro,logical
/dev/block/bootdevice/by-name/product    /product        ext4    ro,logical
/dev/block/bootdevice/by-name/system_ext /system_ext     ext4    ro,logical
/dev/block/bootdevice/by-name/odm        /odm            ext4    ro,logical
/dev/block/bootdevice/by-name/userdata   /data           f2fs    noatime,nosuid,nodev,discard,encryptable=footer
/dev/block/bootdevice/by-name/metadata   /metadata       ext4    noatime,nosuid,nodev,discard
```

**Notes:**

- **Use of `logical` Flag:** Indicates that the partition is part of the dynamic `super` partition.
- **Encryption Flag for `/data`:** Include `encryptable=footer` to support FBE decryption.
- **Filesystem Types:** Match the actual filesystem types used on the device.

### **2. Enable Support for File-Based Encryption (FBE)**

Include necessary binaries and libraries in the recovery build to support FBE.

**Add to `device.mk`:**

```makefile
PRODUCT_PACKAGES += \
    vold \
    vdc \
    libcryptfs_hw \
    libkeymaster_portable \
    libkeystore_binder \
    libsoftkeymasterdevice \
    libsoftkeymaster \
    libkeymaster_messages \
    gatekeeperd
```

### **3. Adjust Kernel Configuration**

Ensure the recovery kernel supports FBE and necessary cryptographic modules.

**Kernel Configurations:**

- **Enable FBE and FS Verity:**

  ```config
  CONFIG_FS_ENCRYPTION=y
  CONFIG_FSVERITY=y
  ```

- **Include Crypto Algorithms:**

  ```config
  CONFIG_CRYPTO_AES=y
  CONFIG_CRYPTO_SHA256=y
  CONFIG_CRYPTO_SHA512=y
  CONFIG_CRYPTO_XTS=y
  CONFIG_CRYPTO_USER_API_SKCIPHER=y
  ```

### **4. Include Support for Dynamic Partitions**

Ensure the recovery can handle dynamic partitions by including logical partition tools.

**Add to `device.mk`:**

```makefile
PRODUCT_PACKAGES += \
    lpmake \
    lpadd \
    lpdump \
    lpmgr \
    liblp
```

**Update `BoardConfig.mk`:**

```makefile
BOARD_USES_DYNAMIC_PARTITIONS := true
TARGET_DYNAMIC_PARTITIONS := system vendor product odm system_ext
```

### **5. Verify SELinux Policies**

Adjust SELinux settings for the recovery environment.

**Set SELinux Mode:**

- **For Development:**

  ```makefile
  BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
  ```

- **For Production:**

  - Implement proper SELinux policies and set to `enforcing`.

### **6. Handle APEX Modules Properly**

Include support for APEX modules in the recovery build.

**Add to `device.mk`:**

```makefile
PRODUCT_PACKAGES += \
    apexd \
    apexd_boot \
    apexservice
```

**Modify `init.recovery.rc`:**

```rc
on post-fs-data
    # Mount APEX modules
    exec u:object_r:system_file:s0 -- /sbin/apexsetup.sh
```

---

## **Conclusion**

By incorporating the above recommendations, you should be able to resolve the mounting and decryption issues with your OrangeFox Recovery build for the Black Shark 3 (`klein`) device. Ensuring that the recovery environment accurately reflects the device's configuration is crucial for successful operation.

**Key Actions:**

- Update `recovery.fstab` with accurate partition mappings and encryption settings.
- Include necessary binaries and libraries to support FBE.
- Adjust the kernel configuration to include required features and modules.
- Incorporate support for dynamic partitions and APEX modules.
- Verify and adjust SELinux policies as appropriate.

---

## **Legal and Ethical Considerations**

When modifying and distributing firmware components, ensure compliance with all legal and licensing requirements.

- **Manufacturer Policies:** Review Black Shark's policies regarding firmware modification and redistribution.
- **Licensing Agreements:** Comply with software licenses associated with extracted binaries and libraries.
- **Distribution Rights:** Obtain necessary permissions if you plan to distribute the recovery build publicly.
- **Personal Use:** Modifications for personal use are generally acceptable but still subject to legal guidelines.

---

**Note:** Always exercise caution when modifying device firmware. Incorrect configurations can lead to data loss or device malfunction. It is recommended to back up all important data before proceeding.