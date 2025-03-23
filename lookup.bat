
---

## 📜 **lookup.bat**
This is the batch script for automation.

```batch
@echo off
setlocal enabledelayedexpansion

REM ========================================================
REM Domain Hosting Provider Lookup
REM Reads domains from input.txt, resolves IPs using nslookup/ping,
REM queries ipinfo.io for hosting provider (org field), and saves results to CSV.
REM Output: output.csv with columns Domain, IP, Hosting Provider
REM ========================================================

REM Check for required tools
where curl >nul 2>&1 || (
    echo Error: curl not found. Install curl and try again.
    pause
    exit /b 1
)

if not exist input.txt (
    echo Error: input.txt not found.
    pause
    exit /b 1
)

REM Initialize CSV with headers
echo "Domain","IP","Hosting Provider" > output.csv

echo Processing domains from input.txt...

for /f "usebackq tokens=* delims=" %%D in ("input.txt") do (
    set "domain=%%D"
    if defined domain (
        echo.
        echo Processing: !domain!

        REM Try resolving IP using nslookup
        nslookup !domain! > temp.txt 2>&1
        set "ips="
        for /f "delims=" %%I in ('findstr /r "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" temp.txt') do (
            for /f "tokens=2 delims=:" %%A in ("%%I") do (
                for /f "tokens=*" %%B in ("%%A") do set "ip=%%B"
            )
            if defined ip (
                if defined ips (
                    set "ips=!ips!,!ip!"
                ) else (
                    set "ips=!ip!"
                )
            )
        )

        REM Fallback to ping if nslookup fails
        if not defined ips (
            ping -n 1 !domain! > temp_ping.txt 2>&1
            for /f "tokens=2 delims=[]" %%P in ('findstr /r "\[.*\]" temp_ping.txt') do set "ips=%%P"
        )

        REM Process resolved IPs or mark as "No IP Found"
        if not defined ips (
            echo "!domain!","No IP Found","N/A" >> output.csv
            echo Warning: No IP found for !domain!
        ) else (
            for %%i in (!ips!) do (
                echo Querying IP: %%i...
                curl -s "https://ipinfo.io/%%i/json" > temp_info.txt 2>&1
                set "provider=Not Found"

                REM Parse org field from JSON response
                for /f "delims=" %%L in ('findstr /i "\"org\":" temp_info.txt') do (
                    set "line=%%L"
                    call :ParseOrg
                )

                echo "!domain!","%%i","!provider!" >> output.csv
                timeout /t 1 >nul
            )
        )

        REM Clean up temporary files
        del temp.txt temp_ping.txt temp_info.txt 2>nul
    )
)

echo.
echo Lookup complete. Results saved to output.csv
pause
exit /b

:ParseOrg
REM Extracts org field from JSON line stored in 'line'
set "temp=!line:*"org": =!"
if "!temp:~-1!"=="," set "temp=!temp:~0,-1!"
for /f "tokens=*" %%T in ("!temp!") do set "provider=%%~T"
exit /b
