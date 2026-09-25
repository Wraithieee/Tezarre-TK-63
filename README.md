<div align="center">

# 🎮 Tezarre TK-63 — Desktop Companion

**Open-source Electron app for full RGB & profile control of the Tezarre TK-63 mechanical keyboard**

![Version](https://img.shields.io/badge/version-1.2.4-blue?style=flat-square)
![Platform](https://img.shields.io/badge/platform-Windows-0078D4?style=flat-square&logo=windows)
![Electron](https://img.shields.io/badge/Electron-latest-47848F?style=flat-square&logo=electron)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

</div>

---

## 📥 Download Installer (Windows 64-bit)

> [!TIP]
> Always download the full installer (106 MB) from the official GitHub Release link below.

### 🚀 [Download Tezarre-TK63-Setup.exe (v1.2.4 — 106 MB)](https://github.com/Wraithieee/Tezarre-TK-63/releases/download/v1.2.4/Tezarre-TK63-Setup.exe)

| Release | Installer File | Size | Architecture |
|---|---|---|---|
| **v1.2.4 (Latest)** | [`Tezarre-TK63-Setup.exe`](https://github.com/Wraithieee/Tezarre-TK-63/releases/download/v1.2.4/Tezarre-TK63-Setup.exe) | **106.7 MB** | Windows 10/11 (x64) |

#### Quick Install Steps:
1. Download [Tezarre-TK63-Setup.exe](https://github.com/Wraithieee/Tezarre-TK-63/releases/download/v1.2.4/Tezarre-TK63-Setup.exe)
2. Double-click the installer (verify file size is **~106 MB**, not 1 KB)
3. If Windows SmartScreen appears: click **More info** ➔ **Run anyway**
4. Follow the setup wizard and enjoy!

---

## ✨ Features

| Feature | Description |
|---|---|
| 🌈 **RGB Lighting** | 15+ lighting modes (Wave, Reactive, Dazzle, Static, Breathing…) |
| 🎨 **Color Studio** | Per-key color picker with full HSL/HEX control |
| 👤 **Profiles** | Save, load, and switch named lighting profiles |
| ⚡ **Speed & Brightness** | Granular hardware-level control |
| 🔌 **HID Direct** | Talks to the keyboard directly via `node-hid` — no driver installs |
| 🖥️ **Minimal Footprint** | Single-window Electron shell, GPU-accelerated at 60 fps |

---

## 🚀 Quick Start (Development)

### Prerequisites

| Tool | Version |
|---|---|
| [Node.js](https://nodejs.org) | ≥ 18 LTS |
| [npm](https://www.npmjs.com) | ≥ 9 |
| [Electron](https://www.electronjs.org) | ≥ 28 |

### 1 · Clone the repo

```bash
git clone https://github.com/<your-username>/Tezarre-TK63.git
cd Tezarre-TK63
```

### 2 · Install dependencies

```bash
cd extracted_app
npm install
```

> `node-hid` will be rebuilt against Electron automatically via `electron-rebuild` if you add it (see [Building](#building)).

### 3 · Run the app

```bash
npx electron .
```

The companion window will open. Plug in your TK-63 first — the app will detect it automatically over USB HID.

---

## 🏗️ Building

To produce a distributable Windows package:

```bash
# Install packaging tools (one-time)
npm install --save-dev electron-builder electron-rebuild

# Rebuild native modules for Electron
npx electron-rebuild

# Package for Windows x64
npx electron-builder --win --x64
```

Output will be in `dist/`.

---

## 📁 Project Structure

```
extracted_app/          ← Main Electron source
├── main.js             ← Main process (HID, IPC, window management)
├── preload.js          ← Context-bridge / preload script
├── index.html          ← Renderer entry point
├── css/
│   ├── app.css         ← Core UI styles
│   ├── keyboard-tk63.css  ← Keyboard SVG layout styles
│   ├── overlay.css     ← Modal / overlay styles
│   └── profiles.css    ← Profile panel styles
├── js/
│   ├── app.js          ← Renderer logic
│   ├── lighting.js     ← RGB mode & effect engine
│   ├── profiles.js     ← Profile save/load/switch
│   ├── dialog.js       ← Custom dialog component
│   ├── audio.js        ← Audio feedback
│   └── hid-driver.js   ← HID abstraction layer
├── tools/
│   ├── KeyBridge.cs    ← Native key-intercept helper (C#)
│   └── KeyBridge.exe   ← Pre-compiled KeyBridge binary
├── saved-settings.json ← Default settings (bundled)
└── package.json
```

---

## ⚙️ Default Settings

```json
{
  "color": "#00C8C8",
  "mode": "wave",
  "power": "on",
  "speed": 3,
  "brightness": 4,
  "dazzle": true,
  "flags": 9
}
```

User settings are saved atomically to `%APPDATA%\Tezarre-TK63\tezarre-config.json` with a rolling backup.

---

## 🔌 HID / USB Info

The app communicates directly with the TK-63 over USB HID (no kernel driver required).  
Make sure the keyboard is connected **before** launching the app.

If the keyboard isn't detected, try:
- Running as Administrator (Windows may restrict raw HID access)
- Re-plugging the USB cable

---

## 🤝 Contributing

Pull requests are welcome! Please open an issue first if you're planning a larger change.

1. Fork the repo
2. Create a feature branch (`git checkout -b feat/my-feature`)
3. Commit your changes (`git commit -m 'feat: add my feature'`)
4. Push and open a PR

---

## 📄 License

MIT © Tezarre Gaming  
See [LICENSE](LICENSE) for details.
