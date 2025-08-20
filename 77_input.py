import streamlit as st

#checkbox
active = st.checkbox('I agree')
if active:
    st.text('Welcome....')
    
    
#함수, on_change=checkbox_write
def checkbox_write():
    st.write("🫷")
st.checkbox("Don't agree", on_change=checkbox_write)

## 세션-상태 값에 저장
if 'checkbox_state' not in st.session_state:
    st.session_state.checkbox_state = False

def checkbox_write1():
    st.session_state.checkbox_state = True
    
if st.session_state.checkbox_state:
    st.write('다시 생각해주세요.')
        
st.checkbox("정말이에요?", on_change=checkbox_write1)

st.divider()

############################################# 토글 버튼

selected = st.toggle('Turn on the switch👆')
if selected:
    st.text('turn on!')
else:
    st.text('turn off.')


# selectbox 선택지
option = st.selectbox(
    '당신이 좋아하는 음식은?',
    options=['사골', '갈비탕', '샤브샤브', '백숙'],
    index=None,
    placeholder='네개 중 하나만 골라주세요.'
)
st.text(f'좋아하는 음식은 : {option}')


# radio
genre = st.radio(
    '무슨 영화를 좋아하세요?', ['멜로', '스릴러', '판타지'],
    captions=['노트북', '트리거', '윈즈데이']
)
st.text(f'당신이 좋아하는 장르는 {genre}입니다.')


#multiselect
menus = st.multiselect(
    '먹고 싶은 것을 모두 골라주세요.', ['사골', '갈비탕', '샤브샤브', '백숙']
)
st.text(f'선택한 메뉴는 {menus}입니다.')


#slider
score = st.slider('점수를 선택해주세요.', 0, 100, 10) #start, end, init-value
st.text('score:{score}')


from datetime import time
st_time, end_time = st.slider(
    '수업시간 선택', 
    min_value=time(7), max_value=time(11),
    value=(time(9), time(18)),
    format='HH:mm'
)
st.text(f'수업시간: {st_time}~{end_time}')


#text_input
txt1 = st.text_input('영화제목', placeholder='제목을 입력하세요')
txt2 = st.text_input('비밀번호', placeholder='비밀번호를 입력하세요', type='password')
st.text(f'텍스트 입력 결과 : {txt1} , {txt2}')

# 파일업로더
# 업로드한 파일은 사용자의 세션에 있다. 화면을 갱신하면 사라짐
# 서버에 저장하려면 별도로 구현해야 함
# 데이터베이스에 저장하는 로직도 구현 가능

import pandas as pd

file = st.file_uploader(
    '파일 선택', type='csv', accept_multiple_files=False
)

if file is not None:
    df = pd.read_csv(file)
    st.write(df)
    
    with open(file.name, 'wb') as out:
        out.write(file.getbuffer())
