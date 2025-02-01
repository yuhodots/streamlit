import streamlit as st
from PIL import Image
import torch
import torchvision.transforms as transforms

st.title("Image Upscaler")

uploaded_file = st.file_uploader("Choose an image...", type=["jpg", "jpeg", "png"])

if uploaded_file is not None:
    image = Image.open(uploaded_file)
    st.image(image, caption="Original Image")
    
    if st.button("Upscale Image"):
        # 여기에 실제 upscaling 로직을 구현하세요
        # 예시로는 단순 리사이즈를 사용합니다
        upscaled_image = image.resize((image.width * 4, image.height * 4), Image.Resampling.LANCZOS)
        st.image(upscaled_image, caption="Upscaled Image") 
