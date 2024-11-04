#!/bin/bash

echo "====================="
echo "Chọn một tùy chọn:"
echo "1. Thay doi domain"
echo "2. Config Dovecot"
echo "3. Manage User"
echo "4. Exit"
echo "====================="
read -p "Nhập lựa chọn của bạn (1-4): " choice
case $choice in
        1)      
            clear
            read -p "Nhập tên miền mới cho Postfix: " NEW_DOMAIN
            if [ -z "$NEW_DOMAIN" ]; then
            	echo "Ten mien khong duoc de trong!"
            	exit 1
            fi
            sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.origin
            sudo sed -i "s/^mydomain = .*/mydomain = $NEW_DOMAIN/" /etc/postfix/main.cf
            service postfix restart
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
