CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(64) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(32),
    `last_name` VARCHAR(32),
    PRIMARY KEY(`id`)
);

CREATE TABLE `locations` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `loaction` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE `educational_institutes` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `type` VARCHAR(32) NOT NULL,
    `location_id` INT NOT NULL,
    `established ` YEAR,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`location_id`) REFERENCES `locations`(`id`)
);

CREATE TABLE `companies` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `industry` VARCHAR(32),
    `location_id` INT NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`location_id`) REFERENCES `locations`(`id`)
);

CREATE TABLE `user_user_connection` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_1` INT NOT NULL,
    `user_2` INT NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_1`) REFERENCES `users`(`id`),
    FOREIGN KEY(`user_2`) REFERENCES `users`(`id`)
);

CREATE TABLE `user_edu_connections` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `edu_ins_id` INT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `degree` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`)
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`edu_ins_id`) REFERENCES `educational_institutes`(`id`)
);

CREATE TABLE `user_company_connection` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `company_id` INT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    `title` VARCHAR(32) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `companies`(`id`)
);
