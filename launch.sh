#!/bin/bash
# Launch created by @Maqzafzar

tgcli_version="170904-nightly"
luarocks_version=2.4.2

lualibs=(
'redis-lua'
'serpent'
)

#!/bin/bash
# Launch created by @Maqzafzar

tgcli_version="170904-nightly"
luarocks_version=2.4.2

lualibs=(
'redis-lua'
'serpent'
)

today=`date +%F`

get_sub() {
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c; do
        if $flag; then
            printf '%c' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]; then
                count=0
            else
                ((count++))
                if ((count > 1)); then
                    flag=true
                fi
            fi
        fi
    done
}
function install_config() {
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y
add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
apt-get upgrade
sudo apt-get install libconfig++9v5 libstdc++6
sudo apt autoremove
chmod +x launch.sh
chmod 777 launch.sh
chmod +x ExtraTab.lua
}
make_progress() {
exe=`lua <<-EOF
    print(tonumber($1)/tonumber($2)*100)
EOF
`
    echo ${exe:0:4}
}

function get_tgcli_version() {
	echo "$tgcli_version"
}

function download_libs_lua() {
    if [[ ! -d "logs" ]]; then mkdir logs; fi
    if [[ -f "logs/logluarocks_${today}.txt" ]]; then rm logs/logluarocks_${today}.txt; fi
    local i
    for ((i=0;i<${#lualibs[@]};i++)); do
        printf "\r\33[2K"
        printf "\rReza Khosrobegi: wait... [`make_progress $(($i+1)) ${#lualibs[@]}`%%] [$(($i+1))/${#lualibs[@]}] ${lualibs[$i]}"
        ./.luarocks/bin/luarocks install ${lualibs[$i]} &>> logs/logluarocks_${today}.txt
    done
    sleep 0.2
    printf "\nLogfile created: $PWD/logs/logluarocks_${today}.txt\nDone\n"
    rm -rf luarocks-2.2.2*
}

function configure() {
    dir=$PWD
    wget http://luarocks.org/releases/luarocks-${luarocks_version}.tar.gz &>/dev/null
    tar zxpf luarocks-${luarocks_version}.tar.gz &>/dev/null
    cd luarocks-${luarocks_version}
    if [[ ${1} == "--no-null" ]]; then
        ./configure --prefix=$dir/.luarocks --sysconfdir=$dir/.luarocks/luarocks --force-config
        make bootstrap
    else
        ./configure --prefix=$dir/.luarocks --sysconfdir=$dir/.luarocks/luarocks --force-config &>/dev/null
        make bootstrap &>/dev/null
    fi
    cd ..; rm -rf luarocks*
    if [[ ${1} != "--no-download" ]]; then
        download_libs_lua
        wget --progress=bar:force https://valtman.name/files/telegram-bot-${tgcli_version}-linux 2>&1 | get_sub
        mv telegram-bot-${tgcli_version}-linux telegram-bot; chmod +x telegram-bot
    fi
    for ((i=0;i<101;i++)); do
        printf "\rConfiguring... [%i%%]" $i
        sleep 0.007
    done
    mkdir $HOME/.telegram-bot; cat <<EOF > $HOME/.telegram-bot/config
default_profile = "main";
main = {
  lua_script = "$HOME/ExtraTab[TD-bot]/ExtraTab.lua";
};
EOF
    printf "\nDone\n"
}

function start_bot() {
    ./telegram-bot | grep -v "{"
}

function login_bot() {
    ./telegram-bot -p main --login --phone=${1}
}



function show_logo_slowly() {
    seconds=0.009
    logo=(
    "ExtraTab TM Project ..."
    "Plus Bot ..."
    "Based On TD-BOT ..."
    "We Are Powerful"
    "by @MaQzAfzar Or @Edward_Jason"
	"Our Team Channel : @ExtraTab"
    )
    printf "\033[38;5;208m\t"
    local i x
    for i in ${!logo[@]}; do
        for ((x=0;x<${#logo[$i]};x++)); do
            printf "${logo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
}

function show_logo() {
    #Adding some color. By @Edward_Jason :D
    echo -e "\033[38;5;208m"
    echo -e "\t I'm Not The Best ..."
    echo -e "\t But I Try More ..."
    echo -e "\t To Be Better ..."
    echo -e "\t I'm Reza Khosrobegi ..."
    echo -e "\n\e[36m"
}

case $1 in
    install)
	    install_config
    	show_logo_slowly
    	configure ${2}
    exit ;;
    login)
        echo "Your Bot Phone Number : "
        read phone_number
        login_bot ${phone_number}
    exit ;;
	tgcli_version)
		get_tgcli_version
	exit ;;
	help)
		echo "  Commands :                                                           "
		echo "	install - First command to install all repos and download binary .   "
		echo "	login - Access into your telegram account .                          "
		echo "	auto - For Runnig Soure Automaticly .                                "
		echo "	help - Shows this message .                                          "
	exit ;;
	auto)
	   show_logo
       start_bot $@
	exit ;;
esac
RED='\033[0;31m'
NC='\033[0m'
CYAN='\033[0;36m'
echo -e "${CYAN}Please Send [ ./launch.sh help ]${NC}"
exit 0
