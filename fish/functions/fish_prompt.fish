function fish_prompt
	set -l nix_shell_info (
  		if test -n "$IN_NIX_SHELL"
    			echo -n "<nix-shell> "
			printf '%s%s%s> '\
        		(set_color $fish_color_cwd) (prompt_pwd) (set_color normal)

		else
			printf '%s%s%s> '\
        		(set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  		end
		)
	echo -n -s "$nix_shell_info"
end
