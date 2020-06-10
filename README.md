# Connected Raspberry Pi Light

Based on https://elixirschool.com/en/lessons/advanced/nerves/

You must define the environment variables WIFI_USERNAME and WIFI_PASSWORD
by doing "export WIFI_USERNAME=username" and "export WIFI_PASSWORD=password"

Then you can burn this onto an SD card with it in the computer by doing
"mix firmware" and then "mix firmware.burn"

And then after the initial configuration, you can burn it wirelessly by doing
"mix firmware && ./upload.sh YOUR_LAN_RASPBERRY_PI_IP_ADDRESS" (note, not a variable... just a placeholder)

