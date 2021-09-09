CREATE TABLE Country (
    CountryCode CHAR(2) NOT NULL PRIMARY KEY,
    CountryName VARCHAR(30)
    );

commit;

select * from Country;

CREATE TABLE City (
    CityCode CHAR(3) NOT NULL PRIMARY KEY,
    CityName VARCHAR2(30),
    CountryCode CHAR(2),
    CONSTRAINT CountryFK FOREIGN KEY (CountryCode)
    REFERENCES Country(CountryCode)
    );
    
select * from City;    

commit;

CREATE TABLE AircraftType (
    TypeID CHAR(4) NOT NULL PRIMARY KEY,
    Manufacturer VARCHAR2(30),
    ACRange NUMBER(11),
    SeatCap NUMBER(11)
    );
    
commit;

CREATE TABLE Airline (
    ALCode VARCHAR2(30) NOT NULL PRIMARY KEY,
    ALName VARCHAR2(30),
    Headquarter CHAR(3),
    CONSTRAINT HQ_CityFK FOREIGN KEY (Headquarter)
    REFERENCES City(CityCode)
    );
    
commit;

CREATE TABLE Aircraft (
    ACNo VARCHAR2(6) NOT NULL PRIMARY KEY,
    IRN VARCHAR2(10),
    ACName VARCHAR2(30),
    DOE DATE,
    ACType CHAR(4),
    Airline VARCHAR2(3),
    CONSTRAINT ACTypeFK FOREIGN KEY (ACType)
    REFERENCES AircraftType(TypeID),
    CONSTRAINT AirlineFK FOREIGN KEY (Airline)
    REFERENCES Airline(ALCode)
    );
    
commit;

CREATE TABLE ACRow (
    ACRowID VARCHAR2(10) NOT NULL PRIMARY KEY,
    ACRowNo NUMBER(11),
    RowClass CHAR(1),
    Smoke CHAR(1),
    Aircraft VARCHAR(6),
    CONSTRAINT AircraftFK FOREIGN KEY (Aircraft)
    REFERENCES Aircraft(ACNo)
    );
    
commit;

CREATE TABLE Seat (
    SeatID VARCHAR2(10) NOT NULL PRIMARY KEY,
    SeatDes CHAR(3),
    ACRow VARCHAR(10),
    CONSTRAINT ACRowFK FOREIGN KEY (ACRow)
    REFERENCES ACRow(ACRowID)
    );
    
commit;

CREATE TABLE Airport (
    APCode CHAR(3) NOT NULL PRIMARY KEY,
    APName VARCHAR2(30),
    Capacity NUMBER(11),
    City CHAR(3),
    CONSTRAINT CityFK FOREIGN KEY (City)
    REFERENCES City(CityCode)
    );
    
commit;

CREATE TABLE APDistance (
    DisID VARCHAR2(10) NOT NULL PRIMARY KEY,
    AP1 CHAR(3),
    AP2 CHAR(3),
    CONSTRAINT AP1FK FOREIGN KEY (AP1)
    REFERENCES Airport(APCode),
    CONSTRAINT AP2FK FOREIGN KEY (AP2)
    REFERENCES Airport(APCode)
    );
    
commit;

ALTER TABLE APDistance
ADD Distance NUMBER(11);

commit;

select * from APDistance;

CREATE TABLE Flight (
    FlightNo VARCHAR2(6) NOT NULL PRIMARY KEY,
    Airline VARCHAR2(3),
    Aircraft VARCHAR2(6),
    DepAP CHAR(3),
    ArrAP CHAR(3),
    CONSTRAINT Flight_AirlineFK FOREIGN KEY (Airline)
    REFERENCES Airline(ALCode),
    CONSTRAINT DepAPFK FOREIGN KEY (DepAP)
    REFERENCES Airport(APCode),
    CONSTRAINT ArrAPFK FOREIGN KEY (ArrAP)
    REFERENCES Airport(APCode)
    );
    
commit;

CREATE TABLE FlightPlan (
    UnitID VARCHAR2(10) NOT NULL PRIMARY KEY,
    Airport CHAR(3),
    Flight VARCHAR2(6),
    DepTime DATE,
    ArrTime DATE,
    CONSTRAINT FP_AirportFK FOREIGN KEY (Airport)
    REFERENCES Airport(APCode),
    CONSTRAINT FP_FlightFK FOREIGN KEY (Flight)
    REFERENCES Flight(FlightNo)
    );
    
commit;

CREATE TABLE Schedule (
    ScheduleNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    Flight VARCHAR(6),
    DepTime CHAR(5),
    ArrTime CHAR(5),
    Frequency VARCHAR2(30),
    CONSTRAINT Schedule_FlightFK FOREIGN KEY (Flight)
    REFERENCES Flight(FlightNo)
    );
    
commit;

CREATE TABLE Passenger (
    PSGNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    PSGName VARCHAR2(30),
    Title VARCHAR2(30),
    Gender VARCHAR2(30),
    Age NUMBER(11),
    Nationality CHAR(2),
    CONSTRAINT Passenger_CountryFK FOREIGN KEY (Nationality)
    REFERENCES Country(CountryCode)
    );
    
commit;

CREATE TABLE SalesOffice (
    SOID VARCHAR2(10) NOT NULL PRIMARY KEY,
    SOName VARCHAR2(30)
    );
    
commit;

CREATE TABLE Ticket (
    TicketNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    Flight VARCHAR2(6),
    Passenger VARCHAR2(10),
    SalesOffice VARCHAR(10),
    DOI DATE,
    Price NUMBER(11),
    Currency CHAR(3),
    CONSTRAINT Ticket_FlightFK FOREIGN KEY (Flight)
    REFERENCES Flight(FlightNo),
    CONSTRAINT Ticket_PassengerFK FOREIGN KEY (Passenger)
    REFERENCES Passenger(PSGNo),
    CONSTRAINT Ticket_SalesOfficeFK FOREIGN KEY (SalesOffice)
    REFERENCES SalesOffice(SOID)
    );
    
commit;

CREATE TABLE BoardingTicket (
    BTNo VARCHAR2(10) NOT NULL PRIMARY KEY,
    Passenger VARCHAR2(10),
    DateTime DATE,
    DepAP CHAR(3),
    ArrAP CHAR(3),
    Seat VARCHAR(10),
    Smoke CHAR(1),
    CONSTRAINT BT_PassengerFK FOREIGN KEY (Passenger)
    REFERENCES Passenger(PSGNo),
    CONSTRAINT BT_DepAPFK FOREIGN KEY (DepAP)
    REFERENCES Airport(APCode),
    CONSTRAINT BT_ArrAPFK FOREIGN KEY (ArrAP)
    REFERENCES Airport(APCode),
    CONSTRAINT BT_SeatFK FOREIGN KEY (Seat)
    REFERENCES Seat(SeatID)
    );
    
commit;

INSERT INTO Country VALUES
    ('AT','Austria');
    
commit;

INSERT INTO City VALUES
    ('VIE','Vienna', 'AT');
    
commit;

INSERT INTO AircraftType VALUES
    ('A306','Airbus',7500,247);

commit;

INSERT INTO Airline VALUES
    ('AUA','Austrian Airlines','VIE');
    
commit;

INSERT INTO Aircraft VALUES
    ('1','1','Arnold','23-05-1997','A306','AUA');
    
commit;

select * from Aircraft;

ALTER TABLE APDistance
ADD DistanceUnit VARCHAR2(3);

DELETE FROM Aircraft
WHERE ACNo = '1';

commit;

INSERT INTO Aircraft VALUES
	('AUA1','1','Arnold','23-05-1997','A306','AUA');

INSERT INTO ACRow VALUES
	('AUA1-R1', '1', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R2', '2', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R3', '3', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R4', '4', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R5', '5', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R6', '6', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R7', '7', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R8', '8', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R9', '9', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R10', '10', 'B', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R11', '11', 'E', 'N', 'AUA1');
INSERT INTO ACRow VALUES
	('AUA1-R12', '12', 'E', 'N', 'AUA1');
    
commit;

ALTER TABLE Seat
MODIFY SeatID VARCHAR2(15);

INSERT INTO Seat VALUES
	('AUA1-1A', '1A', 'AUA1-R1');
INSERT INTO Seat VALUES
	('AUA1-1B', '1B', 'AUA1-R1');
INSERT INTO Seat VALUES
	('AUA1-1C', '1C', 'AUA1-R1');
INSERT INTO Seat VALUES
	('AUA1-1D', '1D', 'AUA1-R1');
INSERT INTO Seat VALUES
	('AUA1-2A', '2A', 'AUA1-R2');
INSERT INTO Seat VALUES
	('AUA1-2B', '2B', 'AUA1-R2');
INSERT INTO Seat VALUES
	('AUA1-2C', '2C', 'AUA1-R2');
INSERT INTO Seat VALUES
	('AUA1-2D', '2D', 'AUA1-R2');

ALTER TABLE ACRow
ADD Monitor CHAR(1);

ALTER TABLE ACRow
DROP COLUMN Monitor;

commit;
    
