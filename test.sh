#!/bin/bash

	postfixStatus=$(systemctl is-active postfix)
	dovecotStatus=$(systemctl is-active dovecot)
	if [ "$dovecotStatus" == "active" ] && [ "$postfixStatus" == "active" ]; then
	    echo "Postfix and Dovecot dang chay"
	else
	    read -p "Postfix va Dovecot chua duoc cai dat,bat dau cai dat (y/n):" answer
	    if [ "$answer" == "y" ]; then
	    	bash /home/theanh/Mail_server/install.sh
	    else 
	    	clear
	    	echo "Thoat ung dung"
	    	
	    fi
	fi
	
while true; do
    # Hiển thị menu
	
    echo "====================="
    echo "Chọn một tùy chọn:"
    echo "1. Config Postfix"
    echo "2. Config Dovecot"
    echo "3. Manage User"
    echo "4. Exit"
    echo "====================="
    read -p "Nhập lựa chọn của bạn (1-4): " choice

    case $choice in
        1)      
            clear
            bash /home/theanh/Mail_server/postfix.sh
            ;;
        2)
            clear 
            bash /home/theanh/Mail_server/dovecot.sh
            ;;
        3)
            clear
            bash /home/theanh/Mail_server/user.sh
            ;;
        4)
            echo "Thoát chương trình."
            clear
            exit 0
            ;;
        *)
            clear
            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
            ;;
    esac

    # Dừng lại để người dùng nhấn Enter trước khi quay lại menu
done

