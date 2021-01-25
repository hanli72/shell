sudo cvt 1800 980
sudo xrandr --newmode "1800x980_60.00"  145.75  1800 1912 2096 2392  980 983 993 1017 -hsync +vsync
xrandr
sudo xrandr --addmode VGA-1 1800x980_60.00
xrandr --output VGA-1 --mode 1800x980_60.00
