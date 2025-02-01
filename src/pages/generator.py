import streamlit as st
import requests
from PIL import Image
import io

st.title("Text to Image Generator")

prompt = st.text_input("Enter your prompt:")
if st.button("Generate Image"):
    # Flux API 엔드포인트 설정
    # API_URL = "your-flux-api-endpoint"
    
    # payload = {
    #     "prompt": prompt,
    #     "parameters": {...}
    # }
    
    # response = requests.post(API_URL, json=payload)
    # if response.status_code == 200:
    #     image = Image.open(io.BytesIO(response.content))
    #     st.image(image, caption="Generated Image")
    st.write("Image generation will be implemented here") 
