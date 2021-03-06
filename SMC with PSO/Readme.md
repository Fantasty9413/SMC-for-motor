# PSO优化滑模控制器参数

## 1.粒子群算法

### 1.1粒子群算法原理

​	粒子群优化算法（Particle Swarm Optimization，简称PSO）, 是1995年Eberhart博士和Kennedy博士一起提出的，它是源于对鸟群捕食行为的研究。粒子群优化算法的基本核心是利用群体中的个体对信息的共享从而使得整个群体的运动在问题求解空间中产生从无序到有序的演化过程，从而获得问题的最优解。

​	简单来说，PSO就是通过初始化一群随机粒子，然后进行迭代来逐渐靠近最优解，最终收敛至最优解。算法的流程图和伪代码见下图。

<img src="F:\课程\电子信息导论\figure\PSO流程图.png" alt="PSO算法流程图和伪代码" style="zoom:60%;" />

​	算法中最为关键的步骤是每轮迭代时更新粒子的速度和位置。

​	其中速度更新的计算主要依赖于上一时刻的速度值、当前位置与粒子历史最优位置的差值和当前位置与粒子群历史最优位置的差值，其具体计算公式如下：
$$
\large
v_{i}(t+1) = \omega v_{i}(t) + c_{1} r_{1}(pbest_{i} - x_{i}(t)) + c_{2} r_{2}(gbest - x_{i}(t))
$$
​	其中$v_{i}(t)$代表第$i$个粒子在$t$时刻的速度值；$x_{i}(t)$代表第$i$个粒子在$t$时刻的位置；$pbest_{i}$代表第$i$个粒子的历史最优位置；$gbest$代表第整个粒子群的历史最优位置。系数$\omega$是速度惯性权重，用于调节对解空间的搜索范围；$c_{1}$是自我学习因子，$c_{2}$是群体学习因子，共同用于调节最大步长；$r_{1}$和$r_{2}$是两个随机数，范围介于0到1之间，主要用于增加搜索的随机性。

​	而位置的更新则较为简单，只需要上一时刻的位置值和速度值，计算公式如下：
$$
\large
x_{i}(t+1) = x_{i}(t) + v_{i}
$$

### 1.2粒子群算法求函数最值

​	基于上述原理，将粒子群算法用于求解函数的最值。以自变量的值作为粒子位置值，以函数值作为种群适应度，在matlab中编写代码粒子群算法，实现寻找函数极值点与极值的功能，

​	为测试代码，选取测试函数如下：
$$
f(x) = xsinxcos2x-2xsin3x
$$
​	对上述函数求解$[0,20]$范围内的最小值，其结果如下。其中左图为函数曲线，红点为PSO寻优寻找到的最小值标记点；右图为PSO寻优过程中的收敛曲线。

<div align=center>
	<img src="F:\课程\电子信息导论\figure\PSO寻找最值.jpg" alt="PSO寻优最值" style="zoom:67%;" />
	<img src="F:\课程\电子信息导论\figure\PSO寻找最值收敛曲线.jpg" alt="PSO寻找最值收敛曲线" style="zoom:67%;" />
    <br>(a).PSO寻优最值 (b).收敛曲线</br>
</div>

​	最终得到函数的最值点为$x_{0}=19.4113$，函数的最值$f(x_{0})=-30.0963$。测试PSO寻优最值成功。



## 2.滑模变结构控制

### 2.1被控对象

​	选取简单的电机作为被控对象，其数学模型如下：
$$
\ddot \theta (t) = -f(\theta,t) + b u(t) \\
$$
​	其中$\theta(t)$为电机转动的角度；$u(t)$为输入给电机的控制量。$f$为模型中的非线性项，其表达式为$f(\theta,t) = 25 \dot \theta$。 

### 2.2滑模控制器设计

​	对于被控电机，设其期望跟踪角度为$\theta_d (t) = sint$。现设计滑模控制器实现闭环控制，使得电机实际角度$\theta (t)$的变化可以跟踪上期望角度$\theta_{d} $的变化。

​	定义系统的跟踪误差为$e(t) = \theta_{d} - \theta$，系统跟踪误差的微分为$\dot e = \dot \theta_{d} - \dot \theta$。取线性滑模面$s=ce+\dot e$，并且采用等速+指数趋近率，最后设计得到滑模控制器表达式如下：
$$
\large
u(t) = \frac{1}{b}(\epsilon sgns + ks + c \dot e + \ddot \theta_{d} + f(\theta,t))
$$
​	控制器设计过程与稳定性证明见附录。

### 2.3实验仿真

​	在simulink中搭建相应的仿真模型如下：

<img src="F:\课程\电子信息导论\figure\smc with pso\simulink模型.png" alt="simulink仿真模型" style="zoom: 67%;" />

​	部分重要参数选取如下：

|    名称    |    符号    | 数值 |
| :--------: | :--------: | :--: |
| 滑模面系数 |    $c$     |  15  |
| 指数趋近率 |    $k$     |  10  |
| 等速趋近率 | $\epsilon$ |  5   |
|  输入系数  |    $b$     | 133  |

​	仿真结果见下图，可见系统输出在$t = 0.568s$时跟踪上期望输入。

<div align = center>
    <img src = "F:\课程\电子信息导论\figure\smc with pso\theta.jpg" alt="角度跟踪曲线" style="zoom: 67%;" />
    <img src = "F:\课程\电子信息导论\figure\smc with pso\ut.jpg" alt="控制器输出" style="zoom: 65%;" />
    <br>(a). 角度跟踪曲线 (b). 控制器输出</br>
</div>




## 3.粒子群算法优化滑模控制参数

### 3.1 优化目标

​	借鉴最优控制的思想：以一控制系统作为研究对象，考虑其中某些参数可变或者不确定的情况，寻找一组最优数，使得控制系统满足某些特殊条件或约束。

​	本文以上述控制系统作为对象，为滑模面系数$c$和等速趋近率$\epsilon$寻找一组最优参数，使得系统的**能量消耗和跟踪误差最少**。

​	基于上述要求，以系统跟踪误差$e$和系统控制量$ut$作为指标，提出了优化控制的目标函数如下：
$$
\large
J = \int ^{\infty} _{0} a|e(t)| +b| ut(t)| \space dt
$$
​	其中系数$a$和$b$分别为跟踪误差与控制量的权重，代表了对能量消耗要求和误差跟踪要求的重视程度。

### 3.2 实验仿真

​	本文实验平台为matlab2020b版本。实验思路为利用simulink仿真计算系统的能量消耗和跟踪误差值，再导入workspace，通过matlab计算目标函数值并进行粒子群寻优，最终获得最优参数解。

​	由于数值计算具有离散型与有限性，这与上述目标函数相悖，因此在实际实验与计算时，将目标函数的无限积分更改为有限累加，更改后的目标函数如下：
$$
J = \sum _{i=start} ^{i=end} (a\space |e(i)| * T_{step} \space + b \space |ut(i)| * T_{step}  \space)
$$
​	其中$T_{step}$为仿真步长，本次实验统一使用固定步长仿真，取$T_{step}=0.001s$。

### 3.3 实验结果

​	以下为粒子群位置分布图，其中左图为粒子群初始时的位置，其满足随机分布；经过迭代后，得到粒子群末态分布位置图，粒子基本分布与最优参数解$c=2.2007,\epsilon=8.8920$的附近，此时目标函数取最小值$J=1.1980$。

<div align=center>
	<img src="F:\课程\电子信息导论\figure\smc with pso\粒子群位置分布初态.jpg" alt="粒子群位置分布初态" style="zoom:67%;" />
	<img src="F:\课程\电子信息导论\figure\smc with pso\粒子群位置分布末态.jpg" alt="粒子群位置分布末态" style="zoom:67%;" />
    <br>(a).粒子初态分布 (b).粒子末态分布</br>
</div>


​	再统计历代粒子最优解可得进化过程曲线，如下图。并且发现当迭代至$N=10$代时，即可取得最优值。

<div align=center>
	<img src="F:\课程\电子信息导论\figure\smc with pso\收敛过程.jpg" alt="收敛过程" style="zoom:67%;" />
    <br>收敛过程</br>
</div>




## 附录

### [A]滑模控制器设计与稳定性证明

​	已知系统跟踪误差为$e(t) = \theta_{d} - \theta$，系统跟踪误差的微分为$\dot e = \dot \theta_{d} - \dot \theta$，对$s=ce+\dot e$取微分得
$$
\dot s = c \dot e + \ddot e \\
=c \dot e + \ddot \theta_{d} - \ddot \theta \\
=c \dot e + \ddot \theta_{d} + f(\theta,t) - bu(t) \\
$$
​	令其等于指数+等速趋近率$\dot s = -ksgn(s) - \epsilon$推到得控制器表达式。
$$
\dot s = c \dot e + \ddot \theta_{d} + f(\theta,t) - bu(t) = -ksgn(s) - \epsilon \\
\Downarrow \\
u(t) = \frac{1}{b}(\epsilon sgns + k s + c \dot e + \ddot \theta_{d} + f(\theta,t))
$$
​	利用李雅普诺夫稳定理论证明稳定性，构造备选李雅普诺夫函数$V = \frac{1}{2}s^2$，对其求微分：
$$
\dot V = s \dot s \\
= s * (- \epsilon sgns - k s) \\
= - \epsilon s - ks^2 \\
= - \epsilon s - 2k V \\
$$
​	再利用放缩可得：
$$
\dot V \leqq -2k V  \space \Rightarrow \space V(t) \leq e^{-2k(t-t_{0})} V(t_{0})
$$
​	证明$V(t)$以指数形式收敛至0，证得系统稳定。

