# 메뉴 선택 함수

from constants import store_name, menu_list

def select_menu():
    """
    메뉴를 선택하는 함수.
    선택된 메뉴 인덱스를 반환.
    """
    print("="*45)
    print(f'{store_name:^40}')
    print("="*45)
    print("어서오세요 아이스크림을 또 주는 또젤라또입니다\n")

    for i, menu in enumerate(menu_list):
        print(f'{i + 1}. {menu["name"]:<6} {menu["count"]:>12} {menu["price"]:>10,}원')
    print("="*45)

    order_input = input('주문할 메뉴 번호를 입력해주세요: ').strip().lower()

    try:
        order_num = int(order_input)  # 입력이 숫자로 변환 가능한지 확인
        if not (1 <= order_num <= len(menu_list)):
            raise ValueError  # 범위를 벗어난 숫자도 예외 처리
        return order_num - 1
    except ValueError:
        print("잘못된 입력입니다. 다시 시도해주세요.\n")
        return None