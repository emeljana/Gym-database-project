CREATE TABLE members (
	member_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	social_nr VARCHAR(50) UNIQUE NOT NULL,
	adress VARCHAR(200),
	telefon_nr VARCHAR(50),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE trainers (
	trainer_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	speciality VARCHAR(100) NOT NULL,
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE membersship_plans(
	plan_id SERIAL PRIMARY KEY,
	plan_name VARCHAR(100) UNIQUE NOT NULL,
	price NUMERIC CHECK (price > 0),
	duration INT NOT NULL CHECK (duration BETWEEN 1 AND 12),
	is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE classes (
	class_id SERIAL PRIMARY KEY,
	class_name VARCHAR(100) NOT NULL,
	start_time TIMESTAMP NOT NULL,
	capacity INT CHECK (capacity > 0),
	trainer_id INT REFERENCES trainers(trainer_id)
);

CREATE TABLE subscriptions (
	sub_id SERIAL PRIMARY KEY,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	status VARCHAR(100) CHECK(status IN ('active', 'paused', 'cancelled')),
	member_id INT NOT NULL REFERENCES members(member_id),
	plan_id INT NOT NULL REFERENCES membersship_plans(plan_id),
	CHECK (end_date > start_date)
);

CREATE TABLE bookings (
	booking_id SERIAL PRIMARY KEY,
	booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status VARCHAR(100) NOT NULL CHECK (status IN ('active', 'cancelled')),
	member_id INT NOT NULL REFERENCES members(member_id),
	class_id INT NOT NULL REFERENCES classes(class_id) ,
	UNIQUE (member_id, class_id) -- samma medlem får inte boka samma klass mer än en gång.
);


