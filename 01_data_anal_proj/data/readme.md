✈️ 항공사 지연 데이터 분석 프로젝트
📌 프로젝트 개요
본 프로젝트는 항공 운항 지연의 주요 원인을 파악하고, 항공사별 지연 특성과 패턴을 비교 분석함으로써 항공 지연 문제에 대한 데이터 기반 인사이트를 도출하는 데 목적이 있다.

주요 지연 요인:
pct_carrier_delay, pct_atc_delay, pct_weather_delay

분석 목적:

결측치 처리 전략 수립 및 비교

변수 분포 및 이상치 탐색을 포함한 탐색적 데이터 분석(EDA)

항공사별 지연 패턴 비교

공분산, 상관관계, 다중공선성 분석

시각화를 통한 인사이트 도출

📂 데이터 출처
Kaggle Dataset: Airline Stats

총 데이터 수: 33,468건

🔑 주요 컬럼
컬럼명 설명
pct_carrier_delay 항공사 내부 사정으로 인한 지연 비율
pct_atc_delay 항공 교통 통제로 인한 지연 비율
pct_weather_delay 기상 조건으로 인한 지연 비율
airline 항공사명

🧰 사용 기술 스택
언어: Python 3.12.9

라이브러리:

pandas, numpy: 데이터 처리 및 연산

matplotlib: 시각화

statsmodels: 다중공선성 분석 (VIF)

🎯 분석 목표
지연 원인 간 상관관계 및 중복성 확인

항공사별 지연율 특성 파악

시각적 스토리텔링을 통해 정책 개선 방향 제안
