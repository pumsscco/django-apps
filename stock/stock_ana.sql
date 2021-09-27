/*已清仓股票排行*/
---------------------------------------
/*按日均利润*/
select code,sum(amount) as '净利润', 
min(date) as '首次交易日期', max(date) as '最后交易日期', 
datediff(max(date),min(date)) as '持股天数', 
sum(amount)/datediff(max(date),min(date)) as '日均利润' 
from stock group by code having sum(volume)=0 order by 日均利润 DESC;
/*按总利润*/
select code,sum(amount) as '净利润', 
min(date) as '首次交易日期', max(date) as '最后交易日期', 
datediff(max(date),min(date)) as '持股天数', 
sum(amount)/datediff(max(date),min(date)) as '日均利润' 
from stock group by code having sum(volume)=0 order by 净利润 DESC;
/*按持股天数*/
select code,sum(amount) as '净利润', 
min(date) as '首次交易日期', max(date) as '最后交易日期', 
datediff(max(date),min(date)) as '持股天数', 
sum(amount)/datediff(max(date),min(date)) as '日均利润' 
from stock group by code having sum(volume)=0 order by 持股天数 DESC;
----------------------------------------------------------------------------------------------------------------------------------------
/*未清仓股票成本分析*/
select code,name,sum(amount) as '总成本/已获得收益',min(date) as '首次交易日期',max(date) as '最近交易日期',datediff(curdate(),min(date)) as '当前持股天数' from stock group by code having sum(volume)!=0 order by sum(amount) desc

/*增加新交易记录*/
insert into stock(date,code,name,operation,volume,balance,price,turnover,amount,brokerage,stamps,transfer_fee)
VALUES
('2021-04-07','001896','豫能控股','证券卖出',-1000, 15600,  10.27,  10270,  10254.73,  5,  10.27,  0.21),
('2021-04-07','600051','宁波联合','证券卖出',-1200, 27300,  8.58,  10296,  10280.49,  5,  10.3,  0.21);