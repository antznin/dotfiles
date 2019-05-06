# Defined in - @ line 1
function main_screen --description 'alias main_screen=xrandr --output eDP1 --primary --mode 1920x1080 --output HDMI1 --off'
	xrandr --output eDP1 --primary --mode 1920x1080 --output HDMI1 --off $argv;
end
