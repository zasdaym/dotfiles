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
	--color=fg:#797593,bg:#FAF4ED,hl:#D7827E
	--color=fg+:#575279,bg+:#F2E9E1,hl+:#D7827E
	--color=border:#DFDAD9,header:#286983,gutter:#FAF4ED
	--color=spinner:#EA9D34,info:#56949F
	--color=pointer:#907AA9,marker:#B4637A,prompt:#797593'

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
