# SMC-for-motor
created a smc(sliding mode control)  controller for a motor (for smc learning)
  
## 1.chap1_1
滑模控制器入门例程，对简单电机模型（带扰动）设计一个指数趋近率的滑模控制器。
  
## 2.chap2_2
为电机（没有外加扰动的模型）设计了4种不同趋近速率（1.等速趋近速率 2.指数趋近速率 3.幂次趋近速率 4.一般趋近速率）的滑模控制器。

## 3.Terminal (10.16)
以一个简单二阶模型介绍了**非线性系统的固定时间Terminal控制器的设计方法**。
对于带扰动的电机模型，建立二阶数学模型。针对这一被控对象设计了Terminal终端滑模控制器，使得电机的输出在固定时间Tc时刻跟踪上期望输入。
