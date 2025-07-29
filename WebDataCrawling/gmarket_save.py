# valid_items는 크롤링 결과라고 가정하고 이미 존재하는 상태

data = []

for i, item in enumerate(valid_items, start=1):
    title_tag = item.select_one('.box__item-title')
    price_tag = item.select_one('.box__price-seller .text__value')

    title = title_tag.text.strip() if title_tag else '제목 없음'
    sel_price = price_tag.text.strip() if price_tag else '0'

    try:
        price = int(sel_price.replace(",", "").replace("원", ""))
    except:
        price = 0

    data.append({
        'rank': i,
        'title': title,
        'price': price
    })

# CSV 저장
df = pd.DataFrame(data)
df.to_csv('gmarket_best.csv', index=False, encoding='utf-8-sig')
print("💌 CSV 저장 완료 → gmarket_best.csv")

# DB 저장
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Qpswutm45!',
    database='my_db',
    charset='utf8mb4'
)

cursor = conn.cursor()

insert_query = '''
    INSERT INTO gmarket_best (item_rank, title, price)
    VALUES (%s, %s, %s)
'''

for row in data:
    cursor.execute(insert_query, (row['rank'], row['title'], row['price']))

conn.commit()
cursor.close()
conn.close()
print("🩷 DB 저장 완료!")