 CREATE TABLE devices (
       device_id SERIAL PRIMARY KEY,
       device_name VARCHAR(50) NOT NULL,
       location VARCHAR(100),
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

CREATE TABLE sensor_data (
       data_id SERIAL PRIMARY KEY,
       device_id INT REFERENCES devices(device_id),
       timestamp TIMESTAMPTZ NOT NULL,
       temperature DECIMAL(5, 2),
       humidity DECIMAL(5, 2)
   );
