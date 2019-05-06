# Defined in - @ line 1
function extend_screen --description 'alias extend_screen=xrandr --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x520 --rotate normal --output VGA1 --off'
	xrandr --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x520 --rotate normal --output VGA1 --off $argv;
end
