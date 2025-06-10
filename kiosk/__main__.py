# 메인 루프 실행
from menu import select_menu
from flavor import select_flavors
from cart import cart
from order import extra_order, canceled, show_orders
from payment import check_out, member_ship
from file_io import save_order_to_file
from constants import menu_list


import datetime

point_list = []
all_orders = []

FILE_PATH = "C:/mysrc/my_orders.txt"

# main 루프
if __name__ == "__main__":
    while True:
        orders = []

        while True:
            order_num = select_menu()
            if order_num is None:
                continue
            selected_menu = menu_list[order_num]

            selected_flavors = select_flavors(selected_menu)
            if selected_flavors is None or not selected_flavors:
                continue

            if not cart(orders, selected_menu, selected_flavors):
                continue

            if not extra_order():
                break

        if canceled(orders):
            continue

        total_price = check_out(orders)
        if total_price == 0:
            print("남은 주문이 없습니다. 처음으로 돌아갑니다.\n")
            continue

        name, total_point = member_ship(point_list, total_price)

        now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        all_orders.append({
            'timestamp': now,
            'orders': orders.copy(),
            'total_price': total_price
        })

        save_order_to_file(name, total_point, total_price, orders, FILE_PATH)
