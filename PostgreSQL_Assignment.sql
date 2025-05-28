-- Active: 1748457571027@@127.0.0.1@5432@conservation_db@public
--Database creation
CREATE DATABASE conservation_db;

--Create rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    region VARCHAR(250) NOT NULL
);



INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


--Create species table.
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


--Create sightings table. 
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL REFERENCES species(species_id),
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


--Problem 01
Insert into rangers(name,region)
VALUES('Derek Fox','Coastal Plains')

--Problem 02
Select count(DISTINCT species_id) AS unique_species_count from sightings;


--Problem 03

Select * from sightings WHERE LOCATION ILIKE '%Pass%';

--Problem 04
Select name,count(B.sighting_id) total_sightings from rangers as A JOIN sightings AS B ON A.ranger_id = B.ranger_id GROUP BY A.name;

--Problem 05
SELECT common_name from species where species_id not in (Select species_id from sightings);

--Problem 06
Select c.common_name,sighting_time,b.name from sightings as a join rangers as b on a.ranger_id = b.ranger_id join species as c on a.species_id = c.species_id ORDER BY sighting_time ASC LIMIT 2;

--Problem 07
UPDATE species SET conservation_status = 'Historic' WHERE extract(YEAR FROM discovery_date) < 1800;

--Problem 08
Select sighting_id,CASE
    WHEN extract(HOUR from sighting_time) < 12 THEN 'Morning' 
    WHEN extract(HOUR from sighting_time) >= 12 AND extract(HOUR from sighting_time) <= 16 THEN 'Afternoon'
    when extract(HOUR from sighting_time) > 16 AND extract(HOUR from sighting_time) <= 24 THEN 'Evening' 
END time_of_day from sightings;

--Problem 09
Delete FROM rangers where ranger_id not in (Select DISTINCT ranger_id from sightings);



 
