# Defined in - @ line 1
function pacman_remove_unused --description 'alias pacman_remove_unused=sudo pacman -R (pacman -Qdtq)'
	sudo pacman -R (pacman -Qdtq) $argv;
end
