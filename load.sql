/*  

Script updated by Andy Dyrcz to fit Chicago's CTA datasets.

example usage:
mysql -u root -p database < load.sql

*/


CREATE DATABASE IF NOT EXISTS gtfsdb;

USE gtfsdb

DROP TABLE IF EXISTS agency;

CREATE TABLE `agency` (
    agency_name VARCHAR(255) PRIMARY KEY,
    agency_url VARCHAR(255),
    agency_timezone VARCHAR(50),
	agency_lang VARCHAR(4),
	agency_phone VARCHAR(50),
	agency_fare_url VARCHAR(255)
);

DROP TABLE IF EXISTS calendar;

CREATE TABLE `calendar` (
    service_id INT(11),
	monday TINYINT(1),
	tuesday TINYINT(1),
	wednesday TINYINT(1),
	thursday TINYINT(1),
	friday TINYINT(1),
	saturday TINYINT(1),
	sunday TINYINT(1),
	start_date VARCHAR(8),
	end_date VARCHAR(8),
	KEY `service_id` (service_id)
);

DROP TABLE IF EXISTS calendar_dates;

CREATE TABLE `calendar_dates` (
    service_id INT(11),
    `date` VARCHAR(8),
    exception_type INT(2),
    KEY `service_id` (service_id),
    KEY `exception_type` (exception_type)    
);

DROP TABLE IF EXISTS frequencies;

CREATE TABLE `frequencies` (
    trip_id INT(11),
    start_time VARCHAR(8),
	end_time VARCHAR(8),
	headway_secs INT(30),
    KEY `trip_id` (trip_id) 
);


DROP TABLE IF EXISTS routes;

CREATE TABLE `routes` (
    route_id INT(11) PRIMARY KEY,
	route_short_name VARCHAR(50),
	route_long_name VARCHAR(255),
	route_type INT(2),
	route_url VARCHAR(255),
	route_color VARCHAR(255),
	route_text_color VARCHAR(255),
	KEY `route_type` (route_type)
);

DROP TABLE IF EXISTS shapes;

CREATE TABLE `shapes` (
    shape_id VARCHAR(50),
	shape_pt_lat DECIMAL(9,6),
	shape_pt_lon DECIMAL(9,6),
	shape_pt_sequence INT(11),
	shape_dist_traveled INT(11),
	KEY `shape_id` (shape_id)
);

DROP TABLE IF EXISTS stop_times;

CREATE TABLE `stop_times` (
    trip_id INT(11),
	arrival_time VARCHAR(8),
	departure_time VARCHAR(8),
	stop_id INT(11),
	stop_sequence INT(11),
	stop_headsign VARCHAR(255),
	pickup_type INT(6),
	shape_dist_traveled INT(8),
	KEY `trip_id` (trip_id),
	KEY `stop_id` (stop_id),
	KEY `stop_sequence` (stop_sequence)
);

DROP TABLE IF EXISTS stops;

CREATE TABLE `stops` (
    stop_id INT(11) PRIMARY KEY,
	stop_code INT(11),
	stop_name VARCHAR(255),
	stop_lat DECIMAL(9,6),
	stop_lon DECIMAL(9,6),
	location_type TINYINT(2),
	parent_station VARCHAR(255),
	wheelchair_boarding TINYINT(1),
	KEY `stop_lat` (stop_lat),
	KEY `stop_lon` (stop_lon)
);

DROP TABLE IF EXISTS transfers;

CREATE TABLE `transfers` (
    from_stop_id INT(11) PRIMARY KEY,
	to_stop_id INT(11),
	transfer_type INT(11),
	KEY `from_stop_id` (from_stop_id),
	KEY `to_stop_id` (to_stop_id)
);

DROP TABLE IF EXISTS trips;

CREATE TABLE `trips` (
    route_id INT(11),
	service_id INT(11),
	trip_id INT(11) PRIMARY KEY,
	trip_headsign VARCHAR(255),
	direction_id TINYINT(1),
	block_id INT(10),
	shape_id VARCHAR(50),
	direction VARCHAR(10),
	wheelchair_accessible TINYINT(1),
	KEY `route_id` (route_id),
	KEY `service_id` (service_id),
	KEY `direction_id` (direction_id),
	KEY `shape_id` (shape_id)
);

LOAD DATA LOCAL INFILE 'gtfs/agency.txt' INTO TABLE agency FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/calendar.txt' INTO TABLE calendar FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/calendar_dates.txt' INTO TABLE calendar_dates FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/frequencies.txt' INTO TABLE fare_attributes FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/routes.txt' INTO TABLE routes FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/shapes.txt' INTO TABLE shapes FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/stop_times.txt' INTO TABLE stop_times FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/transfers.txt' INTO TABLE stops FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/stops.txt' INTO TABLE stops FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'gtfs/trips.txt' INTO TABLE trips FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' IGNORE 1 LINES;