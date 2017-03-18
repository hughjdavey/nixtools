function fish_prompt --description 'Write out the prompt'
	set exit_code $status

	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	set -l suffix
	
	switch (whoami)
	case root toor
		set suffix '#'
	case '*'
		set suffix '>'
	end

	
	set -l success
	
	switch $exit_code
	case 0
		set success green
	case '*'
		set success red
	end

	
	set -l prompt_git
	set git_branch " ("(git rev-parse --abbrev-ref HEAD ^ /dev/null)") "
	
	switch $status
	case 0
		set prompt_git $git_branch
	case '*'
		set prompt_git ''
	end	

	echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $success) (prompt_pwd) (set_color --bold $success) "$git_branch"  (set_color normal) "$suffix "
end
