

--Q1 Total trips?

select count(distinct(tripid)) as cnt from trips;

--Q2 total drivers?
select count(distinct(driverid)) as total_drivers from trips;

--Part 2

 --Q3 total earnings?

 select sum(fare) as total_earning from trips;

 --Q4 total completed trips?

 select count(distinct tripid) as total_completed_trips from trips;

 --Q5 total searches?

 select sum(searches) as total_searches from trips_details;

 --Q6 total searches which got estimate?

  select sum(searches_got_estimate) as total from trips_details;

-- Q7 total searches for quotes(Searches for drivers)?

select sum(searches_for_quotes) as total from trips_details;

--Q8 total searches which got quotes (got the driver)?

select sum(searches_got_quotes) as total from trips_details;

--Q9 total driver cancelled trips?

select count(*) - sum(driver_not_cancelled) as total_driver_cancelled from trips_details;

--Q10 total otp entered?
select sum(otp_entered) as Total_otp_entered from trips_details;

-- Q11 total number of end-ride?
select sum(end_ride) as Total_end_ride from trips_details;

-- Average distance per trip

select avg(distance) as avg_distance from trips;

-- Average fair per trip

select avg(fare) as avg_fare from trips;

--total distance travelled

select sum(distance) as total_distance from trips;

-- which is the most used payment method?

select a.method,b.cnt from payment a inner join 
(select top 1 faremethod,count(faremethod) cnt from trips
group by faremethod
order by cnt desc)b
on a.id=b.faremethod;

-- the highest payment done through which instrument?
select a.method,b.faremethod from payment a inner join
(select top 1 * from trips order by fare desc) b
on a.id=b.faremethod;

-- which two locations had the most number of trip?

select * from
(select *,dense_rank() over(order by trip desc) rnk from
(select loc_from,loc_to,COUNT(distinct(tripid)) trip from trips
group by loc_from,loc_to
)a)b where rnk = 1;


-- top 5 earning drivers
select * from
(select *, dense_rank() over (order by total desc) rnk from
(select driverid,sum(fare) total from trips
group by driverid)a)b where rnk <6;
;

--which duration had more trips
select * from
(select *,dense_rank() over(order by cnt desc) rnk from
(select duration,count(distinct tripid) cnt from trips
group by duration)a)b
where rnk = 1;

-- which driver,customer pair have the more orders?

select * from
(select *,dense_rank() over(order by cnt desc) rnk from
(select driverid,custid,count(tripid) cnt from trips
group by driverid,custid)a)b
where rnk = 1;

-- searches to estimate rate?
select (sum(searches_got_estimate)*1.0/sum(searches))*100 from trips_details;

-- which area got the highest trips in which duration? (Doubt)
select * from
(select *, rank() over (partition by duration order by cnt desc) rnk from
(select duration,loc_from,count(distinct(tripid)) cnt from trips
group by loc_from,duration)a)b
where rnk = 1;

-- which duration got the highest number of trips in each of the location present?
use mine
select * from
(select *, rank() over (partition by loc_from order by cnt desc) rnk from
(select duration,loc_from,count(distinct(tripid)) cnt from trips
group by loc_from,duration)a)b
where rnk = 1;

-- which area got the highest fares,cancellation,trips;
select * from
(select *, rank() over (order by fare desc) rnk from
(select loc_from,sum(fare) fare from trips
group by loc_from)a)b
where rnk = 1;

select * from
(select *, rank() over (order by fare desc) rnk from
(select loc_from,sum(fare) fare from trips
group by loc_from)a)b
where rnk = 1;

select * from
(select *, rank() over (order by can desc) rnk from
(select loc_from,count(*) - sum(driver_not_cancelled) can from trips_details
group by loc_from)a)b
where rnk = 1;

select * from
(select *, rank() over (order by can desc) rnk from
(select loc_from,count(*) - sum(customer_not_cancelled) can from trips_details
group by loc_from)a)b
where rnk = 1;



select * from
(select *, rank() over (order by cnt desc) rnk from
(select loc_from,count(tripid) cnt from trips
group by loc_from)a)b
where rnk = 1;



--which duration got the highest trips and fares?

select * from
(select *, rank() over (order by fare desc) rnk from
(select duration,sum(fare) fare from trips
group by duration)a)b
where rnk = 1;

select * from
(select *, rank() over (order by fare desc) rnk from
(select duration,count(tripid) fare from trips
group by duration)a)b
where rnk = 1;















