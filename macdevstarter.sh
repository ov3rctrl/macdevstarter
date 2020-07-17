#!/bin/bash
#title:         macdevstarter.sh
#description:   Developer Starter Kit for MacOS
#author:        ov3rctrl
#author-url:    ov3rctrl.xyz
#==============================================================================

read -p "Install Homebrew? If your answer is no program will exit. Type 'Y' for Yes. " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Exit."
    exit 1
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh) && brew update"

options[0]="VsCode"
options[1]="NeoVim"
options[2]="Eclipse"
options[3]="NetBeans"
options[4]="Fish"
options[5]="OhMyZsh"
options[6]="Firefox"
options[7]="Chrome"
options[8]="NodeJS & NPM"

function ACTIONS {
    if [[ ${choices[0]} ]]; then
        echo "Time For VSCode"
        brew cask install visual-studio-code
    fi
    if [[ ${choices[1]} ]]; then
        
        echo "Time For NeoVim"
        brew install neovim
    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "Time For Eclipse"
        brew cask install eclipse-jee
    fi
    if [[ ${choices[3]} ]]; then
        echo "Time For NetBeans"
        brew cask install NetBeans
    fi
    if [[ ${choices[4]} ]]; then
        echo "Time For Fish"
        brew install fish
    fi
    if [[ ${choices[5]} ]]; then
        echo "Time For OhMyZsh"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    if [[ ${choices[6]} ]]; then
        echo "Time For Firefox"
        brew cask install firefox
    fi
    if [[ ${choices[7]} ]]; then
        echo "Time For Chrome"
        brew cask install chrome
    fi
    if [[ ${choices[8]} ]]; then
        echo "Time For NodeJS & NPM"
        brew install node && brew install npm
    fi
}


ERROR=" "


clear

function MENU {
    echo "Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}


while MENU && read -e -p "Select what you want. (again to uncheck, ENTER when done): " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
