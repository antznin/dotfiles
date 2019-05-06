# Defined in - @ line 1
function double_screen --description 'alias double_screen xrandr --output HDMI1 --mode 1920x1080  --same-as eDP1'
	xrandr --output HDMI1 --mode 1920x1080  --same-as eDP1 $argv;
end
