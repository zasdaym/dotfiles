if status is-interactive
    fish_config theme choose None
    set fish_greeting ""

    set -gx CLOUDSDK_CONFIG "$HOME/.null"
    set -gx EDITOR hx
    set -gx FZF_DEFAULT_OPTS --no-color
    set -gx TF_PLUGIN_CACHE_DIR "$HOME/.terraform.d/plugin-cache"

    if type -q mise
        mise activate fish | source
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
end
