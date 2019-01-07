FROM python:2.7.15
COPY . /home
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /home/requirements.txt
WORKDIR /home
CMD python train.py