# 识别数字

当前版本的paddlepaddle(1.2.0)并没有对windows环境进行兼容考虑：

https://github.com/PaddlePaddle/Paddle/issues/14810

而自己常用的系统又是windows系统（不想开虚拟机也不想装双系统了），并且官方也把整个[PaddlePaddle/book](https://github.com/PaddlePaddle/book)都打包成了一个Docker Image（Jupyter），所以在这种情况下使用docker来跑这个实例就是不二之选了。



##### 第一步 安装docker

Follow [this installation guide](https://www.docker.com/docker-windows). 

##### 第二步 编写Dockerfile文件

如下：

```dockerfile
FROM python:2.7.15
COPY . /home
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /home/requirements.txt
WORKDIR /home
CMD python train.py
```

##### 第三步 创建image文件

```bash
$ docker image build -t recognize-digits .
$ docker image ls		# 查看image文件是否创建成功
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
recognize-digits    latest              bef813abb539        3 minutes ago       1.59GB
hello-world         latest              fce289e99eb9        6 days ago          1.84kB
python              2.7.15              9fefcc70da26        9 days ago          911MB
paddlepaddle/book   latest              3bff7c9264ed        3 weeks ago         2.43GB
```

##### 第四步 生成容器

```bash
$ docker run -d recognize-digits
$ docker ps -a		# 查看新生成的容器的状态
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                         PORTS                    NAMES
826eabfa3c2f        recognize-digits    "/bin/sh -c 'python …"   4 seconds ago       Up 3 seconds                   0.0.0.0:8000->3000/tcp   reverent_dhawan
f97f65d298a8        paddlepaddle/book   "sh -c 'jupyter note…"   About an hour ago   Exited (255) 14 minutes ago    0.0.0.0:8888->8888/tcp   elastic_herschel
27656081808f        hello-world         "/hello"                 About an hour ago   Exited (0) About an hour ago                            goofy_hoover
```

##### 第五步 查看容器日志

```bash
$ docker logs 826eabfa3c2f
[==================================================]mages-idx3-ubyte.gz not found, downloading http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz
[==================================================]abels-idx1-ubyte.gz not found, downloading http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
[==================================================]ages-idx3-ubyte.gz not found, downloading http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz
[==================================================]bels-idx1-ubyte.gz not found, downloading http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz
```

**a few minutes later...**

```bash
Pass 0, Batch 0, Cost 5.344898
Pass 100, Batch 0, Cost 0.270623
Pass 200, Batch 0, Cost 0.129992
Pass 300, Batch 0, Cost 0.118527
Pass 400, Batch 0, Cost 0.084610
Pass 500, Batch 0, Cost 0.093719
Pass 600, Batch 0, Cost 0.108065
Pass 700, Batch 0, Cost 0.134715
Pass 800, Batch 0, Cost 0.012101
Pass 900, Batch 0, Cost 0.100961
Test with Epoch 0, avg_cost: 0.08841084426364959, acc: 0.9710390127388535
Pass 1000, Batch 1, Cost 0.093905
Pass 1100, Batch 1, Cost 0.038473
Pass 1200, Batch 1, Cost 0.041242
Pass 1300, Batch 1, Cost 0.035336
Pass 1400, Batch 1, Cost 0.025592
Pass 1500, Batch 1, Cost 0.006698
Pass 1600, Batch 1, Cost 0.105985
Pass 1700, Batch 1, Cost 0.016417
Pass 1800, Batch 1, Cost 0.008797
Test with Epoch 1, avg_cost: 0.05355227823542484, acc: 0.981687898089172
Pass 1900, Batch 2, Cost 0.007854
Pass 2000, Batch 2, Cost 0.002585
Pass 2100, Batch 2, Cost 0.013714
Pass 2200, Batch 2, Cost 0.211413
Pass 2300, Batch 2, Cost 0.006883
Pass 2400, Batch 2, Cost 0.020424
Pass 2500, Batch 2, Cost 0.096412
Pass 2600, Batch 2, Cost 0.022557
Pass 2700, Batch 2, Cost 0.068188
Pass 2800, Batch 2, Cost 0.013070
Test with Epoch 2, avg_cost: 0.05954405813039337, acc: 0.9815883757961783
Pass 2900, Batch 3, Cost 0.022137
Pass 3000, Batch 3, Cost 0.011575
Pass 3100, Batch 3, Cost 0.001318
Pass 3200, Batch 3, Cost 0.093258
Pass 3300, Batch 3, Cost 0.030800
Pass 3400, Batch 3, Cost 0.077208
Pass 3500, Batch 3, Cost 0.014217
Pass 3600, Batch 3, Cost 0.024892
Pass 3700, Batch 3, Cost 0.002944
Test with Epoch 3, avg_cost: 0.049097538875847335, acc: 0.9850716560509554
Pass 3800, Batch 4, Cost 0.003956
Pass 3900, Batch 4, Cost 0.007303
Pass 4000, Batch 4, Cost 0.059122
Pass 4100, Batch 4, Cost 0.037062
Pass 4200, Batch 4, Cost 0.008496
Pass 4300, Batch 4, Cost 0.122404
Pass 4400, Batch 4, Cost 0.037478
Pass 4500, Batch 4, Cost 0.035312
Pass 4600, Batch 4, Cost 0.008519
Test with Epoch 4, avg_cost: 0.04486150038118826, acc: 0.9880573248407644
Best pass is 4, testing Avgcost is 0.04486150038118826
The classification accuracy is 98.81%
Inference result of image/infer_3.png is: 3
```

