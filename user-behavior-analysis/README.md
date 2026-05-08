# 运营商用户行为分析与用户分群

基于 SQL + Python + SPSS + Power BI 的数据分析项目

## 项目概述
本项目模拟运营商用户行为分析场景，基于天池淘宝用户行为数据集（12,256,906条记录），通过Python进行数据清洗与指标计算，使用SPSS进行用户分群的统计显著性检验（ANOVA），最终用Power BI搭建可视化看板，输出用户运营策略建议。

## 技术栈
- Python（Pandas）：数据清洗、去重、DAU/活跃天数指标计算
- SPSS：频数统计、单因素ANOVA方差检验、交叉表分析
- Power BI：交互式可视化看板（DAU趋势、用户分层、时段偏好）

## 核心成果
- 构建用户价值分层体系：高价值用户34.4%、中价值用户37.1%、低价值用户28.5%
- SPSS ANOVA检验：F=11,229.94，p<0.001，Eta方=0.718，分层在统计学上极其显著
- 识别晚间20-23时为用户活跃高峰，提出差异化运营策略
- 完成PPT分析报告，完整呈现从数据清洗到策略输出的全流程

## 项目文件结构
├── README.md                                                            
├── project2.py # Python代码（数据抽样+指标计算）                 
├── user_behavior_sample_1percent.csv # 1%随机抽样数据（81,640条）             
├── user_active_days.csv # 用户活跃天数与分层结果                 
├── dau.csv # 每日活跃用户数                                         
├── hourly_active.csv # 各时段活跃用户分布                    
├── powerbi_dashboard.pbix # Power BI交互式看板                  
├── spss_anova.pdf # SPSS ANOVA分析结果                 
├── 运营商用户行为分析报告.pptx # PPT分析报告                
└── 运营商用户行为分析报告.pdf # PDF分析报告          

## 快速查看
-  看板效果：下载 `powerbi_dashboard.pbix` 用Power BI Desktop打开
-  分析结果：查看 `spss_anova.pdf` 了解统计显著性验证
-  完整报告：下载 `运营商用户行为分析报告.pdf`

## 作者
蒲俊霖 | 数据科学与大数据技术 | 2026年4月
