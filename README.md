# HyperOS Debloater

A debloat script for HyperOS 2 via ADB.

## Tested Device
- **Device:** Redmi Note 12 4G
- **OS:** HyperOS 2.0.204.0
- **Method:** ADB via Wireless Debugging / USB

## Prerequisites

- ADB installed ([Download Platform Tools](https://developer.android.com/tools/releases/platform-tools))
- USB Debugging enabled in Developer Options

## Usage

### Method 1 — Wireless Debugging (Linux/macOS/Windows)

> Recommended for Linux/macOS users. HyperOS 2 with a locked bootloader cannot be detected via USB on Linux, but works fine over Wi-Fi.

#### 1. Enable Wireless Debugging on your device
Settings → Developer Options → Wireless Debugging → enable

#### 2. Pair your device
Tap "Pair device with pairing code" in the Wireless Debugging menu, then run:
```bash
adb pair <IP>:<PAIR_PORT> <6_DIGIT_CODE>
```

#### 3. Connect to your device
```bash
adb connect <IP>:<CONNECT_PORT>
```

#### 4. Set the serial target
```bash
export ANDROID_SERIAL=<IP>:<PORT>
```

#### 5. Run the script
```bash
chmod +x hyperos_debloater.sh
./hyperos_debloater.sh
```

---

### Method 2 — USB Debugging (Windows)

> On Windows, USB Debugging works normally thanks to the Xiaomi USB driver.

#### 1. Install the Xiaomi USB driver
Download and install the [Xiaomi USB Driver](https://xiaomitools.com/xiaomi-usb-driver/)

#### 2. Enable USB Debugging on your device
Settings → Developer Options → USB Debugging → enable

#### 3. Plug in the USB cable and tap Allow on the device prompt

#### 4. Run the script
```bash
adb devices
./hyperos_debloater.sh
```

---

## Restoring a Package

To restore any removed package:
```bash
adb shell cmd package install-existing <package.name>
```

## Notes

- All packages are removed using `pm uninstall --user 0` — **not permanent** and can be restored at any time
- No risk of bootloop
- Tested on HyperOS 2 with a locked bootloader
- `com.google.android.devicelockcontroller` and `com.preff.kb.xm` cannot be removed as they are protected by HyperOS 2
- The Wireless Debugging port may change after each device restart — check again at Settings → Developer Options → Wireless Debugging

## Disclaimer

> Use this script at your own risk. Always back up your important data before debloating.

## License

MIT License
