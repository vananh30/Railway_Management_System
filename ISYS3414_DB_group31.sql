-- Create table Passenger
CREATE TABLE Passenger(
 passengerid VARCHAR(10),
 passenger_name VARCHAR(50) NOT NULL,
 nationalid VARCHAR(10) NOT NULL,
 dob date NOT NULL,
 phone VARCHAR(10)  NOT NULL,
 email VARCHAR(250),
 address VARCHAR(250),

 CONSTRAINT pk_passenger PRIMARY KEY(passengerid)
);


-- Create table Ticket
CREATE TABLE Ticket(
 ticketid VARCHAR(10),
 tripid VARCHAR(10) NOT NULL,
 seatid VARCHAR(10) NOT NULL,
 carriageid VARCHAR(10) NOT NULL,
 price int NOT NULL,
 -- 
 CONSTRAINT pk_ticket PRIMARY KEY(ticketid)
);


-- Create table Seat
CREATE TABLE Seat(
   seatid     VARCHAR(10),
   carriageid VARCHAR(10),
   -- 
   CONSTRAINT seat_pk PRIMARY KEY (seatid,carriageid)
);


-- Creat table Staff
CREATE TABLE Staff(
   staffid VARCHAR(10),
   staff_name VARCHAR(50) NOT NULL,
   nationalid VARCHAR(10) NOT NULL,
   dob date NOT NULL,
   phone VARCHAR(10) NOT NULL,
   email VARCHAR(50),
   address VARCHAR(50),
   trainid VARCHAR(10),
   position VARCHAR(50),
   username VARCHAR(10),
   password VARCHAR(10),
 -- 
 CONSTRAINT pk_staff PRIMARY KEY(staffid)
);


-- Create table Carriage
CREATE TABLE Carriage (
  carriageid VARCHAR(10) NOT NULL ,
  trainid VARCHAR(10) NOT NULL ,
  carriage_type VARCHAR(50) NOT NULL ,
  number_of_seats int NOT NULL ,
  -- 
  CONSTRAINT carriage_pk PRIMARY KEY (carriageid)
);


-- Create table Station
CREATE TABLE Station(
  stationid VARCHAR(10),
  station_name VARCHAR(50),
  address VARCHAR(50),
  location VARCHAR(50),
-- 
  CONSTRAINT pk_stationid PRIMARY KEY (stationid)
);


-- Create table Train
CREATE TABLE Train (
trainid VARCHAR(10),
status VARCHAR(50),
number_of_carriages int,
    -- 
CONSTRAINT pk_trains PRIMARY KEY(trainid)
);


-- Create table Trip
CREATE TABLE Trip(
 tripid VARCHAR(10),
 trainid VARCHAR(10) NOT NULL,
 depart_time timestamp NOT NULL,
 arrive_time timestamp NOT NULL,
 origin_stationid VARCHAR(10) NOT NULL,
 destination_stationid VARCHAR(10) NOT NULL,
 -- 
 CONSTRAINT pk_trip PRIMARY KEY(tripid)
);


-- Create table Ticket_order
CREATE TABLE Ticket_order(
	orderid VARCHAR(10),
    ticketid VARCHAR(10),
    passengerid VARCHAR(10),
    purchase_date date NOT NULL,
    payment_type VARCHAR(50),
    
    CONSTRAINT pk_ticket_order PRIMARY KEY(orderid)
);



-- add foreign key table Ticket
ALTER TABLE Ticket
ADD CONSTRAINT fk_tripid_ticket
FOREIGN KEY (tripid)
REFERENCES Trip (tripid)
ON DELETE CASCADE;

ALTER TABLE Ticket
ADD CONSTRAINT fk_seatid_ticket
FOREIGN KEY (seatid, carriageid)
REFERENCES Seat (seatid, carriageid)
ON DELETE CASCADE;



-- add foreign key table Seat
ALTER TABLE Seat
ADD CONSTRAINT fk_seatid_carriage
FOREIGN KEY (carriageid)
REFERENCES Carriage (carriageid)
ON DELETE CASCADE;



-- add foreign key table Trip
ALTER TABLE Trip
ADD CONSTRAINT fk_strainid_trips
FOREIGN KEY (trainid)
REFERENCES Train(trainid)
ON DELETE CASCADE;

ALTER TABLE Trip
ADD CONSTRAINT fk_ORIGIN_STATIONID_trips
FOREIGN KEY (ORIGIN_STATIONID)
REFERENCES Station (stationid)
ON DELETE CASCADE;

ALTER TABLE Trip
ADD CONSTRAINT fk_DESTINATION_STATIONID_trips
FOREIGN KEY (DESTINATION_STATIONID)
REFERENCES Station (stationid)
ON DELETE CASCADE;


-- add foreign key table Staff
ALTER TABLE Staff
ADD CONSTRAINT fk_trainid
FOREIGN KEY (trainid)
REFERENCES Train (trainid)
ON DELETE CASCADE;


-- add foreign key table Carriage
ALTER TABLE Carriage
ADD CONSTRAINT fk_trainid_carriage
FOREIGN KEY (trainid)
REFERENCES Train(trainid)
ON DELETE CASCADE;


-- add foreign key table Ticket_order
ALTER TABLE Ticket_order
ADD CONSTRAINT fk_order
FOREIGN KEY (ticketid)
REFERENCES Ticket(ticketid)
ON DELETE CASCADE; 

ALTER TABLE Ticket_order
ADD CONSTRAINT fk_passengerid
FOREIGN KEY (passengerid)
REFERENCES Passenger(passengerid)
ON DELETE CASCADE; 


-- Insert value of table Station(stationid, station_name, address, location)
INSERT INTO Station(stationid, station_name, address, location)
 select 'ST01','Ha Noi', '120 Le Duan', 'Ha Noi' from dual union all 
 select 'ST02','Vinh', 'Le Ninh, Vinh City , Nghe An Province', 'Vinh' from dual union all 
 select 'ST03','Da Nang', '791 Hai Phong, Tam Thuan, Thanh Khe', 'Da Nang' from dual union all 
 select 'ST04','Sai Gon', '1 Nguyen Thong', 'Ho Chi Minh' from dual;

-- Insert value of table Train(trainid, status, number_of_carriages)
INSERT INTO Train(trainid, status, number_of_carriages)
 select 'T01','Available',2 from dual union all 
 select 'T02','Available',3 from dual union all 
 select 'T03','Available',3 from dual;

-- Insert value of table Staff(staffid,staff_name, nationalid, dob, phone, email, address, trainid,position,username, password)
INSERT INTO Staff(staffid,staff_name, nationalid, dob, phone, email, address, trainid, position,username, password)
 select 'STF02', 'Huynh Van Anh', '025922345', 		    TO_DATE ('2001-05-20' , 'yyyy-mm-dd'),  '0944534315', 's3819545@rmit.edu.vn', 		'45 3/2 W10 D3 HCMC', 			'T01', 'Staff',	  'vananh',	'123456z'	from dual union all 
 select 'STF03', 'La Tran Hai Dang', '029770192', 	    TO_DATE ('2001-07-31' , 'yyyy-mm-dd'),  '0973758578', 's3839521@rmit.edu.vn',		'256/7 Nguyen Van Cu W10 D1 HCMC', 	'T02', 'Captain', 'haidang',	'zzhya123' 	from dual union all 
 select 'STF04', 'Tran Duy Long', '028923612', 		    TO_DATE ('1994-03-16' , 'yyyy-mm-dd'),  '0911459596', 's3818521@rmit.edu.vn',		'33 CMT8 W2 D3 HCMC', 			'T01', 'Captain', 'duylong',	'DLduy995' 	from dual union all 
 select 'STF05', 'John Smith', '026689915', 		    TO_DATE ('1991-03-23' , 'yyyy-mm-dd'),  '0955294979', 'jonhsmith@gmail.com',		'456 CMT8 W2 D3 HCMC', 			'T03', 'Staff',   'john66',	'nweig13' 	from dual union all 
 select 'STF06', 'John Cena', '025088143', 		        TO_DATE ('2000-08-17' , 'yyyy-mm-dd'),  '0934016760', 'jonhcena@yahoo.com',		'222 Nguyen Huu Tho W10 D1 HCMC', 	'T02', 'Staff',   'cena885',	'9349725' 	from dual union all 
 select 'STF07', 'Selena Gomez', '023407933', 		    TO_DATE ('1999-09-15' , 'yyyy-mm-dd'),  '0919009461', 'elena@gmail.com',			'48 Lam Van Ben W10 D1 HCMC', 		'T02', 'Staff',   'gomez', 	'llggg322'	from dual union all 
 select 'STF08', 'Luis Suarez', '024667214', 		    TO_DATE ('1987-01-29' , 'yyyy-mm-dd'),  '0947997048', 'suarez456@yahoo.com',		'41 Lam Van Ben W10 D1 HCMC', 		'T03', 'Staff',   'luis',	'lol20gg' 	from dual union all 
 select 'STF09', 'James Rodriguez', '026490058', 	    TO_DATE ('1987-11-16' , 'yyyy-mm-dd'),  '0965995583', 'jame223@gmail.com',		'49 Lam Van Ben W10 D1 HCMC', 		'T01', 'Staff',   'james889',	'20ffggjohn' 	from dual union all 
 select 'STF10', 'Nguyen Thanh Long', '024196249', 	    TO_DATE ('1985-11-12' , 'yyyy-mm-dd'),  '0935191050', 'nguyenlong@yahoo.com',		'41 3/2 W10 D3 HCMC', 			'T02', 'Staff',   'long123',	'1243ewrrf' 	from dual union all 
 select 'STF11', 'Nguyen Ngoc Kim Trang', '020197846', 	TO_DATE ('1987-01-7'  ,  'yyyy-mm-dd'), '0954788140', 'kimtrang782001@gmail.com.vn',	'231 Le Hong Phong W1 D10 HCMC',	'T01', 'Staff',   'ang999',	'qwerty' 	from dual union all 
 select 'STF12', 'Diep Van', '022377861', 		        TO_DATE ('1985-02-5'  ,  'yyyy-mm-dd'), '0929836944', 'diepvan69@gmail.com',		'87 Le Van Luong W10 D1 HCMC', 		'T01', 'Staff',   'diepvan1',	'61ngwwww' 	from dual union all 
 select 'STF13', 'Macro Verratti', '022471519', 	    TO_DATE ('1984-03-26' , 'yyyy-mm-dd'),  '0947090324', 'verratti@gmail.com.vn',		'11 Hoang Hoa Tham W7 D3 HCMC', 	'T03', 'Staff',   'macro1',	'987234vvv' 	from dual union all 
 select 'STF14', 'Jeff Bezos', '022507505', 		    TO_DATE ('1986-04-30' , 'yyyy-mm-dd'),  '0992328407', 'jeff@yahoo.com',			'221 Nguyen Huu Tho W10 D1 HN', 	'T01', 'Staff',   'jeff990',	'ohnoba' 	from dual union all 
 select 'STF15', 'Ethan Hawke', '021941359', 		    TO_DATE ('1983-07-6'  ,  'yyyy-mm-dd'), '0965305198', 'ethan@gmail.com.vn',		'99 Nguyen Khanh W11 D2 HCMC', 		'T02', 'Staff',   'gg123',	'232233' 	from dual;


-- Insert value of table Carriage(carriageid, trainid, carriage_type, number_of_seats)
INSERT INTO Carriage(carriageid, trainid, carriage_type, number_of_seats)
 select 'CR01', 'T01','Passenger', 5 from dual union all 
 select 'CR02', 'T01','Passenger', 5 from dual union all 
 select 'CR03', 'T02','Passenger', 5 from dual union all 
 select 'CR04', 'T02','Passenger', 5 from dual union all 
 select 'CR05', 'T02','Business',  5 from dual union all 
 select 'CR06', 'T03','Sleeper',   5 from dual union all 
 select 'CR07', 'T03','Freight',   0 from dual union all 
 select 'CR08', 'T03','Business',  5 from dual;
     
-- Insert value of table Seat(seatid, carriageid)
INSERT INTO Seat(seatid, carriageid)
 select 'S01','CR01' from dual union all 
 select 'S02','CR01' from dual union all 
 select 'S03','CR01' from dual union all 
 select 'S04','CR01' from dual union all 
 select 'S05','CR01' from dual union all 
 select 'S01','CR02' from dual union all 
 select 'S02','CR02' from dual union all 
 select 'S03','CR02' from dual union all 
 select 'S04','CR02' from dual union all 
 select 'S05','CR02' from dual union all 
 select 'S01','CR03' from dual union all 
 select 'S02','CR03' from dual union all 
 select 'S03','CR03' from dual union all 
 select 'S04','CR03' from dual union all 
 select 'S05','CR03' from dual union all 
 select 'S01','CR04' from dual union all 
 select 'S02','CR04' from dual union all 
 select 'S03','CR04' from dual union all 
 select 'S04','CR04' from dual union all 
 select 'S05','CR04' from dual union all 
 select 'S01','CR05' from dual union all 
 select 'S02','CR05' from dual union all 
 select 'S03','CR05' from dual union all 
 select 'S04','CR05' from dual union all 
 select 'S05','CR05' from dual union all 
 select 'S01','CR06' from dual union all 
 select 'S02','CR06' from dual union all 
 select 'S03','CR06' from dual union all 
 select 'S04','CR06' from dual union all 
 select 'S05','CR06' from dual union all 
 select 'S01','CR08' from dual union all 
 select 'S02','CR08' from dual union all 
 select 'S03','CR08' from dual union all 
 select 'S04','CR08' from dual union all 
 select 'S05','CR08' from dual;

-- Insert value of table Trip(tripid, trainid, depart_time, arrive_time, origin_stationid, destination_stationid)
INSERT INTO Trip(tripid, trainid, depart_time, arrive_time, origin_stationid, destination_stationid)
 select 'TR01','T03', TO_DATE ('2021-01-01 08:30:00'  , 'yyyy/mm/dd hh24:mi:ss'), TO_DATE ('2021-01-01 17:10:00' , 'yyyy/mm/dd hh24:mi:ss'), 'ST01', 'ST02' from dual union all 
 select 'TR02','T01', TO_DATE ('2021-01-02 09:30:00'  , 'yyyy/mm/dd hh24:mi:ss'), TO_DATE ('2021-01-02 19:10:00' , 'yyyy/mm/dd hh24:mi:ss'), 'ST02', 'ST03' from dual union all 
 select 'TR03','T02', TO_DATE ('2021-01-03 10:30:00'  , 'yyyy/mm/dd hh24:mi:ss'), TO_DATE ('2021-01-04 06:10:00' , 'yyyy/mm/dd hh24:mi:ss'), 'ST03', 'ST04' from dual union all 
 select 'TR04','T03', TO_DATE ('2021-01-04 11:30;00'  , 'yyyy/mm/dd hh24:mi:ss'), TO_DATE ('2021-01-05 07:10:00' , 'yyyy/mm/dd hh24:mi:ss'), 'ST04', 'ST03' from dual union all 
 select 'TR05','T01', TO_DATE ('2021-01-05 12:30:00'  , 'yyyy/mm/dd hh24:mi:ss'), TO_DATE ('2021-01-06 00:10:00' , 'yyyy/mm/dd hh24:mi:ss'), 'ST03', 'ST02' from dual;

-- Insert value of table Passenger(passengerid,	passenger_name,	nationalid,	dob	,phone,	email,	address)
INSERT INTO Passenger(passengerid,	passenger_name,	nationalid,	dob	,phone,	email,	address)
 select 'PA19',	'Luc Cam Quynh'	            ,7920020131,	TO_DATE ('2001-04-27' , 'yyyy-mm-dd'),	0774131018,	'camquynh.luc@gmail.com'	        ,'41/1 Nguyen Binh Khiem, W Da Kao, D1, HCMC' from dual union all 
 select 'PA18',	'Tran Hoang Mai'	        ,8020320562,	TO_DATE ('1999-07-05' , 'yyyy-mm-dd'),	0983298298,	'thm.1999@gmail.com'	            ,'136/10 Le Thanh Ton, W Ben Thao, D1, HCMC' from dual union all 
 select 'PA17',	'Nguyen Phuong Binh'	    ,3715300257,	TO_DATE ('1997-02-16' , 'yyyy-mm-dd'),	0384138089,	'binh_nguyen97@gmail.com'	        ,'162/3 Xuân Trường 1, Xuân Trường, thành phố Đà Lạt, tỉnh Lâm Đồng' from dual union all 
 select 'PA16',	'Le Tran Thanh Chau'	    ,4820039215,	TO_DATE ('1999-06-14' , 'yyyy-mm-dd'),	0908741146,	'bechau99_le@gmail.com'	            ,'1241, đường Quốc Lộ 30, khóm 01, phường 11, TP. Cao Lãnh, tỉnh Đồng Tháp' from dual union all 
 select 'PA15',	'Nguyen Thu Lam'	        ,7960420261,	TO_DATE ('2000-08-04' , 'yyyy-mm-dd'),	0905650719,	'lam_nguyenthu@yahoo.com.vn'	    ,'Cụm 5, xã Vân Phúc, H. Phúc Thọ, Tp. Hà Nội' from dual union all 
 select 'PA14',	'My Uyen Pham'	            ,9743706582,	TO_DATE ('2000-05-17' , 'yyyy-mm-dd'),	0982311434,	'myuyenpham2k@gmail.com'	        ,'Số 87, Đường Núi Đôi, Tổ 2, TT. Sóc Sơn, H. Sóc Sơn, Tp. Hà Nội' from dual union all 
 select 'PA13',	'Pham Thi Xuan Quynh'	    ,8066216583,	TO_DATE ('1988-12-24' , 'yyyy-mm-dd'),	0378290397,	'crystal.diamond1998@icloud.com'	,'Số 173, Phố Ngô Quyền, P.Ngô Quyền, TX.Sơn Tây. TP. Hà Nội' from dual union all 
 select 'PA12',	'Nguyen Ngoc Tuyet Ngan'	,3988726585,	TO_DATE ('2000-01-26' , 'yyyy-mm-dd'),	0908938376,	'nguyentuyet.ngan@gmail.com'	    ,'Xóm Thành Tâm, xã Đồng Văn, Huyện Đồng Văn, Tỉnh Hà Giang' from dual union all 
 select 'PA11',	'Tran Thanh Vy'	            ,6111336587,	TO_DATE ('2001-01-12' , 'yyyy-mm-dd'),	0856714427,	'ttv.12012001@gmail.com'	        ,'Thôn Phù Tải, xã Thanh Giang, huyện Thanh Miện, tỉnh Hải Dương' from dual union all 
 select 'PA10',	'Huynh Phuong Anh'	        ,8233746589,	TO_DATE ('1993-12-19' , 'yyyy-mm-dd'),	0888798963,	'anhhuynh1993@gmail.com'	        ,'Số 170 Đường ĐT741, đội 3, thôn Đăk Lim, xã Đăk Ơ, Huyện Bù Gia Mập, Tỉnh Bình Phước' from dual union all 
 select 'PA09',	'Ha Trieu Vy'	            ,2564565910,	TO_DATE ('2001-10-07' , 'yyyy-mm-dd'),	0932515601,	'blackpink2001@gmail.com'	        ,'Ấp Mỹ Hòa, xã Nhơn Mỹ, Huyện Chợ Mới, Tỉnh An Giang' from dual union all 
 select 'PA08',	'Le Quang Vinh'	            ,2248766593,	TO_DATE ('1999-08-01' , 'yyyy-mm-dd'),	0777967369,	'vinhlequang@gmail.com'	            ,'Thôn Phúc Lộc, xã Phú Lộc, huyện Nho Quan, tỉnh Ninh Bình' from dual union all 
 select 'PA07',	'Truong The Son'	        ,2460127659,	TO_DATE ('1995-11-22' , 'yyyy-mm-dd'),	0852555000,	'son.truongthe@gmail.com'	        ,'Ấp Diêm Điền, xã Điền Hải, huyện Đông Hải, tỉnh Bạc Liêu' from dual union all 
 select 'PA06',	'Nguyen Hoang Nhu Phuc'	    ,2672407865,	TO_DATE ('2000-04-13' , 'yyyy-mm-dd'),	0364332325,	'nhuphuc_nguyenhoang@gmail.com'	    ,'Xã Vĩnh Tân, Thị xã Tân Uyên, Tỉnh Bình Dương' from dual union all 
 select 'PA05',	'Nguyen Thuy Ngan'	        ,2884662959,	TO_DATE ('1989-06-10' , 'yyyy-mm-dd'),	0813402632,	'hgthuyngan@gmail.com'	            ,'Ấp Phú Hưng, Xã Phú Thuận, Huyện Bình Đại, Tỉnh Bến Tre' from dual union all 
 select 'PA04',	'Le Xuan Uyen'	            ,3096918660,	TO_DATE ('1992-10-02' , 'yyyy-mm-dd'),	0858888333,	'uyen_lexuan992@hotmail.com'	    ,'Ấp Thị, Xã Hương Mỹ, huyện Mỏ Cày Nam, tỉnh Bến Tre' from dual union all 
 select 'PA03',	'Le Thi Phuong Trinh'	    ,8020195730,	TO_DATE ('2001-05-10' , 'yyyy-mm-dd'),	0789989919,	'trinhrosiele2001@yahoo.com'	    ,'Đường NB5, Tổ 7, Ấp 4, Phường Vĩnh Tân, Thị xã Tân Uyên, Tỉnh Bình Dương' from dual union all 
 select 'PA02',	'Nguyen Thi Minh Hieu'	    ,3521428260,	TO_DATE ('1998-03-21' , 'yyyy-mm-dd'),	0836769809,	'hieunguyendeptrai@gmail.com'	    ,'Xóm Thành Tâm, xã Đồng Văn, Huyện Đồng Văn, Tỉnh Hà Giang' from dual union all 
 select 'PA01',	'Vu Dai Dung'	            ,3733683660,	TO_DATE ('1996-11-27' , 'yyyy-mm-dd'),	0784627360,	'dung.vu1996@gmail.com'	            ,'Thôn Phù Tải, xã Thanh Giang, huyện Thanh Miện, tỉnh Hải Dương' from dual;

-- Insert value of table Ticket(ticketid, tripid, seatid, carriageid, price)
 select 'TK01','TR01','S01','CR01',1300 from dual union all 
 select 'TK02','TR02','S02','CR01',1300 from dual union all 
 select 'TK03','TR03','S03','CR01',1300 from dual union all 
 select 'TK04','TR04','S04','CR01',1300 from dual union all
 select 'TK05','TR04','S04','CR08',1300 from dual union all
 select 'TK06','TR05','S05','CR01',1300 from dual union all 
 select 'TK07','TR01','S01','CR02',1300 from dual union all 
 select 'TK08','TR02','S02','CR02',1300 from dual union all 
 select 'TK09','TR03','S03','CR02',1300 from dual union all 
 select 'TK10','TR04','S04','CR02',1300 from dual union all 
 select 'TK11','TR05','S05','CR02',1300 from dual union all 
 select 'TK12','TR01','S01','CR03',1300 from dual union all 
 select 'TK13','TR02','S02','CR03',1300 from dual union all 
 select 'TK14','TR03','S03','CR03',1300 from dual union all 
 select 'TK15','TR04','S04','CR03',1300 from dual union all 
 select 'TK16','TR05','S05','CR03',1300 from dual union all 
 select 'TK17','TR01','S01','CR04',1300 from dual union all 
 select 'TK18','TR02','S02','CR04',1300 from dual union all 
 select 'TK19','TR03','S03','CR04',1300 from dual union all 
 select 'TK20','TR04','S04','CR04',1300 from dual union all 
 select 'TK21','TR05','S05','CR04',1300 from dual union all 
 select 'TK22','TR01','S01','CR05',3000 from dual union all 
 select 'TK23','TR02','S02','CR05',3000 from dual union all 
 select 'TK24','TR03','S03','CR05',3000 from dual union all 
 select 'TK25','TR04','S04','CR05',3000 from dual union all 
 select 'TK26','TR05','S05','CR05',3000 from dual union all 
 select 'TK36','TR01','S01','CR06',1300 from dual union all 
 select 'TK27','TR02','S02','CR06',1300 from dual union all 
 select 'TK28','TR03','S03','CR06',1300 from dual union all 
 select 'TK29','TR04','S04','CR06',1300 from dual union all 
 select 'TK30','TR05','S05','CR06',1300 from dual union all 
 select 'TK31','TR01','S01','CR08',3000 from dual union all 
 select 'TK32','TR02','S02','CR08',3000 from dual union all 
 select 'TK33','TR03','S03','CR08',3000 from dual union all 
 select 'TK34','TR05','S05','CR08',3000 from dual;


-- Insert value of table Ticket(ticketid, tripid, seatid, carriageid, price)
 INSERT INTO Ticket_order(orderid, ticketid, passengerid, purchase_date, payment_type)
 select 'OD01','TK28','PA01', TO_DATE ('2020-04-27' , 'yyyy-mm-dd'), 'Cash' from dual union all 
 select 'OD02','TK15','PA02', TO_DATE ('2020-04-28' , 'yyyy-mm-dd'), 'ATM'  from dual union all 
 select 'OD03','TK09','PA03', TO_DATE ('2020-04-29' , 'yyyy-mm-dd'), 'Cash' from dual union all 
 select 'OD04','TK08','PA04', TO_DATE ('2020-04-27' , 'yyyy-mm-dd'), 'ATM'  from dual union all 
 select 'OD05','TK11','PA05', TO_DATE ('2020-03-27' , 'yyyy-mm-dd'), 'ATM'  from dual union all 
 select 'OD06','TK06','PA06', TO_DATE ('2020-03-28' , 'yyyy-mm-dd'), 'Cash' from dual union all 
 select 'OD07','TK10','PA07', TO_DATE ('2020-03-29' , 'yyyy-mm-dd'), 'Cash' from dual union all 
 select 'OD08','TK13','PA08', TO_DATE ('2020-03-27' , 'yyyy-mm-dd'), 'ATM'  from dual union all 
 select 'OD09','TK03','PA09', TO_DATE ('2020-05-27' , 'yyyy-mm-dd'), 'Cash' from dual union all 
 select 'OD10','TK02','PA10', TO_DATE ('2020-05-28' , 'yyyy-mm-dd'), 'ATM'  from dual union all 
 select 'OD11','TK01','PA11', TO_DATE ('2020-05-29' , 'yyyy-mm-dd'), 'ATM'  from dual;







