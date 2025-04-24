fish_add_path $HOME/.bun/bin $HOME/.cargo/bin $HOME/.dotnet/tools $HOME/.krew/bin $HOME/.local/bin $HOME/go/bin /opt/homebrew/opt/curl/bin /opt/homebrew/opt/ruby/bin /opt/homebrew/postgresql@16/bin /opt/homebrew/opt/openssl@1.1/bin /opt/homebrew/bin /opt/homebrew/sbin

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

function curl_time
    curl -o /dev/null -s -w '%{time_total} s\n' $argv
end

function curl_time_detail
    curl -o /dev/null -s -w 'TCP connect: %{time_connect} s\nDNS lookup: %{time_namelookup} s\nTotal: %{time_total} s\n' $argv
end

if test -e "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
    function tailscale
        /Applications/Tailscale.app/Contents/MacOS/Tailscale $argv
    end
end

fish_add_path /opt/homebrew/lib/ruby/gems/$(ruby --version | awk '{print $2}')/bin

if status is-interactive
    set fish_greeting ""
    set -gx CLOUDSDK_CONFIG "$HOME/.null"
    set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
    set -gx DOTNET_ROOT /usr/local/share/dotnet
    set -gx EDITOR nvim
    set -gx FZF_DEFAULT_OPTS --no-color
    set -gx TF_PLUGIN_CACHE_DIR "$HOME/.terraform.d/plugin-cache"

    fish_config theme choose None

    starship init fish | source
    fnm env --use-on-cd | source
    zoxide init fish | source
    atuin init fish | source

    if type -q docker
        docker completion fish | source
    end
end

# dayfox
set -g fish_color_autosuggestion 837a72
