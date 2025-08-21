import streamlit as st
import pandas as pd
import pydeck as pdk
import plotly.express as px

st.set_page_config(page_title="츄러스미", layout="wide")

# ===== CSS (상단 헤더, 카드 버튼 스타일) =====
st.markdown(
    """
    <style>
    /* 상단 헤더 */
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #a7c7e7;
        padding: 12px 20px;
        border-radius: 10px 10px 0 0;
    }
    .header-left {
        font-size: 22px;
        font-weight: bold;
        color: #4a2c2a;
    }
    .header-right {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .icon {
        font-size: 22px;
        cursor: pointer;
    }
    .username {
        background: #f0f0f0;
        border-radius: 15px;
        padding: 5px 12px;
        font-size: 14px;
    }

    /* 카드 버튼 */
    .card {
        border-radius: 15px;
        padding: 25px;
        background: linear-gradient(#f0f5ff, #d6e0f5);
        text-align: center;
        cursor: pointer;
        transition: 0.3s;
    }
    .card:hover {
        background: linear-gradient(#e1ebff, #c0d4ff);
        transform: scale(1.02);
    }
    .card h3 {
        margin: 5px 0;
        color: #000;
    }
    .card p {
        font-size: 14px;
        color: #333;
    }
    </style>
    """,
    unsafe_allow_html=True
)

# ===== 사이드바 =====
with st.sidebar:
    st.title("📋 메뉴")
    menu = st.selectbox(
        "",
        ["홈", "챗봇", "병원 추천", "진단", "내 프로필"]
    )

# ===== 상단 헤더 =====
st.markdown(
    """
    <div class="header">
        <div class="header-left">🎀 츄러스미</div>
        <div class="header-right">
            <div class="icon">🔔</div>
            <div class="username">다은</div>
        </div>
    </div>
    """,
    unsafe_allow_html=True
)

st.write("")  # 여백

# ===== 홈 화면 =====
if menu == "홈":
    # 환영 메시지
    st.markdown(
        "<h2 style='text-align: center; color:#4A6CF7;'>다은님, 반가워요!</h2>",
        unsafe_allow_html=True
    )
    st.write("")

    # 카드형 버튼
    col1, col2 = st.columns(2)

    with col1:
        if st.button("🏥 병원 추천 서비스", use_container_width=True):
            menu = "병원 추천"

    with col2:
        if st.button("📝 진단 서비스", use_container_width=True):
            menu = "진단"

# ===== 챗봇 페이지 =====
elif menu == "챗봇":
    st.subheader("🗨 상담하기")
    user_input = st.text_input("오늘 기분은 어때요?", key="chatbot_input")

    if user_input:
        st.chat_message("user").write(user_input)

        with st.chat_message("assistant"):
            st.write("제가 도와드릴게요!")
            if st.button("📝 나의 상태 진단해보기"):
                menu = "진단"

# ===== 병원 추천 페이지 =====
elif menu == "병원 추천":
    # 제목
    st.markdown(
        """
        <h2 style='text-align: center; color:#4A6CF7;'>
        📍 다은님 맞춤 병원 추천 서비스
        </h2>
        """,
        unsafe_allow_html=True
    )

    # CSV 불러오기
    hos_df = pd.read_csv("project/1st/data/hospital_location.csv")
    hos_df = hos_df.rename(columns={"좌표(X)": "lon", "좌표(Y)": "lat"})
    hos_df.columns = hos_df.columns.str.strip()

    # ===== 검색창 (병원 추천 전용) =====
    keyword = st.text_input("지역/동네 입력", placeholder="예: 강남구 도산대로")

    if st.button("🔍 검색"):
        if keyword:
            result = hos_df[hos_df["주소"].str.contains(keyword, na=False)]

            if not result.empty:
                st.markdown("### 🏥 병원 리스트")
                for _, row in result.iterrows():
                    st.markdown(
                        f"""
                        <div style='padding:10px; border:1px solid #ddd; border-radius:8px; margin-bottom:10px;'>
                            <b>{row['요양기관명_x']}</b> &nbsp; | &nbsp; 📞 {row['전화번호']} <br>
                            {row['주소']}
                        </div>
                        """,
                        unsafe_allow_html=True
                    )

                # pydeck 지도 표시
                layer = pdk.Layer(
                    "ScatterplotLayer",
                    data=result,
                    get_position='[lon, lat]',
                    get_radius=20,
                    get_color='[200, 30, 0, 160]',
                    pickable=True,
                )

                tooltip = {
                    "html": "<b>{요양기관명_x}</b><br/>📍 {주소}<br/>📞 {전화번호}",
                    "style": {"backgroundColor": "white", "color": "black"}
                }

                view_state = pdk.ViewState(
                    latitude=result["lat"].mean(),
                    longitude=result["lon"].mean(),
                    zoom=13
                )

                st.pydeck_chart(pdk.Deck(layers=[layer], initial_view_state=view_state, tooltip=tooltip))

            else:
                st.warning("해당 지역에서 병원을 찾을 수 없습니다.")
        else:
            st.info("검색할 지역(예: 동작구, 노량진)을 입력하세요.")



# ===== 진단 페이지 =====
elif menu == "진단":
    st.subheader("📝 간단 심리 진단")

    st.write("아래 질문에 1~5점(전혀 아니다~매우 그렇다)으로 답해주세요.")

    # 질문 6개
    q1 = st.slider("1. 요즘 기분이 우울하다.", 1, 5, 3)
    q2 = st.slider("2. 집중하기 어렵다.", 1, 5, 3)
    q3 = st.slider("3. 수면에 문제가 있다.", 1, 5, 3)
    q4 = st.slider("4. 불안한 기분이 자주 든다.", 1, 5, 3)
    q5 = st.slider("5. 사람들과의 관계가 힘들다.", 1, 5, 3)
    q6 = st.slider("6. 의욕이 떨어진다.", 1, 5, 3)

    if st.button("결과 보기"):
        # 점수 모으기
        raw_scores = [q1, q2, q3, q4, q5, q6]
        scores = [6 - s for s in raw_scores]  # 점수 반전
        labels = ["우울감", "집중력", "수면", "불안", "대인관계", "의욕"]

        # 데이터프레임 생성
        df = pd.DataFrame(dict(
            r=scores,
            theta=labels
        ))

        # 육각형 그래프 (Radar Chart)
        fig = px.line_polar(df, r='r', theta='theta', line_close=True)
        fig.update_traces(fill='toself', line_color="red", fillcolor="rgba(255,0,0,0.3)")
        fig.update_layout(polar=dict(radialaxis=dict(visible=True, range=[0, 5])))

        st.plotly_chart(fig)

        st.success("결과가 육각형 그래프로 표시되었습니다.")

    


# ===== 내 프로필 페이지 =====
elif menu == "내 프로필":
    st.subheader("👤 내 정보")
    name = st.text_input("이름")
    age_input = st.text_input("나이")

    age = None
    if age_input.isdigit():  # 숫자만 입력했을 때만 변환
        age = int(age_input)

    if name and age:  # 입력이 모두 되었을 때만 출력
        st.write(f"이름: {name}, 나이: {age}")
