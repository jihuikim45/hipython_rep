import streamlit as st

#layout 요소
#columns 는 요소를 왼쪽 -> 오른쪽으로 배치 가능

col1, col2, col3 = st.columns(3)

with col1:
    st.metric(
        '오늘의 날씨',
        value='35도',
        delta='+3'
    )

with col2:
    st.metric(
        '공기질',
        value='좋음',
        delta='-30',
        delta_color='inverse'
        
    )
    
    
with col3:
    st.metric(
        '습도',
        value='66%'
    )
    
    
##
st.markdown('---')

data = {
    '이름' : ['수지', '김혜수', '송혜교'],
    '나이' : [32, 52, 42]
}

import pandas as pd

df = pd.DataFrame(data)
st.dataframe(df)


st.divider()

st.table(df)

st.divider()

st.json(data)

st.divider()


