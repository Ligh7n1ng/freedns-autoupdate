# freedns-autoupdate
Autoupdate script for freedns.afraid.org

## Requirements

You need **bash**, **grep** and **curl** to use this script. 

## Usage:

1. Download the script file (*`freedns-autoupdate.sh`*) or use `git clone`.
2. Run `chmod +x <path-to-script>/freedns-autoupdate.sh` to make the script executable.
3. Run the script `./freedns-autoupdate.sh <Direct update URL> [<Path to log file with current IP address>]`
  #### Example
  ```
  ./freedns-autoupdate.sh https://freedns.afraid.org/dynamic/update.php?CGe6JyFuTwyOAVuSxMKTPSchIukA6mVnArVOwBH2G9X9 /home/user/ip.log
  ```
4. Use **cron** or **systemd.timer** to periodically run the script to automatic update DDNS.
