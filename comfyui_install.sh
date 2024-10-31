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

cd $cdir/ComfyUI/

# python main.py

pwd