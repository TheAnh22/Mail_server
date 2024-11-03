#!/bin/bash

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
            bash /home/theanh/postfix.sh
            ;;
        2)
            echo "Thư mục hiện tại là:"
            pwd
            ;;
        3)
            echo "Các tập tin trong thư mục hiện tại:"
            ls
            ;;
        4)
            echo "Thoát chương trình."
            clear
            exit 0
            ;;
        *)
            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
            ;;
    esac

    # Dừng lại để người dùng nhấn Enter trước khi quay lại menu
    read -p "Nhấn Enter để tiếp tục..."
    clear
done

