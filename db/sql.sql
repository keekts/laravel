

create table books(
	id int auto_increment,
	code varchar(40) null,
	name varchar(20) not null,
	description varchar(255),
	tag varchar(60) null,
	type_id int null,
	price decimal(16, 2)  default 0,
	price_cost decimal(16, 2)  default 0,
	cover varchar(255) null,
	image varchar(255) null,
	stock int default 0,
	star decimal(10,2) default 0,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);


create table book_types(
	id int auto_increment,
	type_name varchar(30) not null,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);

create table customers(
	id int auto_increment,
	gender varchar(1) null,
	fullname varchar(40) null,
	phone varchar(20) null,
	email varchar(60) not null,
	password varchar(400) not null,
	ip varchar(20) null,
	token varchar(500) null,
	block boolean default 0,
	lastlog datetime null,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);

create table order_status(
	id int auto_increment,
	status_name varchar(30) not null,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);


create table orders(
	id int auto_increment,
	customer_id int null,
	status_id int null,
	order_date datetime not null default CURRENT_TIMESTAMP,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);


create table order_details(
	id int auto_increment,
	order_id int null,
	book_id int null,
	qty int default 1,
	price decimal(16, 2)  default 0,
	price_cost decimal(16, 2)  default 0,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);



create table users(
	id int auto_increment,
	gender varchar(1) null,
	fullname varchar(40) null,
	phone varchar(20) null,
	email varchar(60) not null,
	password varchar(400) not null,
	ip varchar(20) null,
	token varchar(500),
	block boolean default 0,
	lastlog datetime null,
	birthday date null,
	role varchar(20) default 'User',
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	primary key(id)
);

INSERT INTO `bookstore`.`users`(`id`, `fullname`, `phone`, `email`, `password`, `ip`, `token`, `block`, `lastlog`, `created_at`, `updated_at`) VALUES (1, 'MArk AI', 'xxx', 'mark@gmail.com', '$2y$10$X8ZdUjaULR/eD4olCBSQqOz4rU5G/9MGfax3wGY.fEoOPtijQ.MC6', NULL, NULL, 0, NULL, '2021-01-10 12:44:32', '2021-01-10 14:51:10');