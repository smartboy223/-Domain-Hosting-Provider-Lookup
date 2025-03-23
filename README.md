# Domain Hosting Provider Lookup 🔍

## Overview
This script reads a list of domains from `input.txt`, resolves them to IP addresses, and queries ipinfo.io to retrieve their hosting provider information. The results are saved in `output.csv`.

## Features 🚀
- Resolves domains using `nslookup`
- Uses `ping` as a fallback if `nslookup` fails
- Queries [ipinfo.io](https://ipinfo.io) for hosting provider details
- Outputs results in `output.csv`
- Works on Windows (Batch script)

## Prerequisites 🛠
- Windows OS
- `curl` installed (Comes by default in Windows 10+)
- Internet connection

## Installation 📥
1. Clone this repository:
   ```sh
   git clone https://github.com/yourusername/domain-hosting-lookup.git
   cd domain-hosting-lookup
