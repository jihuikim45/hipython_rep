# 파일 저장 관련 함수
import datetime

def save_order_to_file(name, total_point, total_price, orders, file_path):
    now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    try:
        with open(file_path, "a", encoding="utf-8") as f:
            f.write(f"[주문자명]: {name}\n")
            f.write(f"[주문시각]: {now}\n")
            f.write(f"[총 결제 금액]: {total_price:,}원\n")
            f.write(f"[총 적립 포인트]: {total_point}p\n")
            f.write("="*40 + "\n")
            for i, order in enumerate(orders, start=1):
                f.write(f"{i}. {order['menu_name']} — {order['price']:,}원\n")
                for idx, flavor in enumerate(order['flavor_names'], start=1):
                    f.write(f"   - 맛 {idx}: {flavor}\n")
            f.write("="*40 + "\n")
            f.write("감사합니다. 또 오세요!\n")
    except (FileNotFoundError, PermissionError, IOError) as e:
        print(f"파일 저장 중 오류가 발생했습니다: {e}")