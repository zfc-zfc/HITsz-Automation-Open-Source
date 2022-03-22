# 信号分析与处理

[TOC]

## 绪论

### 信号描述

-   波形图
-   数学表达式

### 信号分类

#### 独立变量个数

-   一维（语音信号）
-   二维（黑白图）
-   三维（彩图）

#### 时间特性

-   确定性 vs 随机性
-   连续 vs 离散时间
-   连续（定义域连续）
    -   模拟（时间幅值均连续）
    
-   离散（定义域离散）
  
    -   抽样（时间离散）
    -   数字（时间幅值均离散）
    
-   周期 vs 非周期

    -   设$f(t)=\sum f_i(t)$ ，$\forall i,j\\ \exist k=T_i/T_j \in \mathbb Q$ $\Leftrightarrow$  $f(t)$ 是周期信号

#### 能量特点

-   能量(有限)信号：
    -   $E =\displaystyle\int_{-\infty}^\infty|f(t)|^2 \mathrm dt$ 
    -   $E<\infty$
-   功率(有限)信号：
    -   $P = \lim\limits_{T\rightarrow \infty} \dfrac{1}{T} \displaystyle\int_{-T/2}^{T/2}|f(t)|^2 \mathrm dt$   
    -   $P<\infty ,\ P\neq0$  
-   幅度有限的周期、随机信号均属于功率信号
-   一个信号**可能**既不是能量信号，也不是功率信号
-   一个信号<u>**不可能**</u>既是能量信号，又是功率信号



### 系统分类

-   对信号分析和处理方法的不同
-   模拟处理系统
-   数字处理系统

---

## 连续信号分析

### 时域描述

-	普通信号
	- 正弦信号
	- 指数信号
-	奇异信号
    -	脉冲
    -	阶跃
    -	冲激

#### 正弦

-   性质：
    -   同频率相加
    -   频率差==整数倍==（周期比为有理数倍）的信号相加，仍为周期函数

#### 指数信号

-   $s=\sigma+j\omega$  

-   讨论 $\sigma == 0 ?$，$\omega == 0?$  

-   欧拉公式：
    $$
    \begin{cases}
    \sin \omega t = \dfrac{1}{2}(e^{j\omega t}+e^{-j\omega t})\\
    \cos \omega t = \dfrac{1}{2j}(e^{j\omega t}-e^{-j\omega t})
    \end{cases}
    $$

#### 单位斜坡信号

-   $r(t)$  

#### 单位阶跃信号

-   $u(t)$  

#### 单位冲激信号

-   $\displaystyle\int_{-\infty}^\infty\delta(t)\mathrm dt = \int_{0^-}^{0^+}\delta(t)\mathrm dt = 1$

-   偶函数特性
-   筛选特性  
-   与阶跃的微、积分关系



### 时域运算

#### 基本运算

-   尺度变换
    -   幅度
    -   时间：改变信号基本特征（频率），频谱变化！
-   翻转：将信号以纵轴为中心进行对称映射, 令 $t=-t$ 
-   平移

#### 叠加、相乘（逐点）

#### 微、积分

-   <u>**单位冲激偶函数**</u>：$\delta’(t)=\dfrac{\rm d}{\mathrm dt} \delta(t)$  

    -   单位冲激偶函数是==奇函数== 

    -   筛选特性：分部积分证明

        $\int_{-\infty}^{\infty}x(t)\delta’(t-t_0)\mathrm dt = -x’(t_0)$   

#### 卷积

-   本质的一种解释
  
-   在信号的持续作用下，系统的响应
  
-   步骤:
    1.  变量替换
    2.  翻转：
    3.  平移
    4.  相乘
    5.  积分
    
-   性质

    -   交换律

    -   分配律

    -   结合律

    -   积分
        $$
        \int_{-\infty}^t [x_1(\tau)*x_2(\tau)]\ \mathrm d\tau = x_1(t) * \left[\int_{-\infty}^t x_2(\tau)\  \mathrm d\tau \right] = \left[\int_{-\infty}^t x_1(\tau) \ \mathrm d\tau \right] * x_2(t)
        $$
        
    -   微分
      $$
            \dfrac{\rm d}{\mathrm dt}[x_1(t)*x_2(t)] = x_1(t)*\dfrac{\rm d}{\mathrm dt}x_2(t) = \dfrac{\rm d}{\mathrm dt}x_1(t) * x_2(t)
      $$
      
    
-   任意信号与冲激信号的卷积
    -   $x(t)*\delta(t)=x(t)$
    -   $x(t)*\delta(t-t_0)=x(t-t_0)$ 
    -   $x(t-t_1)*\delta(t-t_2)=x(t-t_1-t_2)$  



### 信号分解

-   信号
    -   直流分量+交流分量
    -   偶分量+奇分量
    -   冲激函数之和



#### 冲激函数之和

-   $x(t) = \displaystyle\int_{-\infty}^{\infty}x(\tau)\delta(t-\tau)\ \mathrm d\tau = x(t)*\delta(t)$  



#### 正交分解

##### 预备知识

-   函数正交：

    $\displaystyle\int_{t_1}^{t_2}f_1(t)f^*_2(t)\ \mathrm dt = 0$  

-   正交函数集

    -    $\forall f_i,f_j\in\{f_k\}\ (i\ne j)$ 均正交，则称集合$\{f_k\}$ 是完备正交函数集

-   完备正交函数集
  
    -   定义：
      
        -   若
        
        $$
        \begin{aligned}
        &\nexists\ \varphi(t)\notin \{f_k\},\\
        &s.t.& \forall i,\ \int_{t_1}^{t_2} \varphi(t) f_i^*(t)\ \mathrm dt=0 
        \end{aligned}
        $$
        
        ​		则称 $\{f_k\}$ 为完备正交函数集
        
    -   三角函数集：$\{ 1,\cos\omega_0t,\cos2\omega_0t,\cdots,\sin\omega_0t, \sin2\omega_0t,\cdots\}$  
    
    -   复指数函数集：$\left\{ e^{jn\omega_0t} \right\}(n=0,\ \pm1,\ \pm2,\ \cdots)$  

##### 分解

-   表示：$x(t)=\sum c_if_i(t)+x_e(t)$  

-   均方误差 $\overline{x^2_e(t)} = \dfrac{1}{t_2-t_1}\displaystyle{\int_{t_1}^{t_2}\left[ x(t)-\sum\limits_{i=1}^{n}c_i f_i(t) \right]^2\ \mathrm dt}$  

    -   使均方误差最小，计算得系数

    $$
    c_j = \dfrac{\displaystyle\int_{t_1}^{t_2}x(t)f_j^*(t)\ \mathrm dt}{\displaystyle\int_{t_1}^{t_2}f_j(t)f_j^*(t)\ \mathrm dt}
    $$

-   Parseval定理：信号分解的能量关系

$$
\displaystyle\int_{t_1}^{t_2}x^2(t)\mathrm dt = \sum_{i=1}^\infty c_i^2k_i 
$$



### 频域分析

#### 周期信号的频谱分析

##### 级数展开 CFS

-   周期信号需满足**Dirichlet**条件

-   提示：“内积” 
    $$
    c_i = \frac{<x(t),f_i(t)>}{<f_i(t),f_i(t)>} 
    $$
    
-   Fourier展开：
    $$
    a_0 = \frac{2}{T_0}\int_{-\frac{T_0}{2}}^{\frac{T_0}{2}} x(t)\  \mathrm dt
    $$
    
    $$
    a_n=\frac{2}{T_0}\int_{-\frac{T_0}{2}}^{\frac{T_0}{2}} x(t)\cos n\omega_0t\  \mathrm dt\ ,\ n=1,2,\cdots
    $$

    $$
    b_n=\frac{2}{T_0}\int_{-\frac{T_0}{2}}^{\frac{T_0}{2}} x(t)\sin n\omega_0t\  \mathrm dt\ ,\ n=1,2,\cdots
    $$

    $$
    \begin{aligned}
    x(t) &= \frac{a_0}{2}+\sum_{n=1}^\infty(a_n\cos n\omega_0t+b_n\sin n\omega_0t)\\
    &=\frac{A_0}{2}+\sum_{n=1}^\infty A_n\cos(n\omega_0t+\varphi_n)
    \end{aligned}
    \tag{?}
    $$

    $$
    \begin{cases}
    A_0=a_0\\
    A_n=\sqrt{a_n^2+b_n^2}\\
    \varphi_n=-\arctan\dfrac{b_n}{a_n}
    \end{cases}\ \ \ \ n=1,2,\cdots
    $$



-   复指数展开：
    $$
    x(t) = \frac{1}{2}\sum_{-\infty}^{\infty}A_n e^{\mathrm j\varphi_n}e^{\mathrm j n\omega_0t} = \sum_{-\infty}^{\infty} X(n\omega_0)e^{\mathrm j n\omega_0t}
    $$

    $$
    \begin{aligned}
    X(n\omega_0) &= \frac{1}{2}A_n e^{\mathrm j\varphi_n} = \frac{1}{2}(a_n-\mathrm jb_n)\\
    &=\frac{1}{T_0}\int_{-\frac{T_0}{2}}^\frac{T_0}{2} x(t)e^{-\mathrm jn\omega_0t}\ \mathrm dt
    \end{aligned}
    $$
    
    称 $X(n\omega_0)$ 为复Fourier系数

-   取样函数  $\mathrm{Sa}(x)=\dfrac{\sin x}{x}$  

    -   周期矩形脉冲的Fourier级数： ${\rm CFS}[g(t)]= X(n\omega_0) =\dfrac{\tau}{T_0} \mathrm{Sa}\left(\dfrac{n\omega0\tau}{2} \right)$ 





##### 周期信号的频谱

-   $|X(n\omega_0)|$ 
-   特性：
    -   离散性
    -   谐波性
        -   谱线以$\omega_0$ 为间隔等间距分布
    -   收敛性
    -   ***Remark***: 满足Dirichlet条件的周期函数均有上述3个特性
-   负频率：
    -   出于数学表示的需要，无物理意义
    -   绝对值相等的正负频率幅度之和 表示一个实际存在的正弦谐波分量



##### 周期信号的功率分配

$$
P=\frac{1}{T_0}=\left( \frac{A_0}{2} \right)^2+\sum_{n=1}^\infty\frac{1}{2}A_n^2
$$

-   周期信号时域平均功率 = 直流、基波、各次谐波平均功率之和

##### Fourier级数近似

-    *吉伯斯现象



#### 连续非周期信号的频谱分析

-   $T_0\rightarrow\infty$，谱线连续，幅值无穷小
-   考虑频谱密度函数$X(\omega)=T_0X(n\omega_0)=\dfrac{2\pi}{\omega_0} X(n\omega_0)$ 

##### Fourier 变换

-   $X(\omega)=\displaystyle\int_{-\infty}^\infty x(t)e^{-\mathrm j\omega t}\ \mathrm dt$ 
-   逆变换：$x(t)=\dfrac{1}{2\pi} \displaystyle\int_{-\infty}^\infty X(\omega)e^{\mathrm j\omega t}\ \mathrm d\omega$ 
-   CFT存在的**<u>充分</u>**条件：非周期函数的Dirichlet条件

##### 常用Fourier变换

|     $g(t)$     |     $\tau Sa(\dfrac{\omega\tau}{2})$      |
| :------------: | :---------------------------------------: |
|    单边指数    |        $\dfrac{1}{a+\rm j\omega}$         |
|    双边指数    |        $\dfrac{2a}{a^2+\omega^2}$         |
|       1        |           $2\pi\delta(\omega)$            |
| ${\rm sgn}(t)$ |       $\dfrac{2}{\mathrm j\omega}$        |
|  $\delta(t)$   |                     1                     |
|     $u(t)$     | $\pi\delta(t)+\dfrac{1}{\mathrm j\omega}$ |
|                |                                           |

##### 周期函数的Fourier变换

$$
X(\omega)=\sum_{n=-\infty}^\infty 2\pi X(n\omega_0)\delta(\omega-n\omega_0)
$$

-   周期函数CFS与CFT的区别:
    -   CFS：表征幅度，为有限值
    -   CFT：表征频谱密度，为冲激串



#### Fourier 变换性质

-   线性

-   奇偶性
    $$
    \mathscr F[x^*(t)]=X^*(-\omega)
    $$
    
-   对偶性
    $$
    \mathscr F[x(t)] = X(\omega)\\
    \Updownarrow\\
    \mathscr F[X(t)] = 2\pi x(\omega)
    $$
    
-   尺度变换
    $$
    \mathscr F[x(at)]=\frac{1}{|a|}X(\frac{\omega}{a})
    $$
    
    -   时域压缩——频带展宽
    
-   时移性质
    $$
    \mathscr F[x(t\pm t_0)]=e^{\pm\mathrm j\omega t_0}X(\omega)
    $$
    
-   频移特性
    $$
    \mathscr F[e^{\pm\mathrm j\omega_0 t}x(t)]=X(\omega\mp\omega_0)
    $$
    
-   微分性质
    $$
    \mathscr F\left[\frac{\mathrm d^nx(t)}{\mathrm dt^n} \right]=(\mathrm j\omega)^n X(\omega)
    $$
    
-   积分性质
    $$
    \mathscr F\left[\int_{-\infty}^t x(\tau)\ \mathrm d\tau \right]=\frac{1}{\mathrm j\omega}X(\omega)+\pi X(0)\delta(\omega)
    $$
    
-   Parseval 定理
    $$
    \int_{-\infty}^\infty |x(t)|^2\ \mathrm dt = \dfrac{1}{2\pi} \int_{-\infty}^\infty |X(\omega)|^2\ \mathrm d\omega
    $$
    
-   卷积定理

    -   证明思路：交换积分顺序
    -   时域：略
    -   频域：
    
    $$
    \mathscr F^{-1}[X_1(\omega)*X_2(\omega)] = 2\pi\cdot x_1(t) X_2(t)
    $$



---

## 离散信号分析

### 时域分析

#### 理想采样与恢复

##### 时域采样定理

-   $x_s(t)=x(t)\sum\limits_{n=-\infty}^\infty \delta(t-nT_s)$ 
-   $X_s(\omega)=\dfrac{1}{T_s}\sum\limits_{n=-\infty}^{\infty}X(\omega-n\omega_s)$ 
-   Shannon采样定理; Nyquist 频率
-   非时限——频域带限（周期延拓）

##### 频域采样定理

-   $X_p(\omega)=X(\omega)\sum\limits_{k=-\infty}^\infty \delta(\omega-k\omega_0)$ 

-   $x_p(t)=\dfrac{1}{\omega_0}\sum\limits_{k=-\infty}^\infty x(t-kT_0)$ 
-   $\omega_0\le \dfrac{\pi}{t_m}$ ; $T_0 \ge 2t_m$  
-   非带限——时限（周期延拓）

##### 恢复连续时间信号内插公式
$$
    \begin{aligned}
        x(t) &= \sum_{n=-\infty}^\infty x(nT_s)\delta(t-nT_s) * {\rm Sa}\left(\dfrac{\omega_s}{2}t \right) \\
        &= \sum_{n=-\infty}^\infty x(nT_s) {\rm Sa}\left[\dfrac{\omega_s}{2}(t-nT_s) \right]
    \end{aligned}
$$

##### 频域内插公式
$$
    \begin{aligned}
        X(\omega) 
        &= \sum_{k=-\infty}^\infty X(k\omega_0) {\rm Sa}\left[\dfrac{T_0}{2}(\omega-k\omega_0) \right]
    \end{aligned}
$$


#### 离散信号描述

-   序列$x(n)$或$x(k)$ 
-   离散信号能量：$W=\sum\limits_{n=-\infty}^\infty |x(n)|^2$ 
-   <font color=red>***数字角频率***</font> $\varOmega_0=\omega_0T_s\ (\rm rad)$ , 范围：$[0,2\pi)$  

##### 典型序列

1.  单位脉冲

2.  单位阶跃

3.  矩形序列
    $$
    R_N(n) = 
    \begin{cases}
        1 & 0 \le n \le N-1 \\
        0 & \rm others
    \end{cases}
    $$

4.  实指数序列

    -   $x(n)=a^n u(n)$ 

5.  正弦型序列

    -   $x(n)=A\sin(n\omega_0T_s + \varphi_0)$ 
    -   不一定是周期信号：
        -   周期信号须满足条件：$2\pi/\varOmega_0$ 为有理数

6.  复指数序列

    -   $x(n)=e^{(\sigma+\mathrm j\varOmega_0)n}$ 
    -   数字频率取值范围：$0\le\varOmega\le2\pi$ 

7.  任意离散序列

#### 离散信号时域运算

1.  平移
2.  翻转
3.  相加
4.  相乘
5.  累加
  
    -   $\sum\limits_{k=-\infty}^{n}x(k)$ 
6.  差分
    -   前向：$\Delta x(n)=x(n+1)-x(n)$ 
    -   后向：$\nabla x(n)=x(n)-x(n-1)$ 
    -   关系：$\nabla x(n)=\Delta x(n-1)$  
7.  时间尺度变换
    -   ***Remark***: 不是压缩序列，而是变化采样时间
    -   $x(2n)$ 是序列$x(n)$ 每两项抽一项
8.  卷积和
    -   性质：
        -   满足：交换律、分配律、结合律
        -   差分、累加性质类似连续卷积的微分、积分
        -   与脉冲序列卷积：
            $$
            \begin{aligned}
                x(n) * \delta(n) &= x(n) \\
                x(n) * \delta(n-n_0) &= x(n-n_0) \\
                x(n-n_1) * \delta(n-n_2) &= x(n-n_1-n_2) \\
            \end{aligned}
            $$
    
9.  两序列相关运算



### 频域分析

#### DFS（周期信号）

-   由CFS推出：令 $T_0=NT$, $\mathrm{d}t=T$, $\varOmega_0=\omega_0T=2\pi/N$.  

$$
X\left(k\frac{\varOmega_0}{T} \right)=\frac{1}{N}\sum_{n=0}^{N-1}x(nT)e^{-\mathrm jk\varOmega_0 n}
$$

或记作
$$
x(n)=\sum_{k=0}^{N-1} X(k)e^{\mathrm jk\varOmega_0 n} \\
X\left(k\Omega_0\right)=\frac{1}{N}\sum_{n=0}^{N-1}x(n)e^{-\mathrm jk\varOmega_0 n}
$$

-   注意到频谱$X(k\Omega_0)$ 也是==周期==为$N$ 的离散序列

-   向量正交分解：
    $$
    \begin{bmatrix}
    x(0)\\
    \vdots\\
    x(N-1)\\
    \end{bmatrix}
    =
    \begin{bmatrix}
    e^{j0\varOmega_00}&\cdots&e^{j(N-1)\varOmega_00}\\
    \vdots&\ddots&\vdots\\
    e^{j0\varOmega_0(N-1)}&\cdots&e^{j(N-1)\varOmega_0(N-1)}\\
    \end{bmatrix}
    \begin{bmatrix}
    X(0)\\
    \vdots\\
    X\left((N-1)\varOmega_0\right)\\
    \end{bmatrix}
    $$



##### DFS性质

1.  线性
2.  周期卷积定理
    -   周期卷积：$x(n) \star$ 
    -   周期卷积仅在单个周期内求和
3.  复共轭
    -   $x^*(-n) \larr{\rm DFS}\rarr X^*(k\varOmega_0)$
4.  位移



#### DTFT（非周期信号）

-   周期延拓、取极限

    $$
    X(\varOmega)=\sum\limits_{n=-\infty}^\infty x(n)e^{-\mathrm j\varOmega n}\\
    \left(\varOmega=k\frac{2\pi}{N},\ k=0,1,\cdots,N-1\right)
    $$
    
    $$
    x(n)=\frac{1}{2\pi} \int_0^{2\pi} X(\varOmega)e^{\mathrm j\varOmega n}\ \mathrm d\varOmega
    $$
    
-   存在条件：
  
    -    $x(n)$ 绝对可和 
  
-   注意到DTFT仍是连续周期函数（关于$\varOmega$ ） 

##### 性质
-   P137 表2-1

##### 常见序列

|     $x(n)$      |          $X(\Omega)$          |
| :-------------: | :---------------------------: |
|   $\delta(n)$   |               1               |
| $\delta(n-n_0)$ | $e^{-\mathrm j\varOmega n_0}$ |
|        1        |    $2\pi\delta(\varOmega)$    |

##### DTFT对称性质

| $x(n)$ | $X(\varOmega)$ |
| :----: | :------------: |
| 实、偶 |     实、偶     |
| 实、奇 |     虚、奇     |
| 虚、偶 |     虚、偶     |
| 虚、奇 |     实、奇     |


#### DFT

-   时域、频域均离散

-   推导思路：
    1.  非周期信号——DTFT：$[0,2\pi]$ 作N点采样
    2.  周期信号——DFS：取主值

-   从DFS推导：
    -   周期延拓
    -   取主值
    -   乘周期（变成频谱密度函数）

-   从DFTF推导：
    $$
    \begin{aligned}
        X(k)  &= {\rm DTFT}[x(n)]\left.\right|_{\varOmega=k\frac{2\pi}{N}} \\
        &= X(\varOmega)\left.\right|_{\varOmega=k\frac{2\pi}{N}} \\
        &= \sum_{n=0}^{N-1} x(n)e^{-\mathrm j k\frac{2\pi}{N} n}
    \end{aligned}
    $$

-   离散傅立叶变换
    $$
    X(k)=NX(k\varOmega_0)=\sum_{n=0}^{N-1} x(n)e^{-\mathrm j k\varOmega_0 n}\\ =\sum_{n=0}^{N-1} x(n)e^{-\mathrm j k\frac{2\pi}{N} n}
    $$

    $$
    x(n)=\frac{1}{N} \sum_{k=0}^{N-1} X(k) e^{-\mathrm j k\frac{2\pi}{N} n}
    $$



##### DFT性质

1.  线性：短的补0

2.  圆周移位（循环移位）
    $$
    ((n-m))_N \triangleq (n-m)\ \ {\rm MOD}\ \ N 
    $$
    -   性质：
    $$
    \begin{aligned}
        x((n-m))_N R_N(n) &\Leftrightarrow e^{-\mathrm j\varOmega_0mk}X(k) \\
        e^{\mathrm j\varOmega_0k_0n}x(n) &\Leftrightarrow X((k-k_0))_N R_N 
    \end{aligned}
    $$

3.  圆周卷积
    $$
    x(n)\star h(n)=\sum_{m=0}^{N-1} x(m)h((n-m))_N R_N(n)
    $$
    -   圆周卷积运算的两个序列长度必须相等（短的可以补零）
    -   ***Remark***:
        -   注意**圆周**卷积与***线性***卷积的不同，both原因and结果（P145~146）
        -   当2个序列补零到长度满足 $L\geq N+M-1$ 时，两种卷积结果一致

4.  时移特性
    $$
    {\rm DFT}[x((n-m))_N R_N(n)] = e^{-\mathrm j\varOmega_0mk}X(k)
    $$
    
5.  频移特性
    $$
    {\rm DFT}[e^{\mathrm j\varOmega_0mk_0} x(n) ] = X((k-k_0))_N R_N(n)
    $$

6.  卷积定理
    $$
    \begin{aligned}
        x(n)\star h(n) &= X(k)H(k) \\
        x(n)h(n) &= \frac{1}{N} X(k)\star H(k)
    \end{aligned}
    $$



#### FFT

-   定义指数（旋转/加权）因子：$W_N=e^{-\mathrm j2\pi/N}$ 
    -   性质：正交、周期、对称、可约
-   频率分辨率：
    -   数字频率：$2\pi/N$ 
    -   实际频率：$f_s/N$ 
-   码位倒置
-   应用：
    -   求线性卷积
    -   *求线性相关* 
    -   连续时间信号频谱分析
        -   时限连续信号
        -   带限信号：时宽无限，须加窗截断


### Z域分析

-   DTFT不收敛
-   乘衰减因子$r^{-n}$($r>1$) 

#### Z变换与反变换

##### 定义

-   令$z=re^{\mathrm j\varOmega}$ 
    $$
    X(z) = \mathscr Z[x(n)] = \mathscr F[x(n)r^{-n}]= \sum_{n=-\infty}^{\infty} x(n)(re^{\mathrm j\varOmega})^{(-n)}\\
    =\sum_{n=-\infty}^{\infty} x(n)z^{-n}
    $$

    $$
    x(n)=\frac{1}{2\pi}\int_0^{2\pi} X(z)(re^{\mathrm j\varOmega})^n \mathrm d\varOmega\\
    =\frac{1}{2\pi\mathrm j}\oint_C X(z)z^{n-1} \mathrm dz
    $$



##### 收敛域ROC

-   满足
    $$
    \sum_{n=-\infty}^\infty |x(n)|r^{-n}<\infty
    $$
    条件的所有z

-   ==Z变换要写收敛域== , 不同收敛域对应的时域序列不同  

-   不同序列的收敛域

    1.  有限长序列 $0<|z|<\infty$  
    2.  右边序列 $|z|>R_{x1}$  
    3.  左边序列 $|z|< R_{x2}$  
    4.  双边序列 $R_{x1}<|z|< R_{x2}$  


##### 反变换求取

###### 部分分式展开

$$
\frac{X(z)}{z}=\sum_{j=1}^{m}\frac{A_j}{z-p_j}
$$


###### 幂级数

-   大除法，商写成如下形式
    $$
    X(z) = A_1z^{-1} + A_2z^{-2} + \cdots
    $$

###### 围线积分
-   留数法，不要求掌握

#### 单边Z变换
$$
X(z) = \sum_{n=0}^{\infty} x(n) z^{-n}
$$


#### Z变换性质

| 性质  |    时域    |       z域       |
| :---: | :--------: | :-------------: |
| 时移  | $x(n-n_0)$ | $z^{-n_0} X(z)$ |

##### 单边Z变换的性质（与双边Z变换不同）
1.  时移定理 P171
    -   单边Z变换要考虑信号的初始状态
    -   设单边Z变换为 $X(z)$ ，设$x(n)$ 是双边序列
        -   左移：$\mathscr{Z}[x(n+m)u(n)] = z^m \left[X(z)-\sum\limits_{k=0}^{m-1}x(k)z^{-k} \right]$  
        -   右移：$\mathscr{Z}[x(n-m)u(n)] = z^{-m} \left[X(z)+\sum\limits_{k=-m}^{-1}x(k)z^{-k} \right]$  

    -   单边Z变换，$x(n)$ 是因果序列
        -   右移：$\mathscr{Z}[x(n-m)u(n)] = z^{-m} X(z)$ 
        -   左移: 同双边序列

2.  初值定理
    $$
    x(0) = \lim_{z\rightarrow\infty} X(z)
    $$

3.  终值定理
    $$
    \lim_{n\rightarrow\infty} x(n) = \lim_{z\rightarrow1}[(z-1)X(z)] 
    $$


#### Z变换与其他变换的关系
##### Laplace
-   $X(z)\left.\right|_{z=e^{sT}}=X(s)$  
##### DTFT
-   $X(z)\left.\right|_{z=e^{\rm j\varOmega}} = X(\varOmega)$  
##### DFT
-   单位圆上采样

---

## 信号处理基础

### 系统及其性质
#### 系统定义
#### 系统与信号关系
#### 系统性质
1. 记忆性
  
-   动态系统/记忆系统
  
2. 因果系统
    $$
    y(t) = f[x(t-\tau)] \ ,\tau \ge 0
    $$

3. 可逆性与可逆系统
  
-   单射
  
4. 稳定性

5. 时变、时不变

6. 线性、非线性

#### 线性时不变系统的冲激/样值响应
-   单位冲激响应（是**零状态**响应）  $h(t)$ 
    -   直接Laplace解决
-   单位脉冲响应（零初值）$h(n)$ 
    -   直接Z变换解决
-   步骤
    -   略

#### 连续系统的卷积积分
$$
y(t) = x(t) * h(t)
$$

#### 离散系统的卷积和
$$
y(n) = x(n) * h(n)
$$

#### 冲激响应与阶跃响应的关系
$$
\begin{aligned}
    h(t) &= c'(t)\\
    h(n) &= c(n) - c(n-1)
\end{aligned}
$$

#### 卷积的性质
1. 交换律
2. 结合律
3. 
4. 微分（差分）
5. 积分（累加）

#### 匹配滤波

-   自相关：
    $$
    R_{xx}(\tau) = \int_{-\infty}^\infty x(t)x(t+\tau)\ \mathrm dt
    $$

-   令滤波器单位冲激响应
    $$
    h(t) = x(T-t)
    $$
    则滤波器时域响应为
    $$
    y(t) = x(t) * h(t) = R_{xx}(t-T)
    $$

-   信号的自相关函数在原点取最大值，且等于该信号的能量
-   该滤波器后接判决器（阈值处理），可判断是否接收到确知信号$x(t)$ , 故名匹配滤波器




### 频域法分析
#### 频率特性函数
-   令输入 $x(t)=e^{\mathrm{j}\omega t}$ 
    则
    $$
    y(t) = h(t)*x(t) = H(\omega)e^{\mathrm j\omega t}
    $$

#### 无失真传输
-   信号通过系统后，波形不变，允许幅度按比例放大缩小，允许固定延迟
-   无失真传输系统的频率特性函数：
    $$
    H(\omega) = \frac{Y(\omega)}{X(\omega)} = Ke^{\mathrm j\omega t_0}  
    $$

#### 理想低通滤波器

-   频率特性：
    $$
    H(\omega)
    \begin{aligned}
    \begin{cases}
        1\cdot e^{-\mathrm j\omega t_0} & |\omega|<\omega_c\\
        0 & |\omega|>\omega_c 
    \end{cases}
    \end{aligned}
    $$
    即
    $$
    \begin{cases}
    |H(\omega)| = 
    \begin{cases}
        1 & |\omega|<\omega_c\\
        0 & |\omega|>\omega_c 
    \end{cases} \\
    \varphi_h = -\omega t_0 
    \end{cases}
    $$

-   单位冲激响应：
    $$
    h(t) = \frac{\omega_c}{\pi} {\rm Sa}(\omega_c (t-t_0)) 
    $$

-   注意到 $t<0$ 时 $h(t)\neq0$ , 故ILPF是非因果系统，物理上不可实现

---

## 滤波器

### 滤波概念
-   传统：消除或减弱干扰噪声，强化有用信号的过程
-   现代：从原始信号中获取目标信息的过程
-   滤波器：实现滤波功能的系统，一种具有一定传输特性的信号处理装置

### 技术要求
-   通带：$-3\ {\rm dB} <|H(\omega) | \le 0\ {\rm dB}$, 有限衰减  
-   通带截止频率 $\omega_p$  
-   阻带截止频率 $\omega_s$  
-   衰减函数$\alpha(\omega) = -10\lg |H(\omega) |^2$  (假定$H(0)=1$ 已归一化) 
    -   阻带最小衰减：$\alpha(\omega_s)$  
    -   通带最大衰减：$\alpha(\omega_p) = (3\ \rm dB)$  


### 模拟滤波器
-   物理可实现的条件：传递函数满足
    -   实系数有理函数
    -   极点均在左半平面
    -   分子阶次不大于分母阶次（因果系统）

-   设计方法：
    -   希望滤波器冲激响应为实函数, 则由共轭对称性得
        $$
        |H(\omega)|^2 = H(\omega)H^*(\omega)=H(\omega)H(-\omega) 
        $$
        若 $h(t)$ 存在Fourier变换，则
        $$
        |H(\omega)|^2 = H(s)H(-s)\left.\right|_{s=\rm j\omega}  
        $$
        零、极点分布关于虚轴对称
    -   给定 $|H(\omega)|^2$ , 用 $-s^2$ 代替 $\omega^2$ , 确定$H(s)$ 的零极点
    -   一般取最小相位系统

#### Butterworth LPF
-   以最高阶Taylor级数逼近理想矩形特性，n越大特性越理想
-   幅频特性
    $$
    |H(\omega) |^2 = \dfrac{1}{1+\left(\dfrac{\omega}{\omega_c}\right)^{2n}}  
    $$

-   通过 $\alpha_s$ 确定阶次
    $$
    n \ge \dfrac{\lg \sqrt{10^{0.1\alpha_s}-1}}{\lg \dfrac{\omega_s}{\omega_c}}  
    $$
-   零极点分布
    -   $s_k=\omega_c e^{\mathrm j\left[\dfrac{2k+1}{2n}\pi+\dfrac{\pi}{2} \right]}$  ,  $k=0,1,\cdots,2n-1$  
    -   极点以 $\dfrac{\pi}{n}$ 为间隔分布在半径为$\omega_c$ 的圆上（Butterworth圆）
-   归一化复频率：令
    $$
    \overline{s} = \frac{s}{\omega_c} 
    $$
    则
    $$
    |H(\omega)| = \dfrac{1}{\prod\limits_{k=1}^n \left(\overline{s}-\dfrac{s_k}{\omega_c}\right)} 
    $$
    查表设计


### 数字滤波器
#### 概述
-   处理离散时间信号
-   具有一定传输特性的数字信号处理装置
-   分类
    -   递归型——IIR
    -   非递归型——FIR
    -   FFT实现的数字滤波器
-   系统函数
$$
    H(z) = \frac{\sum\limits_{i=0}^M b_i z^{-i}}{1+\sum\limits_{j=1}^N a_j z^{-j}} 
$$

-   当存在 $a_j\neq0$ 且分母不能整除，对应滤波器为IIR滤波器
  

#### IIR 数字滤波器
##### 冲激响应不变法
-   用有理多项式逼近给定滤波器幅频特性
$$
    H(z) = b_0 (1+z^{-1}+z^{-2} + \cdots)
$$
-   思路：
    1. 设计模拟滤波器
    2. 直接Z变换

-   特点：
    1.  模数频率呈线性关系：$\varOmega = \omega T$  
    2.  s平面与z平面间映射的多值性易造成频谱混叠现象，不适宜高通、带阻数字滤波器
##### 双线性变换法
-   s平面到 $\hat s$ 平面变换：
    $$
        s = \frac{2}{T} \left( \frac{1-e^{\hat sT}}{1+e^{\hat sT}} \right)
    $$
    -   把s平面压缩到 $[-\mathrm j\dfrac{\pi}{T}, \mathrm j\dfrac{\pi}{T}]$ 横带上
    -   该变换是一一映射

-   $\hat s$ 平面到 z 平面变换：
  
-   Z变换：$z=e^{\hat sT}$  
  
-   最终双线性变换表达式：
    $$
    s = \frac{2}{T} \frac{z-1}{z+1} 
    $$

-   优点
  
    -   实现s平面到z平面的一一映射，消除频谱混叠
-   缺陷：
    -   数字滤波器与模拟滤波器在频率响应和频率的对应关系上发生畸变
        -   模拟频率与数字频率之间为非线性关系：
            $$
                \omega = \frac{2}{T} \tan \frac{\varOmega}{2} 
            $$

-   步骤：
    1.  关键频率点进行预畸变处理
    2.  设计模拟滤波器（确定阶数、归一化、反归一化）
    3.  双线性变换得数字滤波器


##### IIR滤波器的网络结构
1. 直接型
2. 级联型
3. 并联型

