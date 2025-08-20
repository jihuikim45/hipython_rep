#datafile.csv > load > table 출력 > px.box() > st.plotly_chart()

import streamlit as st
import pandas as pd
import plotly.express as px


ev_df = pd.read_csv('data1/EV_charge.csv')
st.write(ev_df)


columns = ev_df.columns.tolist()

x_option = st.selectbox("X축 선택", columns, index=0)
y_option = st.selectbox("Y축 선택", columns, index=1)
hue_option = st.selectbox("색상 구분(hue)", [None] + columns, index=0)


if (x_option is not None) and (y_option is not None):
    if hue_option is not None:
        fig = px.box(
            data_frame=ev_df,
            x=x_option,
            y=y_option,
            color=hue_option,
            width=700,
            points="all"
        )
    else:
        fig = px.box(
            data_frame=ev_df,
            x=x_option,
            y=y_option,
            width=700,
            points="all"
        )

    st.plotly_chart(fig)
