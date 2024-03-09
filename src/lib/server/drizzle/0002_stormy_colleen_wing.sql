CREATE TABLE `lucia_user` (
	`id` varchar(255) NOT NULL,
	`user_id` int NOT NULL,
	CONSTRAINT `lucia_user_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `lucia_session` (
	`id` varchar(255) NOT NULL,
	`user_id` varchar(255) NOT NULL,
	`expires_at` datetime NOT NULL,
	CONSTRAINT `lucia_session_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
ALTER TABLE `lucia_user` ADD CONSTRAINT `lucia_user_user_id_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE no action;
ALTER TABLE `lucia_session` ADD CONSTRAINT `lucia_session_user_id_lucia_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `lucia_user`(`id`) ON DELETE no action ON UPDATE no action;