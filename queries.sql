SELECT * FROM devices;

SELECT * FROM sensor_data;

-- View sensor data with device names
SELECT sd.*, d.device_name, d.location
FROM sensor_data sd
JOIN devices d ON sd.device_id = d.device_id;

--et the latest temperature reading for a specific device
SELECT * FROM sensor_data WHERE device_id = 1 ORDER BY timestamp DESC LIMIT 1;
SELECT * FROM sensor_data WHERE device_id = 3 ORDER BY timestamp DESC LIMIT 1;
SELECT * FROM sensor_data WHERE device_id = 2 ORDER BY timestamp DESC LIMIT 1;

--all reading from specific date
SELECT * FROM sensor_data
WHERE DATE(timestamp) = '2025-04-05';

--device readings with specific time range--
SELECT * FROM sensor_data
WHERE timestamp BETWEEN '2025-04-05 10:00:00' AND '2025-04-05 10:10:00';

--retrieves all sensor data recorded in the last 1 hour from the current time--
SELECT * FROM sensor_data
WHERE timestamp > NOW() - INTERVAL '1 hour';

--etrieves all sensor data recorded more than 1 hour ago from the current time--
SELECT * FROM sensor_data
WHERE timestamp < NOW() - INTERVAL '1 hour';

--average temperature and humidity for each device
SELECT device_id,
ROUND(AVG(temperature), 2) AS avg_temp,
ROUND(AVG(humidity), 2) AS avg_humid
FROM sensor_data
GROUP BY device_id;


--max and min tempof each device--
SELECT device_id,
MIN(temperature) AS min_temp,
MAX(temperature) AS max_temp
FROM sensor_data
GROUP BY device_id;

--total reading s per devices--
SELECT device_id, COUNT(*) AS reading_count
FROM sensor_data
GROUP BY device_id;

--delete old data before 1st April 2025
DELETE FROM sensor_data
WHERE timestamp < '2025-04-01';

--total records inserted
SELECT COUNT(*) FROM sensor_data;

--all devices with temp >22.5 ,>10.5 and <20.5
SELECT DISTINCT d.device_name
FROM sensor_data sd
JOIN devices d ON sd.device_id = d.device_id
WHERE sd.temperature > 22.5;

SELECT DISTINCT d.device_name
FROM sensor_data sd
JOIN devices d ON sd.device_id = d.device_id
WHERE sd.temperature > 10.5;

--
SELECT DISTINCT d.device_name
FROM sensor_data sd
JOIN devices d ON sd.device_id = d.device_id
WHERE sd.temperature <20.5;


--find the temperature change ie. rise and drop of temperature wrt the consecutive readings in temperature
SELECT *,
temperature - LAG(temperature) OVER (PARTITION BY device_id ORDER BY timestamp) AS temp_change
FROM sensor_data;

-- Calculate 5-minute average for each device (time-bucketed)--
SELECT device_id,
DATE_TRUNC('minute', timestamp) AS time_bucket,
ROUND(AVG(temperature), 2) AS avg_temp
FROM sensor_data
GROUP BY device_id, time_bucket
ORDER BY device_id, time_bucket;























