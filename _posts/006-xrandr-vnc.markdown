---
categories: Linux
date: 2013/03/14 18:09:02
title: "Resize a VNC session with xrandr"
---

For some years I have been using [NoMachine NX](http://www.nomachine.com/products.php) for remote access to Linux servers. It has a cross-platform client, allows continuous sessions (seperate to the console login), works well over slow connections and allows resizing of the remote display.

The resizing is a particularly handy feature when reconnecting to the same session from different devices - changing between a large monitor and a small laptop screen for example.

I am now using VNC much more for work, and I found I really missed the ability to resize. Looking into it I found the following procedure:

- Establish the target resolution. I check the resolution of the device I am using and subtract about 50 pixels from the height for the menu bar (on a Mac) and maybe 10 pixels width so that the VNC window fits without scrollbars and without having to use fullscreen mode. So with a `1920x1200` monitor I find `1910x1150` comfortable for a VNC session.

- Get the modeline for that resolution using the `cvt` command.
$$code(lang=bash)
[robini@robini2-pc ~]$ cvt 1910 1150
# 1912x1150 59.90 Hz (CVT) hsync: 71.46 kHz; pclk: 183.50 MHz
Modeline "1912x1150_60.00"  183.50  1912 2040 2240 2568  1150 1153 1163 1193 -hsync +vsync
$$/code

- Create the mode using `xrand`. For the `--newmode` call just copy and paste the numbers from the output of `cvt`. To have this step persist you can add the two `xrandr` commands to the top of the `~/.vnc/xstartup` script.
$$code(lang=bash)
[robini@robini2-pc ~]$ xrandr --newmode "1912x1150" 183.50  1912 2040 2240 2568  1150 1153 1163 1193 -hsync +vsync
[robini@robini2-pc ~]$ xrandr --addmode default "1912x1150"
$$/code

- Switch to the mode using `xrandr`.
$$code(lang=bash)
[robini@robini2-pc ~]$ xrandr -s 1912x1150
$$/code

That's it. I guess you could set up some alias for laptop vs desktop so you don't have to remember the particular resolutions, but I usually just search the bash history with `C-R` to quickly find the last switch.
