# 🌍 Domain Hosting Provider Lookup 🔍

## 📌 Overview
This script reads a list of domains from `input.txt`, resolves them to IP addresses, and queries [ipinfo.io](https://ipinfo.io) to retrieve their hosting provider information. The results are saved in `output.csv`.

## 🚀 Features
- 🏷 **Domain Resolution**: Resolves domains using `nslookup` (Windows).
- 🔄 **Fallback Support**: Uses `ping` if `nslookup` fails.
- 🌐 **IP Lookup**: Queries [ipinfo.io](https://ipinfo.io) for the hosting provider.
- 📊 **CSV Output**: Saves results in `output.csv` with columns:
  - `"Domain","IP","Hosting Provider"`

## 🛠 Prerequisites
- 🖥 **Windows OS**
- 🛜 **Internet connection**
- ✅ **`curl` installed (available by default on Windows 10+)**

## 📥 Installation
1. **Clone this repository:**
   ```sh
   git clone https://github.com/yourusername/domain-hosting-lookup.git
   cd domain-hosting-lookup
   ```

2. **Ensure `curl` is installed:**  
   ```sh
   where curl
   ```

3. **Edit `input.txt`**: Add domains (one per line). Example:
   ```txt
   example.com
   google.com
   cloudflare.com
   ```

## ⚡ Usage
Run the batch file:
```sh
lookup.bat
```

## 📂 Output Example (`output.csv`):
```csv
"Domain","IP","Hosting Provider"
"example.com","93.184.216.34","AS15133 Edgecast"
"test.com","No IP Found","N/A"
```

## 📜 License
This project is licensed under the **MIT License**.

## 📧 Contact
For any issues or feature requests, open a GitHub issue! 🛠

