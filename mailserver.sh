#!/bin/bash
clear
PATHWAY=$(pwd)

service postfix start
service dovecot start
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
	    	exit 0
	    	
	fi
fi
	
while true; do
    # Hiển thị menu
	
    echo "====================="
    echo "Chọn một tùy chọn:"
    echo "1. Sua Domain"
    echo "2. Sua Nameserver"
    echo "3. Them User"
    echo "4. Xoa User"
    echo "5. Doi mat khau user"
    echo "6. Xuat toan bo user"
    echo "7. Exit"
    echo "====================="
    read -p "Nhập lựa chọn của bạn: " choice

    case $choice in
    	#Nhập tên miền mới
    	
	 1)      
            clear
            read -p "Nhap ten mien moi: " NEW_DOMAIN
            if [ -z "$NEW_DOMAIN" ]; then
            	echo "Ten mien khong duoc de trong!"
            	exit 1
            else
            	sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.origin
            	
            	sudo sed -i "s/^mydomain = .*/mydomain = $NEW_DOMAIN/" /etc/postfix/main.cf
            	
            	service postfix restart
            	service dovecot restart
            fi
            ;;
         2)
            clear
            read -p "Nhap ten mien mail server: " NEW_HOSTNAME
            if [ -z "$NEW_HOSTNAME" ]; then
            	echo "Ten hostname khong duoc de trong"
            else
            	sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.origin
            	sudo sed -i "s/^myhostname = .*/myhostname = mail.$NEW_HOSTNAME/" /etc/postfix/main.cf 
            	service postfix restart
            	service dovecot restart
            fi
            ;;
       #Thêm user
	 3)
            clear
            read -p "Nhap ten user:" USERNAME
            read -p "Nhap password:" PASSWORD
            sudo adduser --gecos "" --disabled-password "$USERNAME"
            echo "$USERNAME:$PASSWORD" | chpasswd
       	    clear
            ;;
       #Xóa user 
	 4)
            clear
            awk -F ":" '$3 >= 1000 { print $1 }' /etc/passwd
            read -p "Nhap ten nguoi dung(bo trong de thoat):" DELUSER
            if [ -z "$DELUSER" ]; then
            	echo ""
            	clear
            else
            	if  id "$DELUSER" &>/dev/null ; then
  			sudo deluser --remove-all-files $DELUSER
  			clear
  			echo "Da xoa user!"
		else
  			echo "User '$DELUSER' không tồn tại trong hệ thống."
		fi
            fi
            ;;
        #Doi password
        5) 
            clear
            awk -F ":" '$3 >= 1000 { print $1 }' /etc/passwd
            read -p "Nhap ten user can doi password:" CHANGEUSER
            case "$CHANGEUSER" in
            	"")
            	   clear
            	   ;;
            	*)
            	   if  id "$CHANGEUSER" &>/dev/null ; then
  			read -p "Nhap password moi:" NEWPASS
            		read -p "Nhap lai password:" AGAINPASS
            			if [ "$NEWPASS" = "$AGAINPASS" ]; then
            				echo "$CHANGEUSER:$NEWPASS" | chpasswd
            				if [ $? -eq 0 ]; then
            					
            					read -p "Doi thanh cong, nhan ENTER de tiep tuc"
            				else
            					read -p "Doi that bai, nhan ENTER de tiep tuc" ENTER
            				fi
            			else 
            				echo "Pasword khong khop!"
            				exit 1
            			fi
	    	   else
  		       echo "User '$DELUSER' không tồn tại trong hệ thống."
	           fi
	           ;;
	      esac
            ;;
        6)
	    clear 
            awk -F ":" '$3 >= 1000 { print $1 }' /etc/passwd
            read -p "Press any key to countinue" 
            ;;
        7)
      	    clear
	    exit 0
	    
            ;;
        *)
            clear
            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
            ;;
    esac
    clear
done

