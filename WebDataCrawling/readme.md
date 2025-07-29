# G마켓 베스트 상품 크롤링 프로젝트 보고서

## 1. 분석 목적

본 프로젝트는 G마켓(Gmarket)의 베스트 상품 랭킹 페이지를 대상으로  
실시간 상위 200개의 상품 정보를 수집하고,  
해당 데이터를 CSV 파일 및 MySQL 데이터베이스에 저장하는 자동화 작업을 수행한다.  
향후 마케팅, 트렌드 분석, 추천 알고리즘 등 다양한 데이터 분석의 기초 자료로 활용될 수 있다.

---

## 2. 데이터 개요

1. 크롤링 대상: https://www.gmarket.co.kr/n/best
2. 수집 항목:
   - item_rank: 상품 순위
   - title: 상품명
   - price: 판매가 (정수형, 쉼표 및 '원' 제거)
3. 수집 방식:
   - Selenium을 이용해 JavaScript 렌더링된 DOM을 수집
   - BeautifulSoup으로 HTML 파싱 및 필터링
   - `.box__label-rank` 존재 여부로 실제 랭킹 상품만 추출

---

## 3. 시스템 구성 및 처리 흐름

1. 크롤링
   - Selenium + ChromeDriver로 페이지 접근
   - 광고/추천 제외: `.box__label-rank` 없는 항목 필터링
2. 데이터 저장
   - CSV 저장 (`data/gmarket_best.csv`)
   - DB 저장 (`my_db.gmarket_best` 테이블)

---

## 4. 테이블 스키마

```sql
CREATE TABLE gmarket_best (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_rank INT,
    title VARCHAR(255),
    price INT
);

INSERT INTO gmarket_best (item_rank, title, price)
VALUES (%s, %s, %s);
```

## 5. 📂 폴더 구조

📂WebDataCrawling/  
├── data/  
│ └── 📄gmarket*best.csv  
| └── 📄my_database.db  
├── sql/  
│ └── 📄gmarket_best.sql  
├── src/  
│ └── 📄gmarket_save.py  
├── notebooks/  
│ └── 📄실습*지마켓랭킹수집.ipynb  
├── 📄README.md

## 6. 실행 예시

```py
python src/gmarket_save.py
```

## 7. 향후 확장 계획

- 수집 날짜 기록 및 누적 저장
- 상품 이미지, 상세 링크, 할인율 필드 추가
- 예외 처리 및 에러 로그 파일 저장
- 다른 이커머스 플랫폼 크롤러 확장 (11번가, 쿠팡 등)
