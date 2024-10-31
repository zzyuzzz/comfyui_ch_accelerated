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

cd $cdir/ComfyUI/custom
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
git clone https://github.com/XLabs-AI/x-flux-comfyui.git
git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git


pwd