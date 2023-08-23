#! /bin/bash


  PSQL="psql --username=freecodecamp -t --dbname=postgres --no-align -c"

echo $($PSQL "CREATE DATABASE salon;")

echo $($PSQL "\c salon")

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo $($PSQL "DROP TABLE IF EXISTS customers, appointments, services")

echo $($PSQL "CREATE TABLE IF NOT EXISTS customers(customer_id SERIAL PRIMARY KEY NOT NULL, phone varchar(20) UNIQUE, name varchar(50) NOT NULL)")

echo $($PSQL "CREATE TABLE IF NOT EXISTS services(service_id SERIAL PRIMARY KEY NOT NULL, name varchar(50) NOT NULL)")

echo $($PSQL "CREATE TABLE IF NOT EXISTS appointments(appointment_id SERIAL PRIMARY KEY NOT NULL,time varchar(50),customer_id INT NOT NULL,service_id INT NOT NULL, CONSTRAINT fk_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id), CONSTRAINT fk_services FOREIGN KEY(service_id) REFERENCES services(service_id))")

echo $($PSQL "INSERT INTO SERVICES VALUES(1,'cut'), (2,'wash'), (3,'color')")


# CREATE TABLE temp_games(year int NOT NULL,
# round varchar(50) NOT NULL,
# winner varchar(50) NOT NULL,
# opponent varchar(50) NOT NULL,
# winner_goals int NOT NULL,
# opponent_goals int NOT NULL);
