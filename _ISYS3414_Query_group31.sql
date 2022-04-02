-- Trip Details
SELECT T.tripid, T.trainid, T.depart_time, T.arrive_time, S1.station_name from_station, S2.station_name to_station
FROM Trip T
   LEFT JOIN  Station S1 ON S1.stationid = T.origin_stationid
   LEFT JOIN  Station S2 ON S2.stationid = T.destination_stationid;



--  Available Seats of each Carriage
select cr.carriageid, count(s.carriageid),cr.trainid
from Seat s, Ticket tk, Carriage cr
where (tk.seatid = s.seatid and tk.carriageid = s.carriageid and cr.carriageid = tk.carriageid
and (s.seatid, s.carriageid) not in ( select tk.seatid, tk.carriageid
									from Ticket_order t, Ticket tk
									where tk.ticketid = t.ticketid))
group by cr.carriageid, cr.trainid;



--  Number of Ticket Sale by Month
select to_char(T.purchase_date, 'YYYY') Year, to_char(T.purchase_date, 'MM') Month, count(TK.ticketid) Quantity, sum(Tk.price) Monthly_Recurring_Revenue
from ticket_order T, ticket Tk
where Tk.ticketid = T.ticketid
group by to_char(T.purchase_date, 'YYYY'), to_char(T.purchase_date, 'MM')
order by to_number(to_char(T.purchase_date, 'YYYY')) desc, to_number(to_char(T.purchase_date, 'MM')) desc;



-- Available Seats by Carriage Type
select  c.carriage_type, count(c.carriage_type ) as Total
from seat s, ticket tk1, carriage c
where tk1.seatid = s.seatid and tk1.carriageid = s.carriageid and c.carriageid = tk1.carriageid
and (s.seatid, s.carriageid) not in ( select tk.seatid, tk.carriageid
									from ticket_order t, ticket tk
									where tk.ticketid = t.ticketid)
group by c.carriage_type; 



-- Monthly Recurring Renevue (Line Chart)
select to_number(to_char(T.purchase_date, 'YYYY')) Year, to_number(to_char(T.purchase_date, 'MM')) Month, count(TK.ticketid) Quantity, sum(Tk.price) Monthly_Recurring_Revenue
from ticket_order T, ticket Tk
where Tk.ticketid = T.ticketid
and to_char(T.purchase_date, 'YYYY') = '2020'
group by to_number(to_char(T.purchase_date, 'YYYY')), to_number(to_char(T.purchase_date, 'MM'))
order by to_number(to_char(T.purchase_date, 'MM'));



-- Available Seats by Carriage Type (Bar Chart)
select  c.carriage_type, count(c.carriage_type ) as Total
from seat s, ticket tk1, carriage c
where tk1.seatid = s.seatid and tk1.carriageid = s.carriageid and c.carriageid = tk1.carriageid
and (s.seatid, s.carriageid) not in ( select tk.seatid, tk.carriageid
									from ticket_order t, ticket tk
									where tk.ticketid = t.ticketid)
group by c.carriage_type; 



-- Number of Passenger by Trip (Bar chart)
select Tr.tripid Trip, count(Tko.orderid) "Number of Passengers"
from Trip Tr, Ticket_order Tko, Ticket Tk
where Tko.ticketid = Tk.ticketid and Tk.tripid = Tr.tripid
group by Tr.tripid;



-- Ticket Status (Pie Chart)
select 'Purchased Ticket',count(*) Total
from ticket_order T, ticket Tk
where Tk.ticketid = T.ticketid
union
select 'Remaining Ticket',count(*) as Name
from ticket Tk
where Tk.ticketid not in (select T1.ticketid from ticket_order T1)