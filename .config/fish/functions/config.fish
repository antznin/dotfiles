# Defined in - @ line 1
function config --description 'alias config=/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv;
end
