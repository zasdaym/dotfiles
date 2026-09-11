if status is-interactive
    fish_config theme choose None
    set fish_color_comment normal
    set fish_greeting ""

    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.local/share/mise/shims"

    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end

    if test -d /home/linuxbrew/.linuxbrew/bin
        fish_add_path /home/linuxbrew/.linuxbrew/bin
    end

    set -gx EDITOR hx
    set -gx FZF_DEFAULT_OPTS '
	--color=fg:#B7B5AC,bg:#FFFCF0,hl:#100F0F
	--color=fg+:#B7B5AC,bg+:#F2F0E5,hl+:#100F0F
	--color=border:#AF3029,header:#100F0F,gutter:#FFFCF0
	--color=spinner:#3AA99F,info:#3AA99F,separator:#F2F0E5
	--color=pointer:#D0A215,marker:#D14D41,prompt:#D0A215'

    if type -q fzf
        # fzf >= 0.48 provides fish integration via --fish.
        fzf --fish | source
    end

    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    abbr --add gcs "git commit -S -m"
    abbr --add ggpush "git push origin (git branch --show-current)"
    abbr --add ggpull "git pull origin (git branch --show-current)"
    abbr --add grt "cd (git rev-parse --show-toplevel || echo '.')"
    abbr --add glog "git log --oneline --decorate --graph $argv"
    abbr --add gmsg "git log -1 --pretty=%B"
    abbr --add curl-http3 "docker run -ti --network host --rm alpine/curl-http3 curl"
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
