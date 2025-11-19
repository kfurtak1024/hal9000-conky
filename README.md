<h1 align="center">
  <img src="https://github.com/kfurtak1024/hal9000-conky/raw/main/images/hal9000.svg">
</h1>
<p align="center">
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/github/license/kfurtak1024/hal9000-conky"/></a>
</p>

A **HAL 9000** inspired **Conky theme** for monitoring system resources on Linux.

## ✨ Features

<img src="https://github.com/kfurtak1024/hal9000-conky/raw/main/images/screenshot.png" alt="HAL9000 Conky" align="right" style="margin-left: 15px; height: 180px; ">

- **CPU:** Temperature, Fan Speed, Usage, Clock Speed, and Process List
- **Memory:** RAM/Swap Usage and Process List
- **GPU:** (NVIDIA) Temperature, Fan Speed, Utilization, Power Draw, and VRAM Usage
- **Storage:** Disk I/O, Temperature (for NVMe drives), and Filesystem Usage
- **Network:** IP Address, Download/Upload Speed, and Total Data Transferred

## 🧩 Dependencies

- **[Conky](https://github.com/brndnmtthws/conky)**
- **[Lua](https://www.lua.org/)** (usually included with Conky)
- **[lm-sensors](https://github.com/lm-sensors/lm-sensors)** (for CPU/motherboard temperatures)
- **NVIDIA Drivers** (for GPU monitoring)
- **Fonts:** `DejaVu Sans Mono` and `JetBrainsMono`

## 🛠️ Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/kfurtak1024/hal9000-conky.git
   cd hal9000-conky
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   The script will copy the necessary files to `~/.config/conky/hal9000` and ask if you want to launch Conky at startup.

## ▶️ Usage

After installation, you can launch the Conky theme by running:
```bash
~/.config/conky/hal9000/launch-hal9000.sh
```
If you enabled autostart during installation, it will launch automatically on your next login.

## ⚙️ Configuration

The Conky configuration is located at `~/.config/conky/hal9000/conky.conf`. You may need to edit this file to match your hardware:

- **Network Interface:** Find your network interface name (e.g., with `ip a`) and replace `wlp8s0` in the `NETWORK` section.
- **Storage Devices:** Find your disk device names (e.g., with `lsblk`) and replace `/dev/nvme0n1`, etc., in the `STORAGE` section.
- **Sensors:** You may need to adjust the sensor paths or names for temperature readings based on the output of the `sensors` command.

The Lua script at `~/.config/conky/hal9000/hal9000.lua` contains the logic for fetching much of the data. You may need to edit this file for your specific setup.

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
