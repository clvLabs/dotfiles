if [ -n "$VM_SETUP" ]; then

    log_highlight -
    log_highlight - [${APP_NAME}] SKIPPING nvidia-driver (VM_SETUP mode)
    log_highlight -

else

    log_highlight -
    log_highlight - [${APP_NAME}] Installing nvidia-driver
    log_highlight -

    RUNCMD "sudo apt-get -y install nvidia-driver"

fi