# The .specific-software.d folder

This folder contains individual script files for specific software installations.

The `.sh` files in this folder will be executed during `debian-post-install`.

The naming of files inside this folder forces the order in which they're executed.

Prefixes are used to group scripts:
* `0xx-`: Shell utilities
* `1xx-`: Shell extensions
* `2xx-`: (reserved)
* `3xx-`: System extensions
* `4xx-`: (reserved)
* `5xx-`: Development software
* `6xx-`: (reserved)
* `7xx-`: Productivity software
* `8xx-`: (reserved)
* `9xx-`: (reserved)
