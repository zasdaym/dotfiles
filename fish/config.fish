fish_add_path $HOME/.krew/bin $HOME/go/bin /opt/homebrew/opt/openssl@1.1/bin /opt/homebrew/bin /opt/homebrew/sbin

function glog
    git log --oneline --decorate --graph $argv
end

function ggpush
    git push origin (git branch --show-current) $argv
end

function ggpull
    git pull origin (git branch --show-current) $argv
end

function grt
    cd (git rev-parse --show-toplevel || echo ".")
end

function gcs
    git commit -S $argv
end

function aws_ssm_start_session
    set instance_id (
        aws ec2 describe-instances \
        --filters Name=instance-state-name,Values=running \
        --query 'Reservations[*].Instances[*].{id:InstanceId,name:Tags[?Key==`Name`]|[0].Value,ip:PrivateIpAddress}' \
        --output text | fzf | cut -f 1
    )
    aws ssm start-session --target $instance_id
end

if test -e "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
    function tailscale
        /Applications/Tailscale.app/Contents/MacOS/Tailscale $argv
    end
end

if test -n "$KITTY_PID"
    function ssh
        kitty +kitten ssh $argv
    end
end

if status is-interactive
    set fish_greeting ""
    set -gx CLOUDSDK_CONFIG "$HOME/.null"
    set -gx EDITOR nvim
    set -gx FZF_DEFAULT_OPTS --no-color
    set -gx TF_PLUGIN_CACHE_DIR "$HOME/.terraform.d/plugin-cache"

    fish_config theme choose None

    starship init fish | source
    fnm env --use-on-cd | source
    zoxide init fish | source
end
