#!/bin/bash
#
############################
##### Basic Info Start #####
############################
#
# Script Author: randomessence
#
# Script Contributors: 
#
# License: This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-sa/4.0/
#
# Bash Command for easy reference:
#
# wget -qO ~/install.proftpd http://git.io/nQJBxw && bash ~/install.proftpd
#
############################
###### Basic Info End ######
############################
#
############################
#### Script Notes Start ####
############################
#
# Don't forget to change the conf file variable size if the configurations are modified.
#
############################
##### Script Notes End #####
############################
#
############################
## Version History Starts ##
############################
#
if [[ ! -z $1 && $1 == 'changelog' ]]; then echo
    #
    # put your version changes in the single quotes and then uncomment the line.
    #
    #echo 'v0.1.0 - My changes go here'
    #echo 'v0.0.9 - My changes go here'
    #echo 'v0.0.8 - My changes go here'
    #echo 'v0.0.7 - My changes go here'
    #echo 'v0.0.6 - My changes go here'
    #echo 'v0.0.5 - My changes go here'
    #echo 'v0.0.4 - My changes go here'
    #echo 'v0.0.3 - My changes go here'
    #echo 'v0.0.2 - My changes go here'
    echo 'v1.2.4 - Template updated'
    #
    echo
    exit
fi
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
# Script Version number is set here.
scriptversion="1.2.4"
#
# Script name goes here. Please prefix with install.
scriptname="install.proftpd"
#
# Author name goes here.
scriptauthor="randomessence"
#
# Contributor's names go here.
contributors="None credited"
#
# Set the http://git.io/ shortened URL for the raw github URL here:
gitiourl="http://git.io/nQJBxw"
#
# Don't edit: This is the bash command shown when using the info option.
gitiocommand="wget -qO ~/$scriptname $gitiourl && bash ~/$scriptname"
#
# This is the raw github url of the script to use with the built in updater.
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/scripts/install.proftpd.sh"
#
# This will generate a 20 character random passsword for use with your applications.
apppass=$(< /dev/urandom tr -dc '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' | head -c20; echo;)
# This will generate a random port for the script between the range 10001 to 49999 to use with applications. You can ignore this unless needed.
appport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$appport"'' | grep -c 'LISTEN')" -eq "1" ]]; do appport=$(shuf -i 10001-49999 -n 1); done
#
# Script user's http www URL in the format http://username.server.feralhosting.com/
host1http="http://$(whoami).$(hostname -f)/"
# Script user's https www URL in the format https://username.server.feralhosting.com/
host1https="https://$(whoami).$(hostname -f)/"
# Script user's http www url in the format https://server.feralhosting.com/username/
host2http="http://$(hostname -f)/$(whoami)/"
# Script user's https www url in the format https://server.feralhosting.com/username/
host2https="https://$(hostname -f)/$(whoami)/"
#
# feralwww - sets the full path to the default public_html directory if it exists.
[[ -d ~/www/$(whoami).$(hostname -f)/public_html ]] && feralwww="$HOME/www/$(whoami).$(hostname -f)/public_html/"
# rtorrentdata - sets the full path to the rtorrent data directory if it exists.
[[ -d ~/private/rtorrent/data ]] && rtorrentdata="$HOME/private/rtorrent/data"
# deluge - sets the full path to the deluge data directory if it exists.
[[ -d ~/private/deluge/data ]] && delugedata="$HOME/private/deluge/data"
# transmission - sets the full path to the transmission data directory if it exists.
[[ -d ~/private/transmission/data ]] && transmissiondata="$HOME/private/transmission/data"
#
############################
## Custom Variables Start ##
############################
#
proftpdversion="proftpd-1.3.5"
installedproftpdversion=$(cat $HOME/proftpd/.proftpdversion 2> /dev/null)
#
proftpdconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/proftpd.conf"
proftpdconfsize="3773"
sftpconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/sftp.conf"
sftpconfsize="832"
ftpsconf="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/conf/ftps.conf"
ftpsconfsize="953"
scripturl="https://raw.githubusercontent.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/proftpd%20-%20Installing%20an%20FTP%20daemon%20for%20extra%20accounts/scripts/install.proftpd.sh"
#
proftpdurl="ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz"
#
sftpport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$sftpport"'' | grep -c 'LISTEN')" -eq "1" ]]; do sftpport=$(shuf -i 10001-49999 -n 1); done
#
ftpsport=$(shuf -i 10001-49999 -n 1)
#
# This wil take the previously generated port and test it to make sure it is not in use, generating it again until it has selected an open port.
while [[ "$(netstat -ln | grep ':'"$ftpsport"'' | grep -c 'LISTEN')" -eq "1" ]]; do ftpsport=$(shuf -i 10001-49999 -n 1); done
#
############################
### Custom Variables End ###
############################
#
# Disables the built in script updater permanently by setting this variable to 0.
updaterenabled="1"
#
############################
####### Variable End #######
############################
#
############################
#### Script Info Starts ####
############################
#
# Use this to show a user script information when they use the info option with the script.
if [[ ! -z $1 && $1 == 'info' ]]
then
    echo
    echo -e "\033[32m""Script Details:""\e[0m"
    echo
    echo "Script version: $scriptversion"
    echo
    echo "Script Author: $scriptauthor"
    echo
    echo "Script Contributors: $contributors"
    echo
    echo -e "\033[32m""Script Information and usage instructions:""\e[0m"
    echo
    #
    ###################################
    #### Custom Script Notes Start ####
    ###################################
    #
    echo -e "Put your instructions or script information here using echoes"
    #
    ###################################
    ##### Custom Script Notes End #####
    ###################################
    #
    echo
    echo -e "\033[32m""Script options:""\e[0m"
    echo
    echo -e "\033[36mchangelog\e[0m = See the version history and change log of this script."
    echo
    echo -e "Example usage: \033[36m$scriptname changelog\e[0m"
    echo
    echo -e "\033[36minfo\e[0m = Show the script information and usage instructions."
    echo
    echo -e "Example usage: \033[36m$scriptname info\e[0m"
    echo
    echo -e "\033[31mImportant note:\e[0m Options \033[36mqr\e[0m and \033[36mnu\e[0m are interchangeable and usable together."
    echo
    echo -e "For example: \033[36m$scriptname qr nu\e[0m or \033[36m$scriptname nu qr\e[0m will both work"
    echo
    echo -e "\033[36mqr\e[0m = Quick Run - use this to bypass the default update prompts and run the main script directly."
    echo
    echo -e "Example usage: \033[36m$scriptname qr\e[0m"
    echo
    echo -e "\033[36mnu\e[0m = No Update - disable the built in updater. Useful for testing new features or debugging."
    echo
    echo -e "Example usage: \033[36m$scriptname nu\e[0m"
    echo
    echo -e "\033[32mBash Commands:\e[0m"
    echo
    echo -e "$gitiocommand"
    echo
    echo -e "~/bin/$scriptname"
    echo
    echo -e "$scriptname"
    #
    echo
    exit
fi
#
############################
##### Script Info Ends #####
############################
#
############################
#### Self Updater Start ####
############################
#
# Quick Run option part 1: If qr is used it will create this file. Then if the script also updates, whihc woudl reset the option, it will then find this file and set it back.
if [[ ! -z $1 && $1 == 'qr' ]] || [[ ! -z $2 && $2 == 'qr' ]];then echo -n '' > ~/.quickrun; fi
#
# No Update option: This disables the updater features if the script option "nu" was used when running the script.
if [[ ! -z $1 && $1 == 'nu' ]] || [[ ! -z $2 && $2 == 'nu' ]]
then
    echo
    echo "The Updater has been temporarily disabled"
    echo
    scriptversion="$scriptversion-nu"
else
    #
    # Check to see if the variable "updaterenabled" is set to 1. If it is set to 0 the script will bypass the built in updater regardless of the options used.
    if [[ "$updaterenabled" -eq 1 ]]
    then
        [[ ! -d ~/bin ]] && mkdir -p ~/bin
        [[ ! -f ~/bin/"$scriptname" ]] && wget -qO ~/bin/"$scriptname" "$scripturl"
        #
        wget -qO ~/.000"$scriptname" "$scripturl"
        #
        if [[ $(sha256sum ~/.000"$scriptname" | awk '{print $1}') != $(sha256sum ~/bin/"$scriptname" | awk '{print $1}') ]]
        then
            echo -e "#!/bin/bash\nwget -qO ~/bin/$scriptname $scripturl\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.111"$scriptname"
            bash ~/.111"$scriptname"
            exit
        else
            if [[ -z $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') && $(ps x | fgrep "bash $HOME/bin/$scriptname" | grep -v grep | head -n 1 | awk '{print $1}') -ne "$$" ]]
            then
                echo -e "#!/bin/bash\ncd && rm -f $scriptname{.sh,}\nbash ~/bin/$scriptname\nexit" > ~/.222"$scriptname"
                bash ~/.222"$scriptname"
                exit
            fi
        fi
        cd && rm -f .{000,111,222}"$scriptname"
        chmod -f 700 ~/bin/"$scriptname"
        echo
    else
        echo
        echo "The Updater has been disabled"
        echo
        scriptversion="$scriptversion-DEV"
    fi
fi
#
# Quick Run option part 2: If quick run was set and the updater section completes this will enable quick run again then remove the file.
if [[ -f ~/.quickrun ]];then updatestatus="y"; rm -f ~/.quickrun; fi
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
if [[ "$updatestatus" == "y" ]]
then
    :
else
    echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
    echo
    read -ep "The script has been updated, enter [y] to continue or [q] to exit: " -i "y" updatestatus
    echo
fi
#
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
    if [[ -d "$HOME/proftpd" ]]
    then
        if [[ -f "$HOME"/proftpd/.proftpdversion ]]
        then
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version $installedproftpdversion of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        else
            echo -e "\033[32m""proftpd update. No settings, jails or users will be lost by updating.""\e[0m"
            echo
            read -ep "Would you like to update your version of proftpd with this one $proftpdversion? [y]es or [e]xit or full [r]einstall: " agree2update
            echo
        fi
        if [[ "$agree2update" =~ ^[Yy]$ ]]
        then
            killall -9 proftpd -u $(whoami) >/dev/null 2>&1
            mkdir -p "$HOME"/proftpd/install_logs
            cd && rm -rf "$proftpdversion"
            wget -qO ~/proftpd-1.3.5.tar.gz "$proftpdurl"
            tar xf ~/proftpd-1.3.5.tar.gz
            #
            [[ -z "$(grep -o '^ProcessTitles terse$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a ProcessTitles terse' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^IdentLookups off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a IdentLookups off' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^UseReverseDNS off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a UseReverseDNS off' "$HOME"/proftpd/etc/proftpd.conf || :
            [[ -z "$(grep -o '^AllowOverride off$' $HOME/proftpd/etc/proftpd.conf)" ]] && sed -i '/###### Options/a AllowOverride off' "$HOME"/proftpd/etc/proftpd.conf || :
            #
            echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
            cd "$HOME/$proftpdversion"
            echo "Starting to 1: configure, 2: make, 3 make install"
            echo
            install_user=$(whoami) install_group=$(whoami) ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
            echo "1: configure complete, moving to 2 of 3"
            make > "$HOME"/proftpd/install_logs/make.log 2>&1
            echo "2: make complete, moving to 3 of 3"
            make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
            echo "3: make install complete, moving to post installation configuration"
            echo
            "$HOME"/proftpd/bin/ftpasswd --group --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.group --gid $(id -g $(whoami)) --member $(whoami) >/dev/null 2>&1
            # Some tidy up
            cd && rm -rf "$proftpdversion"
            chmod 440 ~/proftpd/etc/ftpd{.passwd,.group}
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/sftp.conf >/dev/null 2>&1
            "$HOME"/proftpd/sbin/proftpd -c "$HOME"/proftpd/etc/ftps.conf >/dev/null 2>&1
            echo -e "proftpd sftp and ftps servers were started."
            echo
            exit
        elif [[ "$agree2update" =~ ^[Rr]$ ]]
        then
            read -ep "Are you sure you want to do a full reinstall, all settings, jails and users will be lost? [y]es i am sure or [e]xit: " areyousure
            echo
            if [[ "$areyousure" =~ ^[Yy]$ ]]
            then
                killall -9 proftpd -u $(whoami) >/dev/null 2>&1
                rm -rf "$HOME"/proftpd >/dev/null 2>&1
            else
                echo "You chose to exit"
                echo
                exit
            fi
        else
            echo "You chose to exit"
            echo
            exit
        fi
    fi
    #
    mkdir -p "$HOME"/proftpd/etc/sftp/authorized_keys
    mkdir -p "$HOME"/proftpd/etc/keys
    mkdir -p "$HOME"/proftpd/{ssl,install_logs}
    wget -qO ~/proftpd-1.3.5.tar.gz "$proftpdurl"
    tar xf ~/proftpd-1.3.5.tar.gz
    #git clone -q "$proftpdurl"
    #chmod -R 700 "$HOME/$proftpdversion"
    echo -n "$proftpdversion" > "$HOME"/proftpd/.proftpdversion
    cd "$HOME/$proftpdversion"
    echo -e "\033[32m""About to configure, make and install proftpd. This could take some time to complete. Be patient.""\e[0m"
    echo
    # configure and install
    echo "Starting to 1: configure, 2: make, 3 make install"
    echo
    install_user=$(whoami) install_group=$(whoami) ./configure --prefix="$HOME"/proftpd --enable-openssl --enable-dso --enable-nls --enable-ctrls --with-shared=mod_ratio:mod_readme:mod_sftp:mod_tls:mod_ban > "$HOME"/proftpd/install_logs/configure.log 2>&1
    echo "1: configure complete, moving to 2 of 3"
    make > "$HOME"/proftpd/install_logs/make.log 2>&1
    echo "2: make complete, moving to 3 of 3"
    make install > "$HOME"/proftpd/install_logs/make_install.log 2>&1
    echo "3: make install complete, moving to post installation configuration"
    echo
    # Some tidy up
    cd && rm -rf "$proftpdversion"
    # Generate our keyfiles
    ssh-keygen -q -t rsa -f "$HOME"/proftpd/etc/keys/sftp_rsa -N '' && ssh-keygen -q -t dsa -f "$HOME"/proftpd/etc/keys/sftp_dsa -N ''
    echo "rsa keys generated with no passphrase"
    openssl req -new -x509 -nodes -days 365 -subj '/C=GB/ST=none/L=none/CN=none' -newkey rsa:2048 -keyout "$HOME"/proftpd/ssl/proftpd.key.pem -out "$HOME"/proftpd/ssl/proftpd.cert.pem >/dev/null 2>&1
    echo "ssl keys generated"
    echo
    # Get the conf files from github and configure them for this user
    echo "Downloading and configuring the .conf files."
    echo
    until [[ $(stat -c %s ~/proftpd/etc/proftpd.conf 2> /dev/null) -eq "$proftpdconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/proftpd.conf "$proftpdconf"
    done
    until [[ $(stat -c %s ~/proftpd/etc/sftp.conf 2> /dev/null) -eq "$sftpconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/sftp.conf "$sftpconf"
    done
    until [[ $(stat -c %s ~/proftpd/etc/ftps.conf 2> /dev/null) -eq "$ftpsconfsize" ]]
    do
        wget -qO "$HOME"/proftpd/etc/ftps.conf "$ftpsconf"
    done
    # proftpd.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|User my_username|User '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|Group my_username|Group '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    sed -i 's|AllowUser my_username|AllowUser '$(whoami)'|g' "$HOME/proftpd/etc/proftpd.conf"
    # sftp.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/sftp.conf"
    sed -i 's|Port 23001|Port '"$sftpport"'|g' "$HOME/proftpd/etc/sftp.conf"
    echo -e "This is your" "\033[31m""SFTP""\e[0m" "port:" "\033[31m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/sftp.conf)""\e[0m"
    # ftps.conf
    sed -i 's|/media/DiskID/home/my_username|'"$HOME"'|g' "$HOME/proftpd/etc/ftps.conf"
    sed -i 's|Port 23002|Port '"$ftpsport"'|g' "$HOME/proftpd/etc/ftps.conf"
    echo
    echo -e "This is your" "\033[32m""FTPS""\e[0m" "port:" "\033[32m""$(sed -nr 's/^Port (.*)/\1/p' ~/proftpd/etc/ftps.conf)""\e[0m"
    echo
    echo -e "The basic setup and configuration has been completed." "\033[31m""Please now enter a password for your main, unlimited user""\e[0m"
    echo
    "$HOME"/proftpd/bin/ftpasswd --passwd --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.passwd --uid $(id -u $(whoami)) --gid $(id -g $(whoami)) --home "$HOME"/ --shell /bin/false
    "$HOME"/proftpd/bin/ftpasswd --group --name $(whoami) --file "$HOME"/proftpd/etc/ftpd.group --gid $(id -g $(whoami)) --member $(whoami) >/dev/null 2>&1
    echo
    echo -e "\033[31m""If for some reason the user creation failed, see Step 6 of the FAQ to do this again""\e[0m"
    echo
    echo -e "You have completed Steps 1 through 6. Please continue with the FAQ from Step 7 onwards."
    echo
    echo -e "proftpd was NOT started to allow you to edit the jails in Step 8 of the FAQ as required."
    echo
    echo -e "See Step 9 of the FAQ for how to start proftpd"
    echo
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit
fi
#
############################
##### Core Script Ends #####
############################
#