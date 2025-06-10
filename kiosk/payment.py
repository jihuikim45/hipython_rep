# 결제 및 포인트 적립 함수
from order import show_orders

def check_out(orders):
    """
    최종 결제 금액 계산 함수

    Args:
        orders (list): 현재 주문 내역 리스트

    Returns:
        int: 총 결제 금액
    """
    print("\n💳 최종 주문 내역:")
    show_orders(orders)
    
    total_price = sum(order['price'] for order in orders)
    print('\n' + '='*45)
    print(f"💰 총 결제 금액: {total_price:,}원")
    return total_price


def member_ship(point_list, total_price):
    """
    포인트 적립 처리 함수
    전화번호로 적립 또는 신규 등록

    Args:
        point_list (list): 포인트 정보 저장 리스트
        total_price (int): 총 결제 금액

    Returns:
        str: 전화번호 (회원), 또는 "고객"
    """
    while True:
        point_q = input('포인트 적립하시겠습니까? (Y/N): ').strip().lower()
        if point_q == 'y':
            membership = input("전화번호를 입력해주세요: ").strip()
            saved_point = total_price // 100
            idx = -1
            
            for i, user in enumerate(point_list):
                if user['membership_nb'] == membership:
                    idx = i
                    break
                    
            if idx != -1:
                point_list[idx]['membership_point'] += saved_point
                total_point = point_list[idx]['membership_point']
            else:
                point_list.append({'membership_nb': membership, 'membership_point': saved_point})
                total_point = saved_point
                
            print(f"{saved_point}포인트 적립 완료 → 총 {total_point}포인트")
            return membership, total_point  # ✅ 함수 반환으로 name 대체
            
        elif point_q == 'n':
            return "고객", 0
        else:
            print('!(Y/N)로 입력해주세요!')
