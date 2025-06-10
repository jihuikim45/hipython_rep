# 주문 내역, 취소 관련 함수
def extra_order():
    """
    추가 주문 여부 확인 함수

    Returns:
        bool: 추가 주문할 경우 True, 아니면 False
    """   
    while True:
        another = input("추가 주문하시겠습니까? (Y/N): ").strip().lower()
        if another == 'y':
            return True  # 다시 메뉴 선택으로
        elif another == 'n':
            return False  # 주문 확인 단계로
        else:
            print('!(Y/N)로 입력해주세요!')

def show_orders(orders):
    """
    현재 주문 내역 출력 함수

    Args:
        orders (list): 주문 내역 리스트 (dict 요소)
    """
    
    if not orders:
        print("현재 주문이 없습니다.")

    else:
        for i, order in enumerate(orders):
            print(f"{i+1}. {order['menu_name']} — {order['price']:,}원")
            for idx, name in enumerate(order['flavor_names']):
                print(f"   - 맛 {idx+1}: {name}")


def canceled(orders):
    """
    주문 취소 처리 함수
    주문 내역을 출력하고 사용자가 취소를 원하는 주문을 삭제할 수 있게 함

    Args:
        orders (list): 현재 주문 내역 리스트

    Returns:
        bool: 남은 주문이 있으면 False (결제 진행) 없으면 True (처음으로 돌아감)
    """
    while True:
        if not orders:
            print("현재 주문이 없습니다.")
            return True
            
        cancel_q = input("\n주문 내역 중 취소할 주문이 있습니까? (Y/N): ").strip().lower()
        if cancel_q == 'n':
            return False # 취소 안 하고 결제 진행
        elif cancel_q == 'y':
            print("\n다시 주문 내역을 보여드립니다:")
            show_orders(orders)

            del_input = input("취소할 주문 번호를 입력하세요 (0 입력시 결제창으로): ").strip()
            if del_input == '0':
                return False # 결제 진행
            try:
                del_index = int(del_input) - 1  # 정수 변환
                if 0 <= del_index < len(orders):
                    removed = orders.pop(del_index)
                    print(f"'{removed['menu_name']}' 주문이 삭제되었습니다.")
                else:
                    raise IndexError  # 인덱스 범위 벗어날 때
            except (ValueError, IndexError):
                print("잘못된 번호입니다.")
        else:
            print("!(Y/N)로 입력해주세요!")
