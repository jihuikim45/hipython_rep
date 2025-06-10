# 맛 선택 함수
from constants import flavor_list
def select_flavors(selected_menu):
    """
    맛 선택 함수
    선택한 메뉴에 따라 선택해야 하는 맛의 개수만큼 입력을 받음
    """
    flavor_count = int(selected_menu['count'][0])
    print(f"\n'{selected_menu['name']}' 선택 — {flavor_count}가지 맛을 골라주세요")

    cols_per_row = 3
    for i, fla in enumerate(flavor_list):
        print(f"{i+1}. {fla['flavor']:<10}", end='')
        if (i + 1) % cols_per_row == 0 or i == len(flavor_list) - 1:
            print()

    flavor_input = input("\n맛 번호들을 입력하세요 (예: 1, 3, 5) / 0 입력시 메뉴 선택으로 돌아가기: ").strip()

    if flavor_input == '0':
        print("맛 선택을 취소하고 메뉴로 돌아갑니다.\n")
        return None  # flavor_canceled 대신 None 반환

    try:
        parts = flavor_input.split(',')
        flavor_nums = [int(p.strip()) - 1 for p in parts if p.strip().isdigit()]  # 번호 변환
        if len(flavor_nums) != flavor_count or any(i < 0 or i >= len(flavor_list) for i in flavor_nums):
            raise ValueError  # 갯수 다르거나 번호가 범위 밖일 때 예외 발생
        selected_flavors = [flavor_list[i]['flavor'] for i in flavor_nums]
        return selected_flavors
    except ValueError:
        print(f"정확히 {flavor_count}가지 맛을 정확히 입력해주세요.")
        return []