# External screen as primary

> https://itectec.com/ubuntu/ubuntu-login-screen-appears-on-second-monitor/

gdm monitor settings for user is saved under `~/.config/monitors.xml`
So just clear it (make a backup), and then use system settings to change to your like, save the changes and reload gnome-shell see if it works

```bash
sudo cp ~/.config/monitors.xml ~gdm/.config/monitors.xml
sudo chown gdm:gdm ~gdm/.config/monitors.xml
```

then apply the same settings to the login screen by:

In `/etc/gdm3/custom.conf` changing from `#WaylandEnable = false` to `WaylandEnable = false` to solved the issue.
