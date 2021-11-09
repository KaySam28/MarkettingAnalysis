--Going through the general data
Select*
from [dbo].[marketing_data$]

select *
select cast (dt_customer as date) 
from [dbo].[marketing_data$]

--Total Items purchased through the various means used by the company
select sum(numwebpurchases) as WebPurchases,sum(numdealspurchases) as DealPurchases, sum(numcatalogpurchases) as CatalogPurchases, sum(numstorepurchases) as StorePurchases
from dbo.marketing_data$

--After the previous querry shows that web purchases was the highest, the next set of querries is to find the various items bought through the web
--Total Amount of Wine purchased online
 select sum(numwebpurchases) as TotalWebWinePurchases
 from dbo.marketing_data$
 where mntwines in (NumWebpurchases)


 --Total amount of fruits bought online
  select sum(numwebpurchases) as TotalWebFruitPurchases
 from dbo.marketing_data$
 where mntfruits in (NumWebpurchases)

 --Total amount of meat abought online
  select sum(numwebpurchases) as TotalWebMeatPurchases
 from dbo.marketing_data$
 where MntMeatProducts in (NumWebpurchases)


 --Total amount of fish bought online
  select sum(numwebpurchases) as TotalWebFishPurchases
 from dbo.marketing_data$
 where MntFishProducts in (NumWebpurchases)

 --Total amount of sweets bought online
  select sum(numwebpurchases) as TotalWebSweetPurchases
 from dbo.marketing_data$
 where MntSweetProducts in (NumWebpurchases)

 --Total amount of gold products bought online
  select sum(numwebpurchases) as TotalWebGoldProductsPurchases
 from dbo.marketing_data$
 where MntGoldProds in (NumWebpurchases)


--Most succesful product by price
 select 
		sum(mntwines) as Wine,
		sum (mntfruits) as Fruits,
		sum( MntMeatProducts) as Meat,
		sum(mntFishProducts) as Fish,
		sum(MntSweetProducts) as Sweets,
		sum( MntGoldProds) as GoldProduct
from [dbo].[marketing_data$]


--Finding how much of the prevous querry were made from the web
 select 
		sum(mntwines) as WineWeb,
		sum (mntfruits) as FruitsWeb,
		sum( MntMeatProducts) as MeatWeb,
		sum(mntFishProducts) as FishWeb,
		sum(MntSweetProducts) as SweetsWeb,
		sum( MntGoldProds) as GoldProductWeb
from [dbo].[marketing_data$]
where NumWebPurchases IN (MntWines,
							MntFruits,
							MntMeatProducts,
							MntFishProducts,
							MntSweetProducts,
							MntGoldProds)


--Response rate
--Total number of people who accepted after the last campaign
select count(*) as LastCampaign
from dbo.marketing_data$
where Response = '1'

--Total number of people who accepted after the First campaign
select count (*) as Rate1
from dbo.marketing_data$
where AcceptedCmp1 = '1'

--Total number of people who accepted after the second campaign
select count (*) as Rate2
from dbo.marketing_data$
where AcceptedCmp2 = '1'

--Total number of people who accepted after the third campaign
select count (*) as Rate3
from dbo.marketing_data$
where AcceptedCmp3 = '1'

--Total number of people who accepted after the fourth campaign
select count (*) as Rate4
from dbo.marketing_data$
where AcceptedCmp4 = '1'

--Total number of people who accepted after the fifth campaign
select count (*) as Rate5
from dbo.marketing_data$
where AcceptedCmp5  = '1'

--Main question-- What does the avergae customer looks like

--Sub questions 1. Average birth year of our customers
select round(avg(year_birth),0)
from dbo.marketing_data$

--Education level of our customers
select  count (education) Edu, Education
from dbo.marketing_data$
group by Education
order by Edu desc


--Avergae Income of our customers
select avg([ Income ])
from dbo.marketing_data$

--Marital Sttus in relation to the number of children at home
SELECT Marital_Status,count(marital_status) as Number ,kidhome,Teenhome
FROM [dbo].[marketing_data$]
group by Marital_Status,Kidhome,Teenhome
order by Marital_Status

-- Revenue by marital status
Select marital_status, sum([ Income ]) as MaritalIncome
from [dbo].[marketing_data$]
group by Marital_Status
order by MaritalIncome desc


--Avergae Spending by each year group
SELECT
	case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1925' and '1980' then 'Silent Generation' 
		else 'nothing'
		end as 'Generation',
	avg(MntWines) Wine, 
avg(MntFruits) Fruits,
avg(MntMeatProducts) Meat,
avg(MntFishProducts) Fish,
avg(MntSweetProducts) Sweets,
avg(MntGoldProds) Gold
FROM [dbo].[marketing_data$]
GROUP BY case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1925' and '1980' then 'Silent Generation' 
		else 'nothing'
		end

--Total number of purchASES
select sum(NumCatalogPurchases+NumStorePurchases+NumWebPurchases) as TotalPurchases
from [dbo].[marketing_data$]

--Revenue by product
select marital_status,sum(mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods) as MaritalTotal
from [dbo].[marketing_data$]
group by Marital_Status
order by MaritalTotal desc

--Revenue by country per product
SELECT
	Country,
	sum(MntWines) Wine,
	sum(MntFruits) Fruits, 
sum(MntMeatProducts) Meat,
sum(MntFishProducts) Fish,
sum(MntSweetProducts) Sweets,
sum(MntGoldProds) Gold
FROM [dbo].[marketing_data$]
group by Country

--Total revenue per country
select 
		distinct country,
		sum(mntwines+ MntFruits+MntMeatProducts+MntFishProducts+MntSweetProducts+MntGoldProds) as Total
from [dbo].[marketing_data$]
group by country
order by total desc


--Total Purchases by Generation
SELECT 
	case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1965' and '1980' then 'Gen X' 
		else 'nothing'
		end as 'Generation',
		sum(mntwines +mntfruits + mntmeatproducts +mntfishproducts +mntsweetproducts +mntgoldprods) AS Products
from [dbo].[marketing_data$]
GROUP BY case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1965' and '1980' then 'Gen X' 
		else 'nothing'
		end 
ORDER BY PRODUCTS DESC



--Average price spent on each prodcut grouped by each generation
SELECT 
	case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1965' and '1980' then 'Gen X' 
		else 'nothing'
		end as 'Generation',
			avg(MntWines) Wine, 
avg(MntFruits) Fruits,
avg(MntMeatProducts) Meat,
avg(MntFishProducts) Fish,
avg(MntSweetProducts) Sweets,
avg(MntGoldProds) Gold
from [dbo].[marketing_data$]
GROUP BY case
		when Year_Birth between '1928' and '1945' then 'Silent Generation' 
		when Year_Birth between '1981' and '1996' then 'Milennials' 
		when Year_Birth between '1946' and '1964' then 'Boomers'
		when Year_Birth between '1965' and '1980' then 'Gen X' 
		else 'nothing'
		end 
