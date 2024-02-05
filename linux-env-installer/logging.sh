#!/usr/bin/env bash

declare -a PACKAGES=()
CONFIG_FILE="packages.conf"

while IFS= read -r line; do
    # Ignora líneas en blanco y comentarios
    if [[ "$line" =~ ^[[:space:]]*# || -z "$(echo "$line" | tr -d '[:space:]')" ]]; then
        continue
    fi

    # Agrega el paquete al array
    PACKAGES+=("$line")
done < "$CONFIG_FILE"

# Itera sobre el array e imprime los paquetes
for package in "${PACKAGES[@]}"; do
    echo "Package: $package"
done

# REPO_URL="https://github.com/JorgeMartinG/debian-tools/raw/main/linux-env-installer/"
GRE_FG="\e[0;32m\033[1m" # Green color text format.
RED_FG="\e[0;31m\033[1m" # Red color text format.
YEL_FG="\e[0;33m\033[1m" # Yellow color text format.
END_FG="\033[0m\e[0m"    # End color text format.


# https://github.com/JorgeMartinG/debian-tools/raw/main/linux-env-installer/packages.conf

# function get_config(){
#     local config_file="packages.conf"
#     local installer_path
#     installer_path=$(dirname "$0")
#     local config_path="$installer_path/$config_file"

#     if [ -f "$installer_path/$config_file" ]; then
#         source "$config_path"
#     else
#         echo -e "${RED_FG}Package file missing!${END_FG}"
#         read -p "Do you want to download the package file? (y/n) " package_file_download

#         if [[ "$package_file_download" =~ ^[Yy]$ ]]; then
#             echo -ne "Downloading configuration file... " 
#             wget -q "$REPO_URL/$config_file" -P "$installer_path" &> /dev/null

#             if [ $? -eq 0 ]; then
#             echo -e "${GRE_FG}DONE${END_FG}"
#             else
#                 echo -e "${RED_FG}FAILED${END_FG}" ; exit 1
#             fi
#         else
#             echo -e "${YEL_FG}Cannot proceed without the package file. Exiting...${END_FG}" ; exit 1
#         fi
#     fi
# }



# declare -a PACKAGE_ESSENTIAL=("build-essential")
# PACKAGES_FILE="$(dirname "$0")/packages.conf"

# function status_code(){

#     local code=$1

#     if [ -n "$code" ] && [ "$code" -gt 0 ]; then

#         echo -e " [${RED_FG}ERROR${END_FG}]"

#     elif [ -n "$code" ] && [ "$code" -eq 0 ]; then

#         echo -e " [${GRE_FG}OK${END_FG}]"

#     fi
# }

# function log_events(){

#     local event
#     local status

#     status=$(status_code "$2")
#     event="[${YEL_FG}$(date '+%Y-%m-%d %H:%M:%S')${END_FG}] $1"

#     if [ -n "$2" ]; then 
#         event+=$status
#     fi   

#     echo -e "$event" | tee -a "$LOG_FILE"
# }

# function install_package(){

#     local package="$1"

#     log_events "Installing $package."

#     if ! apt-get -qy install "$package" &>> "$LOG_FILE"; then

#         log_events "Error installing $package." 1
#         return 1

#     else

#         log_events "Installation process finished." 0 ;
#         return 0

#     fi
# }

# function setup(){

#     if [[ $EUID -eq 0 ]]; then

#         error_packages=0
#         success_packages=0

#         # Create folders in user directory
#         xdg-user-dirs-update

#         while read -r package; do

#             install_package "$package"

#             if [ $? -eq 0 ]; then
#                 ((success_packages++))
#             else
#                 ((error_packages++))
#             fi

#         done < "$PACKAGES_FILE"

#         echo -e "Success installed packages: ${GRE_FG}$success_packages${END_FG}"
#         echo -e "Packages with error: ${RED_FG}$error_packages${END_FG}"

#         apt autoremove

#     else

#         echo -e "[${YEL_FG}WARNING${END_FG}] This script must be executed with sudo." 
#         exit 1

#     fi

    
# }

# setup


