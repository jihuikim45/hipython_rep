import streamlit as st


st.title('스트림릿')
st.write('Hello, streamlit !!!!!')

st.divider()

name = st.text_input('이름 :')
if name : 
    st.write(f"반가워요☺️{name}님")
    
import pandas as pd

df = pd.read_csv('data1/ABNB_stock.csv')    
print(df)
df