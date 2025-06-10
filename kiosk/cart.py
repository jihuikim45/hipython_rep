# 장바구니 기능 함수
def cart(orders, selected_menu, selected_flavors):
    """
    주문 확인 및 장바구니 추가 함수
    현재 선택한 메뉴와 맛을 출력하고 사용자에게 장바구니 추가 여부를 확인

    Args:
        orders (list): 현재 주문 목록 리스트 (dict 요소)
        selected_menu (dict): 선택된 메뉴 정보
        selected_flavors (list): 선택된 맛 리스트

    Returns:
        bool: 장바구니에 추가(True), 취소(False)
    """
    print("\n선택한 주문:")
    print(f"메뉴: {selected_menu['name']}") # 선택한 메뉴(사이즈) 
    for idx, name in enumerate(selected_flavors):
        print(f" - 맛 {idx+1}: {name}") #맛 순번과 맛이름
    print(f"가격: {selected_menu['price']:,}원") #총 가격

    while True:
        confirm = input("\n이 주문을 장바구니에 추가할까요? (Y: 추가 / N: 취소): ").strip().lower()
        if confirm == 'y':               
            orders.append({
                'menu_name': selected_menu['name'],
                'flavor_names': selected_flavors,
                'price': selected_menu['price']
            })
            print("주문이 장바구니에 추가되었습니다.\n")
            return True
        elif confirm == 'n':
            print("주문이 취소되었습니다.\n")
            return False
        else:
            print('!(Y/N)로 입력해주세요!')
