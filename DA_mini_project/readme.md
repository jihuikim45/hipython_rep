# 📞 Telco 고객 이탈 분석 프로젝트

## 1️. 프로젝트 개요

- **목적:**  
  Telco 고객 이탈(Churn) 데이터를 분석하여 **이탈 위험 고객군을 식별**하고, **고객 유치 전략 수립**을 위한 데이터 기반 인사이트 도출.

- **사용 데이터:**  
  `WA_Fn-UseC_-Telco-Customer-Churn.csv`

- **사용 라이브러리:**
  - pandas, numpy
  - matplotlib, seaborn

---

## 2️. 분석 목표

1) Telco 고객의 이탈 여부를 이해  
2) 이탈 고객의 특성을 데이터 기반으로 식별  
3) 이탈 위험 고객군을 타깃화해 유지/유치 전략을 수립

---

## 3️. 분석 절차

1) 데이터 클렌징

- `TotalCharges` 수치형 변환 및 결측값 제거
- 총 7032명의 고객 데이터 확보

2) EDA

- Churn(이탈 여부) 비율 확인 (26.6% 이탈)
- 연속형 변수(`tenure`, `MonthlyCharges`, `TotalCharges`) 분포 분석
- 범주형 변수(`Contract`, `PaymentMethod`, `InternetService` 등)별 이탈 여부 비교

3) 변수 간 상관관계 분석

- Heatmap을 통해 변수 간 관계 확인:
  - `tenure`와 `TotalCharges` 간 높은 상관관계 (0.83)

4) 이탈 위험 고객군 식별

다음 조건으로 **450명 이탈 고위험 고객군 식별**:

- `Contract`: Month-to-month
- `PaymentMethod`: Electronic check
- `tenure` ≤ 6개월
- `MonthlyCharges` ≥ 평균(약 64.76)

---

## 4️. 인사이트

- **가입 초기(6개월 이하), 월 요금이 높은 고객군의 이탈 확률이 높음.**
- `Month-to-month` 계약 및 `Electronic check` 결제 방식 고객의 이탈률이 높음.
- 시니어, 파트너/부양가족이 없는 고객군의 이탈률이 상대적으로 높음.

---

## 5️. 고객 유치 전략

1) **장기 계약 전환 유도:**

- 1~2년 계약 전환 시 할인/포인트 제공

2) **자동 결제 전환 유도:**

- 자동이체/카드 결제 전환 시 혜택 제공

3) **맞춤 혜택 제공:**

- OTT 무료 제공, 데이터 혜택

4) **만족도 및 불만 사전 파악:**

- 설문 및 혜택 제공을 통한 해지 방지

*이 전략을 통해 **이탈 방지 및 LTV 증대, 수익 기반 안정화**가 가능함.*

---

## 6️. 향후 계획

- 이탈 예측 모델 개발(RandomForest, XGBoost)
- LTV 기반 이탈 방지 시뮬레이션 및 KPI 설계
- 분석 리포트 시각화 및 자동화 보고 대시보드 개발

---

## 7. 파일 구성

- `Telco_Churn_EDA.ipynb` : 전체 분석 코드
- `charts/` : 시각화 이미지
- `data/WA_Fn-UseC_-Telco-Customer-Churn.csv` : 원본 데이터
- `README.md` : 프로젝트 요약 및 결과 정리

---

## 8. 기여 및 문의

본 프로젝트는 EDA 기반 고객 이탈 분석 및 전략 기획 학습용으로 진행되었습니다.  
기여 및 협업, 문의는 [kimjihui45@gmail.com](mailto:kimjihui45@gmail.com) 으로 연락주세요.
