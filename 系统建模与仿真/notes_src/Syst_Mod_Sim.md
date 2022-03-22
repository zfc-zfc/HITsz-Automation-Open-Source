# 系统建模与仿真

[TOC]



---



## 绪论

### 系统

-   “具有特定功能，按照某种规律结合起来，互相作用、互相依存的所有物体的总和或集合” ——钱学森

### 系统模型

-   某系统 物理的、数学的、或其他逻辑的表现形式

### 系统三要素
- 实体
    - 具有确定意义的物体
- 属性
    - 有效特征  
- 活动

### 系统分类
- 自然属性
    - 人造、自然
- 物质～
	- 实物系统、概念系统
- 运动～
	- 静态
		- 代数方程描述，如系统稳态解（Riccatti, Lyapnouv）
	- 动态（人体、控制、经济、动力学）
		- 连续模型
			- 集中参数：微分方程、传递函数、状态方程
			- 分布参数：偏微分方程
		- 离散模型
			- 离散时间：差分方程、Z变换、离散状态方程
			- 离散事件：排队论、马尔可夫过程
		- 混合



### 研究方法

#### 理论分析（解析）法

#### 实验法

+ 给定输入，测取输出

-   难以实现：
    1.  控制系统设计：实际系统尚未建立
    2.  不允许实验
    3.  费用、危险性、周期

#### 仿真实验法

-   相似原理



### 建模原则

- 可分离原则
	- 忽略绝大部分联系
- 假设合理性原则
- 因果性原则
	- 输入输出满足函数映射关系

### 建模步骤

```flow
prep=>start: 准备
know=>operation: 认识
mod=>operation: 建模
solve=>operation: 求解
analyze=>condition: 分析、检验
use=>end: 使用

prep->know->mod->solve->analyze
analyze(yes)->use
analyze(no)->know
```




#### 模型建立

``` mermaid
graph TB
a["结构、约束条件"]-->b[测取模型数据]
b-->c[运用适当理论建立系统的数学描述]
c-->d[检验数学模型准确性]
```

### 仿真

-   模仿真实事物；用人造系统模仿真实或设想的系统行为，并对其进行研究

### 系统仿真理论依据

#### 相似性原理

1.  几何相似
2.  环境相似
3.  性能相似
    -   数学相似
4.  思维相似
    -   专家系统、神经网络
5.  生理相似



### 仿真分类

1.  数字仿真
    -   三要素：实际系统、数学模型、计算机
    -   基本活动：模型建立、仿真实验、结果分析
2.  混合仿真
    -   与实物相连实时仿真
3.  分布式仿真



---



##MATLAB 简介

### 组成部分

-   开发环境
-   MATLAB数学函数库
-   M语言
-   句柄图形
-   程序接口



---



## 系统建模与分析

### 连续控制系统的数学模型

1.  微分方程

    -   $a_0y^{(n)}+a_1y^{(n-1)}+\cdots+a_{n-1}y^\prime+a_ny=b_0u^{(m)}+\cdots+b_mu$  
    -   通常 $m\leq n$  

2.  状态方程
    $$
    \begin{cases}
    \boldsymbol{\dot{x}}(t)&=\boldsymbol{Ax}(t)+\boldsymbol{Bu}(t)\\
    \boldsymbol{y}(t)&=\boldsymbol{Cx}(t)+\boldsymbol{Du}(t)
    \end{cases}
    $$

    -   简记为$(\boldsymbol{A,B,C,D})$ 形式

3.  传递函数

    -   $num=\vec{b}$

    -   $den=\vec{a}$

    -   简记为$(num, den)$形式 

4.  零极点增益
    $$
    G(s)=K\frac{\prod\limits_{i=1}^m(s-z_i)}{\prod\limits_{j=1}^n (s-p_j)} 
    $$
    

    -   简记为$(\vec{z},\vec{p},K)$ 形式

5.  部分分式

    -   $G(s)=\sum\limits_{i=1}^n \dfrac{r_i}{s-p_i}+h(s)$  
    -   留数 $\vec{r}$：n维；
    -   极点 $\vec{p}$：n维；
    -   余式 $\vec{h}$：$l=m-n\geq0$ 维  
    -   简记为$(\vec{r},\vec{p},\vec{h})$  

-   各种形式转换（MATLAB）
    -   传函、零极点：
    
        -   ```matlab
            [z,p,K] = tf2zp(num, den)
            ```
    
            ```matlab
            [num, den] = zp2tf(z, p, k)  
            ```
    
            
    
    -   状态方程、传函：ss2tf()、tf2ss()
    
        ```matlab
        [num, den] = ss2tf(A,B,C,D)
        ```
    
        ```matlab
        [A,B,C,D] = tf2ss(num, den)
        ```
    
    -   状态方程、零极点：ss2zp(), zp2ss:
    
        -   格式相仿
    
    -   传函、部分分式
    
        ```matlab
        [r, p, h] = residue(num, den)
        ```
    
        ```matlab
        [num, den] = residue(r, p, h)
        ```

    
    
-   微分方程$\Rightarrow$ 状态方程
  
    -   定义：
$$
{\boldsymbol x}=
\begin{bmatrix}
	y\\y'\\y''\\ \vdots \\y^{(n-1)}\\
\end{bmatrix}
$$

$$
\dot{\boldsymbol x}=
\begin{bmatrix}
	0 & 1 & 0 &\cdots & 0\\
	0 & 0 & 1 &\cdots & 0\\
	\vdots&\vdots&\vdots&\ddots&\vdots\\
	0 & 0 & 0 &\cdots & 1\\
	-\dfrac{a_n}{a_0}&-\dfrac{a_{n-1}}{a_0}&-\dfrac{a_{n-2}}{a_0}&\cdots&-\dfrac{a_1}{a_0}\\
\end{bmatrix}
\boldsymbol x + 
\begin{bmatrix}
	0 & 0 & 0 &\cdots & 0\\
	0 & 0 & 0 &\cdots & 0\\
	\vdots&\vdots&\vdots&\ddots&\vdots\\
	0 & 0 & 0 &\cdots & 0\\
	\dfrac{b_m}{a_0}&\dfrac{b_{m-1}}{a_0}&\dfrac{b_{m-2}}{a_0}&\cdots&\dfrac{b_0}{a_0}\\
\end{bmatrix}
\begin{bmatrix}
	u\\u'\\u''\\ \vdots \\u^{(m)}\\
\end{bmatrix}
$$
​						记作
$$
          \dot{\boldsymbol x}=\boldsymbol{Ax}+\boldsymbol{Bu}
$$



### 建模三要素

1.  目的
    -   目的明确
2.  方法
    -   得当
    -   逻辑方法
        -   抽象、归纳、推演、类比、移植
    -   建模方法
        -   机理
        -   实验
        -   综合
3.  验证



### 建模方法

1.  机理建模法
  
    -   通过理论分析推导建立模型
2.  实验建模法
    1.  频率特性法
      
        -   不同频率的正弦输入
        
    2.  系统辨识法
      
        -   详见下章
        
        -   三要素：数据、假设模型、准则
        -   数据的平滑处理
            -   三次样条插值：导数连续
        -   统计处理：最小二乘法：使用n次（选定值）逼近  
        
    3.  响应曲线法
    
        -   详见下章
3.  综合建模法
  
    -   对内部结构特性有部分了解，但难以完全用机理模型的方法表述，需要结合一定的实验方法确定结构特性，或通过实际测定来求取模型参数。



### 模型验证

#### 验证内容

1.  验证模型是否准确描述实际系统的性能和行为
2.  检验仿真实验结果与实际系统的近似程度

#### 注意

1.  模型验证是一个过程
2.  模糊性
3.  全面验证往往不可能或难以实现

#### 基本方法

1.  基于机理建模的必要条件法
2.  基于实验建模的数理统计法
3.  实物模型验证法



### 实例

1.  一阶直线倒立摆
    -   单一刚性铰链、两自由度
2.  龙门吊
    -   多刚体、多自由度、多约束质点系
    -   Lagrange 力学
    -   广义力
3.  水箱液位控制
4.  烧煤热水锅炉







---



## 经典系统辨识

### 辨识的基本概念

#### 定义

-   按照一个准则在一组模型类中选择一个与数据拟合得最好的模型

#### 三要素

-   数据
    -   输入、输出，含有噪声
-   模型类
-   准则
    -   代价函数（误差准则）

#### 误差准则

-   **本课程**取输出误差
    $$
    \varepsilon(k)=y(k)-\hat y(k) \\
    $$

-   代价函数取误差平方
    $$
    J(\theta)=\sum_{k=1}^N f(\varepsilon(k))=\sum_{k=1}^N \varepsilon^2(k)
    $$

#### 经典辨识

-   正弦输入——频率响应——传递函数
-   阶跃输入——阶跃响应——传递函数
-   脉冲输入——脉冲响应——传递函数



### 随机过程

#### 数字特征

-   期望
    $$
    \mu_x(t) \triangleq E\left( x(t) \right) = \int_{-\infty}^\infty x p_x(t)\ \mathrm dx
    $$
    
-   方差
    $$
    \sigma^2_x(t) \triangleq E\{ [x(t)-\mu_x(t)]^2 \} = \int_{-\infty}^\infty [x(t)-\mu_x(t)]^2 p_x(t)\ \mathrm dx
    $$
    
-   自相关函数 

    $$
    R_x(t_1,t_2) \triangleq E \left( x(t_1)x(t_2) \right) = \int_{-\infty}^\infty\int_{-\infty}^\infty x_1 x_2 p_{xx}(t_1,t_2)\ \mathrm dx_1\mathrm dx_2
    $$

-   互相关函数
    $$
    R_{xy}(\tau) \triangleq E[x(t)y(t+\tau)] 
    $$

-   协方差

#### 平稳随机过程

-   Definition: 一个 **<u>统计性质不随时间改变</u>** 的随机过程
    -   $\forall t,\  \mu_x(t)=\mu_x$ 
    -   $R_x(t_1,t_2)=R_x(t_3,t_4)=R_x(\tau)$， 其中 $t_2-t_1=t_3-t_4=\tau$ ，只与时间差有关  
-   各态遍历性
    -   时间平均值(第 $i$ 次测 $2T$ 时间) = 集合平均值($t$ 时刻测 $n$ 次)  
    -   $\mu_x=\overline x = \lim\limits_{T\rightarrow\infty}\dfrac{1}{2T}\displaystyle\int_{-T}^Tx_i(t)\mathrm dt$，其中 $i$ 任取  
    -   $R_x(\tau)=\overline{x(t)x(t+\tau)}$  

#### 白噪声

-   白噪声过程是由一系列==不相关==的随机变量组成的一种理想化随机过程  

-   白噪声过程无记忆性

-   数学描述：
    -   $\mu_w=E[w(t)]=0$  
    -   $R_w(\tau)=E[w(t)w(t+\tau)]=\sigma^2\delta(\tau)$，即 $\forall t_i≠t_j$ $R_w=0$ 不相关$\Rightarrow$ 任意两时刻取值互不相关  
    
-   平均功率谱密度：
  
    -   $S_w(\omega)=\mathscr F [R_w(\tau)] = \sigma^2$  ：功率在全频段内均匀分布  

##### 离散白噪声（～序列）

-   数学描述：
    -   随机序列$\{w(k)\}$ 两两不相关
    -   $R_w(k)=\sigma^2 \delta_k,\ k=0,\pm1,\pm2,\cdots$  
    -   $S_w(\omega)=\sum\limits_{k=-\infty}^{\infty}R_w(k)e^{-j\omega k}=\sigma^2$  
-   随机数！

##### 均匀分布随机数产生方法

-   乘同余法产生(0, 1)之间的均匀分布的**伪随机数序列** {$\xi_i$} 
    -   $x_i=Ax_{i-1}\ mod\ M$  
    -   $\xi_i = \dfrac{x_i}{M}$  
    -   其中
        -   $M=2^k, k>2$  
        -    $x_0$ 取正奇数  
        -   {$\xi_i$} 的周期为$2^{k-2}$  

##### 正态分布随机数产生

-   基于统计近似抽样法

-   设{$\xi_i$ } 是(0,1)均匀分布的随机数序列
-   由中心极限定理： $x=\dfrac{\sum\limits_{i=1}^{n}\xi_i -n\mu_\xi }{\sqrt{n\sigma_\xi^2}} = \dfrac{\sum\limits_{i=1}^{n}\xi_i -\dfrac{n}{2}}{\sqrt{n/12}} \sim N(0,1) $  
-   $\eta = \mu_\eta+\sigma_\eta\dfrac{\sum\limits_{i=1}^{n}\xi_i -\dfrac{n}{2}}{\sqrt{n/12}} \sim N(\mu_\eta, \sigma^2_\eta) $   
-   ***Remark*** :
    -   注意到：每生成一个高斯随机数$\eta$ ，都需要一个**不同**的均匀随机序列{ $\xi_i$ }
    -   实际编程实现中大致有两种实现方案：设总共需要$N$个高斯随机数
        1.  一次性生成一个长度为$Nk$ 的均匀随机序列{$\xi_i $}，从中依次取$k$项生成$\eta$ 
        2.  设计一依赖于种子的均匀随机序列生成函数，每需要一个均匀随机序列时，提供一个**唯一**的种子$seed(i),\ \forall i=1,\cdots,N$  

##### M序列

-   一种PRBS（Pseudo Random Binary Sequences）

-   由移位寄存器产生  
-   $a_n=\sum\limits_{i=1}^r \oplus c_ia_{n-i} $ ，其中$c_i=\begin{cases}0 \\ 1 \end{cases}$ 
-   r级寄存器产生的序列最长周期：$2^r-1$  

-   各寄存器初始状态**不能全零**！



### 相关法求取系统脉冲响应

-   线性系统卷积定理：（传递函数作Laplace逆变换）
-   $$
    y(t)=\int_0^\infty{g(\sigma)x(t-\sigma)\ \mathrm d\sigma}
    $$
    
-   维纳-霍夫方程：
    $$
    R_{xy}(\tau)=\int_0^\infty g(\sigma)R_x(\tau-\sigma)\mathrm d\sigma \newline
    \tau = t_1-t_2
    $$



#### 用M序列辨识线性系统的脉冲响应

##### M序列自相关函数

- 连续：略

- 离散：
  $$
  R_M(\tau)=
  \begin{cases}
  \begin{aligned}
    &a^2 &,\tau=0 \\
    -&\dfrac{a^2}{N_p} &,0<\tau < N_p-1 \\
  \end{aligned}
  \end{cases}
  $$
  
- 维纳霍夫方程：

  $$
  R_{xy}(\tau) = \int_0^\infty g(\sigma)R_x (\tau-\sigma)\mathrm d\sigma
  $$

  $$
  R_{xy}(\tau)=R_{xy}(\mu\Delta)=\sum_{k=0}^{N_p-1} g(k\Delta)   R_x(\mu\Delta-k\Delta) \cdot \Delta \newline
  \mu = 0, 1, \cdots, N_p-1.
  $$
  
  写成矩阵形式：

    $$
       \boldsymbol R_{xy}=\boldsymbol{Rg}\Delta
    $$

    $$
    \boldsymbol g=
    \begin{bmatrix}
    g(0)\\
    \vdots\\
    g(N_p-1) \\
    \end{bmatrix}
    $$

  $$
  \boldsymbol R_{xy}= 
    \begin{bmatrix}
    R_{xy}(0)\\
    \vdots\\
    R_{xy}(N_p-1)\\
    \end{bmatrix}
  $$

  $$
  \boldsymbol R= 
    \begin{bmatrix}
    R_x(0) & R_x(-1) & \cdots & R_x(-N_p+1) \\
    R_x(1) & R_x(0) & \cdots & R_x(-N_p+2) \\
    \vdots & \vdots & \ddots & \vdots \\
    R_x(N_p-1) & R_x(N_p-2) & \cdots & R_x(0)
    \end{bmatrix}
  $$


  故
$$
    g = \frac{1}{\Delta}R^{-1}R_{xy}
$$

  通过推导可以证明

$$
    \boldsymbol g=\frac{1}{a^2r(N_p+1)\Delta}
    \begin{bmatrix}
    2&1&\cdots&1 \\
    1&2&\cdots&1 \\
    \vdots & \vdots & \ddots & \vdots \\
    1&1&\cdots&2\\
    \end{bmatrix}
    \begin{bmatrix}
    x(0) & x(1) & \cdots & x(rN_p-1) \\
    x(-1) & x(0) & \cdots & x(rN_p-2) \\
    \vdots & \vdots & \ddots & \vdots \\
    x(-N_p+1) & x(-N_p+2) & \cdots & x(rN_p-N_p) \\
    \end{bmatrix}
    \begin{bmatrix}
    y(0)\\
    y(1)\\
    \vdots \\
    y(rN_p-1)
    \end{bmatrix}
$$





### 脉冲响应求传递函数

-   属了解内容
-   实际效果较差



### 响应曲线法求解系统阶跃响应

#### 输入阶跃信号

-   $G(s)=\dfrac{K}{Ts+1}$  
-   $K=\dfrac{y(\infty)-y(0)}{x_0}$  
-   $T=\dfrac{y(\infty)-y(0)}{\dot y(0)}$  

-   注意事项：
    -   阶跃信号要适中：正常输入信号的5%～15%  
    -   输入阶跃信号前，对象必须处于平衡工况  



#### 由矩形脉冲响应求阶跃响应

-   输入矩形脉冲：$x(t)=u(t)-u(t-a)$  

-   对于线性系统：
    $$
    \begin{cases}
    	y^*(t)=y(t)-y(t-a)\\
    	即\ y(t)=y^*(t)+y(t-a)
    \end{cases}
    $$
    $y^*(t)$ ——矩形脉冲响应

    $y(t)$ ——正阶跃响应

    $y(t-a)$ ——负阶跃响应  

-   构造：

    1.  $y(a)=y^*(a)=y_1$  

    2.  $y(2a)=y^*(2a)+y(2a-a)=y^*_2+y_1=y_2$  

    3.  $y(3a)=y^*(3a)+y(3a-a)=y^*_3+y_2=y_3$ 

        $\cdots\cdots$

    4.  $y(na)=y^*(na)+y\left[(n-1)a\right]=y^*_n+y_{n-1}=y_n$  

    5.  拟合 $y_{i}$ 得阶跃响应



---



## 最小二乘辨识LSI

### 基础

- 辨识SISO系统差分方程系数
  $$
  x(k)+a_1x(k-1)+\cdots+a_nx(k-n)=b_0u(k)+\cdots+b_mu(k-m)
  $$



#### 推导

- 设共有$(n+N)$ 组观测数据：
  $$
  \begin{bmatrix}
  y(n+1)\\
  \vdots\\
  y(n+N)\\
  \end{bmatrix} = 
  \begin{bmatrix}
  -y(n) & \cdots & -y(1) & u(n+1) & \cdots & u(n+1-m)  \\
  -y(n+1) & \cdots & -y(2) & u(n+2) & \cdots & u(n+2-m)  \\
  \vdots & \cdots & \vdots & \vdots & \cdots & \vdots\\
  -y(n+N-1) & \cdots & -y(N) & u(n+N) & \cdots & u(n+N-m)  \\
  \end{bmatrix}
  \begin{bmatrix}
  a_1\\
  \vdots\\
  a_n\\
  b_0\\
  \vdots\\
  b_m\\
  \end{bmatrix}
  +
  \boldsymbol \xi_{N\times1}
  $$

  写成矩阵

  $$
    Y_{N\times 1} = \varPhi_{N\times(n+m+1)} \theta_{(n+m+1)\times1} + \xi
  $$



- 指标函数：

    $$J = \sum\limits_{k=n+1}^{n+N}e^2(k) = ee^T = (Y-\varPhi\hat\theta)^T(Y-\varPhi\hat\theta) = Y^TY-\hat\theta^T\varPhi^TY-Y^T\varPhi\hat\theta +\hat\theta^T\varPhi^T\varPhi\hat\theta 
    $$
    
    -  $\hat\theta = \min\limits_\theta J$ 
    -  $\dfrac{\partial J}{\partial \hat\theta} = -2\varPhi^T(Y-\varPhi\hat\theta) = 0$ 
    - 解得驻点：$\hat\theta = (\varPhi^T\varPhi)^{-1}\varPhi^TY$  
    - 判断极小值：$\varPhi^T\varPhi>0$ 即$\varPhi^T\varPhi$是正定阵  

#### 对输入信号的要求

1. M序列
   - 当长度$N_p$ 足够大时，可保证$\varPhi^T\varPhi$ 正定
   - 工程上常用
2. 随机序列
   - 白噪声序列满足满足要求

#### 性质

1. 无偏性

   - 充要条件：$E[(\varPhi^T\varPhi)^{-1} \varPhi^T \xi]=0$ 

   - 充分条件：噪声{$\xi(k)$}为零均值不相关随机序列，且与输入{$u(k)$}无关 

2. 一致性

   - 充分条件：同上

### 递推算法推导RLSI

$$
  \hat\theta = (\varPhi^T\varPhi)^{-1}\varPhi^TY
$$
-   记
    $$
        P_N=(\varPhi_N^T\varPhi_N)^{-1}
    $$

    则 $\hat\theta_N=P_N\varPhi_N^TY_N$  
    
    $$
    \varPsi_{N+1}=
    \begin{bmatrix}
    	-y(n+N) \\
    	\vdots \\
    	-y(N+1) \\
    	u(n+N+1) \\
    	\vdots \\
    	u(n+N+1-m)
    \end{bmatrix}_{(n+m+1)\times 1}
    $$
    
    $$
    y(n+N+1)=\varPsi_{N+1}^T \theta+\xi(n+N+1)
    $$

    $$
    \begin{aligned}
    \hat\theta_{N+1}&=\left(
    \begin{bmatrix}
    \varPhi_N\\
    \varPsi_{N+1}
    \end{bmatrix}^{T}
    \begin{bmatrix}
    \varPhi_N\\
    \varPsi_{N+1}
    \end{bmatrix}
    \right)^{-1}
    \begin{bmatrix}
    \varPhi_N\\
    \varPsi_{N+1}
    \end{bmatrix}^{T}
    \begin{bmatrix}
    Y_N\\
    y_{N+1}
    \end{bmatrix}\\
    &=\cdots\\
    &=P_{N+1} (\varPhi_N^TY_N+\varPsi_{N+1}^Ty_{N+1})\\
    \end{aligned}
    $$
    
    其中
    
    $$
    P_{N+1}=(P_N^{-1}+\varPsi_{N+1}\varPsi_{N+1}^T)^{-1}
    $$


-   求$P_{N+1}$ : 
    由矩阵求逆引理：
    $$
    (A+BC^T)^{-1} = A^{-1}-A^{-1}B(1+C^TA^{-1}B)^{-1}C^TA^{-1}
    $$
    可得
    $$
    P_{N+1} = P_N-P_N \varPsi_{N+1}(1+\varPsi_{N+1}^T P_N \varPsi_{N+1})^{-1} \varPsi_{N+1}^T P_N
    $$

-   经过复杂的推导...

-   ==递推公式== : $\varPsi$、$P$ 定义见上文
    $$
    \begin{cases}
    \begin{aligned}
    	\hat\theta_{N+1} &= \hat\theta_N + K_{N+1}[y(n+N+1)-\varPsi^T_{N+1} \hat\theta_N] \\
    	K_{N+1} &= P_N \varPsi_{N+1}(1+\varPsi^T_{N+1} P_N \varPsi_{N+1})^{-1} \\
    	P_{N+1} &= P_N - K_{N+1}\varPsi^T_{N+1} P_N \\
    \end{aligned}
    \end{cases}
    $$



-   初值获取方法：
    -   $\hat\theta_0=0$  
    -   $P_0=c^2I_{(n+m+1)\times(n+m+1)}$  其中 $c$ 为充分大常数 



## 极大似然辨识 MLI

#### 极大似然估计MLE

- 指标函数取对数似然函数
  $$
  \ln L(\theta)=\ln \left[ \prod_{i=1}^n Pr(x_i;\theta) \right]=\sum_{i=1}^n \ln Pr(x_i;\theta)
  $$
  
  或
  
  $$
  \ln L(\theta) = \sum_{i=1}^n \ln p(x_i; \theta)
  $$
  



##### 步骤

1. 导出联合概率分布函数$Pr(x;\theta)$ 或概率密度函数$p(x;\theta)$ 
2. 求得似然函数，以及对数似然函数
3. 求最大值点
4. 代入样本值得到极大似然估计值$\hat \theta$ 



#### 极大似然辨识

- 依旧定义
  $$
  Y=\varPhi\theta+\xi
  $$
  其中
  $$
  Y_{N\times1}=
  \begin{bmatrix}
  	y(n+1)\\
  	\vdots\\
  	y(n+N)\\
  \end{bmatrix}
  $$



##### 高斯白噪声情形

- 此时MLI与LSI等价
  $$
  \hat \theta_{\rm ML} = (\varPhi^T\varPhi)^{-1}\varPhi^TY
  $$

- 且噪声方差估计值
  $$
  \hat \sigma_{\rm ML}=\frac{1}{N} (Y-\varPhi\hat\theta_{\rm ML})^T (Y-\varPhi\hat\theta_{\rm ML})
  $$
  

##### 其他高斯噪声情形

-  数学模型：
    $$
      A(z^{-1})y(k)=B(z^{-1})u(k)+C(z^{-1})\varepsilon(k)\\
      A = 1+a_1 z^{-1}+\cdots +a_nz^{-n}\\
      B = b_0+b_1z^{-1}+\cdots+b_nz^{-n}\\
      C = 1+c_1z^{-1}+\cdots+c_nz^{-n}
    $$

    取似然函数：

    $$
      \ln L(\theta)=-\frac{N}{2}\ln2\pi - \frac{N}{2}\ln\sigma^2 - \frac{1}{2\sigma^2}\sum_{k=n+1}^{n+N} v^2(k)
    $$

    其中
    $$
      v(k) = y(k)+\sum_{i=1}^n\hat a_iy(k-i)-\sum_{i=0}^{n}\hat b_iu(k-i) - \sum_{i=1}^n c_i \varepsilon(k-i)
    $$
    令$\dfrac{\partial \ln L}{\partial\hat\sigma^2}=0$, 得
    $$
    \hat\sigma^2 = \frac{1}{N}\sum_{k=n+1}^{n+N}v^2(k)
    $$



- Newton-Raphson法



### 递推极大似然辨识 RMLI





## 连续系统离散化

### 基本要求

1.  稳定性
2.  准确性
    -   绝对误差准则
    -   相对误差准则
3.  快速性
    -   实时仿真 $t=\Delta T$ 
    -   超实时～$t<\Delta T$ 
    -   亚～——离线仿真



### 数值积分法

-  概述
    $$
    \begin{cases}
      \dot y &= f(t,y) \\
      y(t_0) &= y_0
      \end{cases}
    $$

    $$
    y_{k+1} = y_k + \int_{t_k}^{t_{k+1}} f(t,y)\ \mathrm dt
    $$

-   数值积分各种方法的不同就在于右端积分项的计算方法不同



#### Euler 法

-   矩形近似，一阶方法

-   单步法、自启动模式

-   
    $$
    \begin{aligned}
    Q_k &= \int_{t_k}^{t_{k+1}} f(t,y)\ \mathrm dt\\
    &= h\cdot f(t_k,y_k)
    \end{aligned}
    $$

-   数学解释：

    -   连续函数在$t=t_{k}$ 处Taylor展开，舍去二次及更高次项，即折线化
    
-  误差
    -  截断误差：$O(h^2)$ 
    -   累计截断误差：$O(h)$ 



#### 梯形法

-   梯形近似
    $$
    Q_k=\frac{1}{2}h[f(t_k,y_k)+f(t_{k+1},y_{k+1})]
    $$

-   注意到$y_{k+1}$ 未知，故该法需要迭代计算

    -   考虑使用Euler法构成 预估-校正法
        $$
        \begin{cases}
        y^0_{k+1} &= y_k+hf(t_k,y_k)\\
        y_{k+1} &= y_k + \dfrac{1}{2}h\left[f(t_k,y_k)+f(t_{k+1},y_{k+1})\right]
        \end{cases}
        $$

-   截断误差：$O(h^3)$ 



#### Runge-Kutta

-   单步法
-   可变步长

##### RK2

-   二阶
    $$
    \begin{cases}
    y_{k+1} &= y_k+\dfrac{1}{2}(K_1+K_2) \\
    K_1 &= f(t_k,y_k) \\
    K_2 &= f(t_k+h, y_k+K_1h)
    \end{cases}
    $$

-   截断误差：$O(h^3)$ 

##### RK4

-   四阶
    $$
    \begin{cases}
    \begin{aligned}
    	y_{k+1} &= y_k+\frac{h}{6}(K_1+2K_2+2K_3+K_4)\\
    	K_1 &= f(t_k,y_k)\\
    	K_2 &= f\left(t_k+\frac{h}{2}, y_k+\frac{h}{2}K_1 \right) \\
    	K_3 &= f\left(t_k+\frac{h}{2}, y_k+\frac{h}{2}K_2 \right) \\
    	K_4 &= f(t_k+h,y_k+hK_3) \\
    \end{aligned}
    \end{cases}
    $$

-   截断误差：$O(h^5)$ 



##### RK法的误差估计与步长控制

-   类似反馈控制

1.  误差估计
  
    -   找一个低阶的RK直接作差作为误差估计
2.  步长控制——加倍-减半法：
    -   定义局部误差：
      
        $$
        e_k = \frac{E_k}{|y_k|+1}
        $$
        
        当$y_k$ 较大时为相对误差，较小时为绝度误差
        
        
        
    -   设定误差上限与下限，并根据以下规则更新步长
      
        $$
        h_{k+1}=
        \begin{cases}
        	\dfrac{1}{2}h_k &, e_k \ge \varepsilon_{\rm max} \\
        	h_k &, e_k \in (\varepsilon_{\rm min},\varepsilon_{\rm max}) \\
        	2h_k &, e_k\le \varepsilon_{\rm min}
        \end{cases}
        $$



### 线性多步法

-   利用以前时刻数据预报函数值与导数值

-   推导得
    $$
    V=
    \begin{bmatrix}
    1 & 1 & 1 & 1 &\cdots & 1 \\
    1 & 2 & 2^2 & 2^3 &\cdots & 2^{2k-1} \\
    1 & 3 & 3^2 & 3^3 &\cdots & 3^{2k-1} \\
    \vdots &&& \vdots&&\vdots \\
    1 & k & k^2 & k^3 &\cdots & k^{2k-1} \\
    0 & 1 & 2 & 3 &\cdots & 2k-1 \\
    0 & 1 & 2\times2 & 3\times2^2 &\cdots & (2k-1)\times2^{2k-2} \\
    0 & 1 & 2\times3 & 3\times3^2 &\cdots & (2k-1)\times3^{2k-2} \\
    \vdots &&& \vdots&&\vdots \\
    0 & 1 & 2\times k & 3\times k^2 &\cdots & (2k-1)\times k^{2k-2} \\
    \end{bmatrix}
    $$
    设辅助变量（取$V^{-1}$ 的第一行）
    $$
    \varPhi^T=
    \begin{bmatrix}
    1&0&\cdots&0
    \end{bmatrix}
    V^{-1} \\
    $$

   得预报值：
   $$
   y_{n+k}=\varPhi^T
   \begin{bmatrix}
   y_{n+k-1}\\
   \vdots\\
   y_n\\
   -h\dot y_{n+k-1}\\
   \vdots\\
   -h\dot y_{n}\\
   \end{bmatrix}
   $$
   
   
   



