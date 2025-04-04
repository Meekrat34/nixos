#/bin/bash



    # Function to execute a command in sudo mode
    execute_command() {
        echo -e "\033[1;33mRunning command: $1\033[0m"
        $1
    }

    # Function to display the menu options
    display_menu() {
        echo -e "\033[1;34m*******************************************************************************************************\033[0m"
        echo -e "\033[1;0m      My Script Menu                        Description"
        echo -e "\033[1;34m*******************************************************************************************************\033[0m"
        echo -e "\033[1;32m 1. ls  \033[0m			List files in current directory"
        echo -e "\033[1;32m 2. ls -a  \033[0m			List files in current directory including hidden ones"
        echo -e "\033[1;32m 3. mc  \033[0m    			Midnight Commander file manager"
        echo -e "\033[1;32m 4. mc \033[1;33m(sudo)  \033[0m    		Midnight Commander file manager as \033[1;33msudo\033[1;0m"
        echo -e "\033[1;32m 5. my nic  \033[0m    "
        echo -e "\033[1;32m 6. my router ip  \033[0m    "
        echo -e "\033[1;32m 7.   \033[0m    "
        echo -e ""
        echo -e "\033[1;34m*******************************************************************************************************\033[0m"
        echo -e "\033[1;31m 0.   Exit\033[0m			Exit Menu"
        echo -e "\033[1;34m*******************************************************************************************************\033[0m"
    } 

    # Clear the screen
    clear
    # Retrieve host ip address
    my_ip="$(ip route get 8.8.8.8 | tr -s ' ' | cut -d' ' -f7 | head -n 1)"
    my_nic="$(ip route get 8.8.8.8 | tr -s ' ' | cut -d' ' -f5 | head -n 1)"
    my_router="$(ip route get 8.8.8.8 | tr -s ' ' | cut -d' ' -f3 | head -n 1)"

    # run menu
    display_menu

     while true; do
        echo -e "\033[1;0m --->  \033[1;33m$USER@$HOSTNAME  \033[1;0m-  \033[1;33m$(pwd)  \033[1;0m-  \033[1;33m$my_ip\033[1;0m"
        echo ""
        choice=""
        echo -n -e "\033[1;33m Choice --> \033[1;0m "
        read choice

    echo ""
        case $choice in
            1) execute_command "ls" ;;
            2) execute_command "ls -a" ;;
            3) execute_command "mc" ;;
            4) execute_command "sudo mc" ;;
            5) execute_command "echo -e $(ip route get 8.8.8.8 | tr -s ' ' | cut -d' ' -f5 | head -n 1)" ;;
            6) execute_command "echo -e $(ip route get 8.8.8.8 | tr -s ' ' | cut -d' ' -f3 | head -n 1)" ;;
            7) execute_command "" ;;
            


            0) exit ;;
            *) echo -e "\033[1;31m Not listed try again.\033[0m" ;;
        esac
        read -rsn1 -p "any key to continue..."
        clear
        display_menu
    done

