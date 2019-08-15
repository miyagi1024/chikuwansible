export TERM=xterm-256color
export REPOS="{{repos}}"
export MY_REPOS="{{my_repos}}"
export XDG_CONFIG_HOME="{{config_files}}"
export MY_CONFIG_FILES="{{config_files}}"
export BASH_CONFIG_FILES="{{bash_config_files}}"
export NVIM_CONFIG_FILES="{{nvim_config_files}}"
export PATH=$PATH:/usr/local/bin
export GIT_NAME="{{git_user}}"
export GIT_EMAIL="{{git_email}}"
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export BROWSER="{{browser}}"
export PHOTO="{{photo}}"
export VIDEO="{{video}}"
export AUDIO="{{audio}}"
export RUST_SRC_PATH="{{rust_src_path}}"
export EDITOR="{{editor}}"
export RUSGIT_EDITOR="{{rusgit_editor}}"
export GRAVE_ROOT="{{grave_root}}"
export CARGO_PATH="{{cargo_path}}"
export PATH="$CARGO_PATH/bin:$PATH"
export PATH="{{binaries}}:$PATH"
export CHIKUWANSIBLE_PATH="{{chikuwansible_path}}"
if test -e "{{rusgit_slack_url_file}}" ;then
    export RUSGIT_SLACK_URL="{{rusgit_slack_url}}"
fi
export RUSGIT_SLACK_CHANNEL="{{rusgit_slack_channel}}"
export PYTHON3_PYENV_VERSION="{{python3_pyenv_version}}"
export PYTHON2_PYENV_VERSION="{{python2_pyenv_version}}"
export GIT_TOKEN_FILE="{{git_token_file}}"
export KNOWLEDGES='{{knowledges}}'
export k=$KNOWLEDGES
export JAVA_HOME='{{java_home}}'
export PATH=$PATH:{{program}}/ghidra_{{ghidra_version}}
export PATH=$PATH:{{program}}/idafree-{{ida_version}}
