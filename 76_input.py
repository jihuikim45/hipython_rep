import streamlit as st

st.title('Titile')
st.header('header')
st.subheader('subheader')

st.write('write 문장이에요.') #p
st.text('text 문장이에요.')
st.markdown(
    '''
    여기는 메인 텍스트예요.
    :red[Red], :blue[Blue], :green[Green.]    
    \n**Bold**도 되고요, *Italic*도 됩니다.
    \n줄바꿈도 됩니다.
    '''
)

st.code(
    '''
    st.title('Titile')
    st.header('header')
    st.subheader('subheader')
    ''',
    language='python'
)

st.divider()

st.button('button') #secondary type
st.button('Send', type='primary', icon="📮", disabled=True, key=1)
st.button('Like', type='primary', icon="🤍") 


st.divider()

############################################# button click

st.button('Reset', type='primary')


def button_write():
    st.write('버튼이 클릭되었어요.')
st.button('activate', on_click=button_write)


clicked = st.button('acrivate2', type='primary')
if clicked:
    st.write('버튼2가 클릭되었어요.')
    
    

st.divider()

############################################# button click

st.header('같은 버튼 여러개 만들기')

#key= st.button
#activate button 5개 primary로


for i in range(1, 6):
    if st.button('activate', type='primary', key=f'act_btn_{i}'):
        st.write(f"{i}번 버튼이 클릭되었어요!")


