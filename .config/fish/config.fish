if status is-interactive
    fish_config theme choose None
    set fish_greeting ""

    if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end

    set -gx CLOUDSDK_CONFIG "$HOME/.null"
    set -gx GIT_EXTERNAL_DIFF difft
    set -gx EDITOR hx
    set -gx FZF_DEFAULT_OPTS --no-color
    set -gx K9S_CONFIG_DIR "$HOME/.config/k9s"
    set -gx TF_PLUGIN_CACHE_DIR "$HOME/.terraform.d/plugin-cache"

    if type -q mise
        mise activate fish | source
        mise completion fish | source
    end

    if type -q fzf
        # fzf >= 0.48 provides fish integration via --fish.
        fzf --fish | source
    end

    if type -q docker
        docker completion fish | source
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
end
