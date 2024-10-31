echo "installing..."

cdir=$(pwd)

python -m pip install --upgrade pip -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

git config --global url."https://gh.llkk.cc/".insteadOf https://
git config --global -l
export HF_ENDPOINT=https://hf-mirror.com

if [ ! -d "$cdir/ComfyUI" ];then 
    echo "ComfyUI doesn't exist! downloading..."
    git clone https://github.com/comfyanonymous/ComfyUI.git
else
    echo "$cdir/ComfyUI existed!"
fi

pip install -r $cdir/ComfyUI/requirements.txt -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

cd $cdir/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone --recursive https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
git clone https://github.com/XLabs-AI/x-flux-comfyui.git
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
git clone https://github.com/city96/ComfyUI-GGUF.git

cd $cdir/ComfyUI/custom_nodes/ComfyUI-Impact-Pack/
git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack impact_subpack
# python install-manual.py
cd $cdir

pip install -r $cdir/ComfyUI/custom_nodes/ComfyUI-Impact-Pack/requirements.txt
pip install -r $cdir/ComfyUI/custom_nodes/ComfyUI-GGUF/requirements.txt

cd $cdir/ComfyUI/models/unet
wget -c https://hf-mirror.com/city96/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q2_K.gguf?download=true -O flux1-dev-Q2_K.gguf &

cd $cdir/ComfyUI/models/clip
wget -c https://hf-mirror.com/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors?download=true -O clip_l.safetensors &
wget -c https://hf-mirror.com/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors?download=true -O t5xxl_fp8_e4m3fn.safetensors &

cd $cdir/ComfyUI/models/vae
wget -c https://hf-mirror.com/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors?download=true -O ae.safetensors &

cd $cdir/ComfyUI/models/clip_vision
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors -O CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors &
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/sdxl_models/image_encoder/model.safetensors -O CLIP-ViT-bigG-14-laion2B-39B-b160k.safetensors &
wget -c https://hf-mirror.com/Kwai-Kolors/Kolors-IP-Adapter-Plus/resolve/main/image_encoder/pytorch_model.bin -O clip-vit-large-patch14-336.bin &

if [ ! -d "$cdir/ComfyUI/models/ipadapter" ];then 
    mkdir $cdir/ComfyUI/models/ipadapter
else
    echo "$cdir/ComfyUI/models/ipadapter existed!"
fi
cd $cdir/ComfyUI/models/ipadapter
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors &
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors &
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors &
wget -c https://hf-mirror.com/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.safetensors &

wait
# cd $cdir/ComfyUI/
# python main.py

pwd