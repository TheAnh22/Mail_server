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
    echo "1. Sua Domain"
    echo "2. Sua dia chi IP"
    echo "3. Them User"
    echo "4. Xoa User"
    echo "5. Doi mat khau user"
    echo "6. Xuat toan bo user"
    echo "7. Exit"
    echo "====================="
    read -p "Nhập lựa chọn của bạn (1-4): " choice

    case $choice in
        1)      
            clear
            read -p "Nhap ten mien moi " NEW_DOMAIN
            if [ -z "$NEW_DOMAIN" ]; then
            	echo "Ten mien khong duoc de trong!"
            	exit 1
            fi
            sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.origin
            sudo sed -i "s/^mydomain = .*/mydomain = $NEW_DOMAIN/" /etc/postfix/main.cf
            sudo sed -i "s/^myhostname =.*/myhostname = mail.$NEW_DOMAIN/" /etc/postfix/main.cf 
            service postfix restart
            ;;
        2)
            clear 
            read -p "Nhap day dia chi " NEW_IP
            if [ -z "$NEW_IP" ]; then
            	echo "IP khong duoc de trong!"
            	exit 1
            fi
            sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.origin
            sudo sed -i "s/^mynetworks = .*/mynetworks = $NEW_IP/" /etc/postfix/main.cf 
            service postfix restart
            ;;
        3)
            clear
            read -p "Nhap ten user:" USERNAME
            read -p "Nhap password:" PASSWORD
            sudo adduser --gecos "" --disabled-password "$USERNAME"
            echo "$USERNAME:$PASSWORD" | chpasswd
       	    clear
            ;;
        4)
            clear
            read -p "Nhap ten nguoi dung:" DELUSER
            ;;
        5) 
            clear
            awk -F: '$3 >= 1000 { print $1 }' /etc/passwd
            ;;
        6)
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

