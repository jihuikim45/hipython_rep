import streamlit as st
from PIL import Image

st.title("스트림릿 앱 페이지 구성하기")

st.sidebar.header('웰컴 메뉴')
selected_menu = st.sidebar.selectbox(
    '메뉴선택', ['메인', '분석', '설정']
)

# 이미지 로드
def load_image(path):
    try:
        return Image.open(path)
    except FileNotFoundError:
        return None

img1 = load_image('image/크하하루피.jpg')
img2 = load_image('image/하트루피.jpg')
img3 = load_image('image/happy.jpg')
# ---------------------
# 분석 탭 함수
def make_anal_tab():
    tab1, tab2, tab3 = st.tabs(['차트', '데이터', '설정'])
    with tab1:
        st.subheader('차트 탭')
        st.bar_chart({'데이터':[1,2,3,4,5]})
        
    with tab2:
        st.subheader('데이터 탭')
        st.dataframe({'기준':['a', 'b', 'c', 'd', 'e'], '값':[1,2,3,4,5]})

    with tab3:
        st.subheader('설정 탭')
        enabled = st.checkbox('자동 업데이트 활성화 여부', value=True)
        update_interval = st.slider(
            '업데이트 주기 (sec)',
            min_value=1, max_value=60,
            value=5, step=1
        )
        st.write(f'활성화: {enabled}, 주기: {update_interval}초')
# ---------------------

# 페이지별 화면 구성
if selected_menu == '메인':
    st.subheader('*메인 페이지*')
    st.write('반가워요!')
    
    
    col1, col2 = st.columns(2)
    with col1:
        if img1:
            st.image(img1, width=300, caption='Image from Unsplash')
        else:
            st.write("이미지 1 없음")        
    with col2:
        if img2:
            st.image(img2, width=150, caption='Image from Unsplash')
        else:
            st.write("이미지 1 없음")

elif selected_menu == '분석':
    st.subheader('분석 보고서')
    st.write('여기서 데이터를 선택할 수 있습니다.')

    # 열 3개로 나누고 가운데(col2)에만 배치
    col1, col2, col3 = st.columns([1,2,1])
    with col2:
        if img1:
            st.image(img3, width=300, caption='분석 이미지 (JPG)')
        else:
            st.write("이미지 없음")

    make_anal_tab()



else:
    st.subheader('설정 변경')
    st.write('앱 설정을 수정해보세요.')
    
    if st.sidebar.button('선택'):
        st.sidebar.write('선택을 클릭하셨습니다.')    

st.divider()
    
# 확장영역 추가
st.header('익스펜더 추가')
with st.expander('숨긴 영역'):
    st.write('여기는 보이지 않습니다. 클릭해야 보입니다.')
