#!/bin/bash
source src/tools.sh
source src/display/ascii.sh
source src/display/colors.sh

main(){
    clear
    echo -e "$Blue ๐ฉ $White Starting Gaia... $Blue"
    display_ascii

    echo -e "$Whiteโโโโโโโโโโโฎ Checking for Packages โฎโโโโโโโโโโ"
    for pkg in ${linuxPkg[@]}; do
        isInstalled=`dpkg -s $pkg`
        echo -e "$BBlue[>] Checking for $pkg..."

        if [[ "$isInstalled" == *"install ok installed"* ]]; then
            echo -e "$Cyan[!] Package $pkg is already installed !"
            echo -e " "
        else
            echo -e "$Cyan[+] Installing package $pkg..."
            sudo apt install $pkg
        fi
    done

    echo -e "$Whiteโโโโโโโโโโฎ Checking for Repositories โฎโโโโโโโโโ"
    echo -e "$BBlue[>] Checking for OSINT repositories..."
    for repo in ${!osintGitTools[@]}; do
        echo -e "$Cyan[+] Installing repository $repo...$BCyan"
        git clone ${osintGitTools[$repo]} tools/osint/$repo
        echo -e " "
    done

    echo -e "$BBlue[>] Checking for Enum repositories..."
    for repo in ${!enumGitTools[@]}; do
        echo -e "$Cyan[+] Installing repository $repo...$BCyan"
        git clone ${enumGitTools[$repo]} tools/enum/$repo
        echo -e " "
    done

    echo -e "$BBlue[>] Checking for GainAccess repositories..."
    for repo in ${!accesGitTools[@]}; do
        echo -e "$Cyan[+] Installing repository $repo...$BCyan"
        git clone ${accesGitTools[$repo]} tools/access/$repo
        echo -e " "
    done

    echo -e "$Cyan[+] Installing repository SecLists...$BCyan"
    git clone https://github.com/4m4Sec/SecLists wordlists/
    echo -e " "
}
main
