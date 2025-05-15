. "$HOME/.cargo/env"

bt() {
    if [[ -z "$1" ]]; then
        CMD=$(history 10 | fzf --header="Choose a command to save" --no-sort --tac | cut -d' ' -f 4-)
    else
        CMD=$1
    fi

    [[ -z "$CMD" ]] && echo "Aborted" && return 2
    echo "Saving \"${CMD}\"..."
    read  "NAME?Name of command: "
    [[ -z "$NAME" ]] && echo "No name given, aborting" && return 1
    #LONG=$(read "Longer description (optional): ")
    read "LONG?Longer description (optional): "
    if [[ ! -d "${HOME}/.config/btdt" ]]; then
        mkdir -p "${HOME}/.config/btdt"
    fi

    DATA="${BTDT_DATA:-${HOME}/.config/btdt/data}"

    if [[ ! -f $DATA ]]; then
        touch $DATA
    fi
    
    result="${CMD}\t${NAME}\t${LONG}\n"
    echo "$result"
    printf "$result" >> $DATA
}

dt() {
    local data="${BTDT_DATA:-${HOME}/.config/btdt/data}"
    local cmd=$(cat $data | fzf -d'\t' --with-nth 2 --preview='echo -e "\033[1m"{1}"\033[0m""\n\n"{3}' | cut -f1)
    echo "${cmd}"
    eval "${cmd}"
}
