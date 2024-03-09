-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*
CREATE TABLE `_prisma_migrations` (
	`id` varchar(36) NOT NULL,
	`checksum` varchar(64) NOT NULL,
	`finished_at` datetime(3),
	`migration_name` varchar(255) NOT NULL,
	`logs` text,
	`rolled_back_at` datetime(3),
	`started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
	`applied_steps_count` int unsigned NOT NULL DEFAULT 0,
	CONSTRAINT `_prisma_migrations_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `answer` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`assignment_entry_submission_id` int unsigned,
	`problem_id` int unsigned NOT NULL,
	`content` text,
	`language` text,
	`attachment_id` int unsigned,
	`points` int,
	`record_id` int unsigned,
	`submitter_id` int unsigned NOT NULL,
	`is_valid` tinyint,
	CONSTRAINT `answer_id` PRIMARY KEY(`id`),
	CONSTRAINT `answer_attachment_id_unique` UNIQUE(`attachment_id`),
	CONSTRAINT `answer_record_id_unique` UNIQUE(`record_id`)
);
--> statement-breakpoint
CREATE TABLE `answer_feedback` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`answer_id` int unsigned NOT NULL,
	`assignment_entry_submission_feedback_id` int unsigned NOT NULL,
	`content` text,
	`attachment_id` int unsigned,
	`points` int,
	CONSTRAINT `answer_feedback_id` PRIMARY KEY(`id`),
	CONSTRAINT `answer_feedback_answer_id_unique` UNIQUE(`answer_id`),
	CONSTRAINT `answer_feedback_attachment_id_unique` UNIQUE(`attachment_id`)
);
--> statement-breakpoint
CREATE TABLE `answer_files` (
	`answer_id` int unsigned NOT NULL,
	`file_id` int unsigned NOT NULL,
	CONSTRAINT `answer_files_answer_id_file_id` PRIMARY KEY(`answer_id`,`file_id`)
);
--> statement-breakpoint
CREATE TABLE `assignment` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	`points` int NOT NULL,
	`title` varchar(255) NOT NULL,
	`class_id` int unsigned NOT NULL,
	`start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`end` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`public` tinyint DEFAULT 1,
	CONSTRAINT `assignment_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_assignee` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`assignment_id` int unsigned NOT NULL,
	`start` datetime,
	`end` datetime,
	`to_evenyone` tinyint,
	CONSTRAINT `assignment_assignee_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_entry` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`assignment_id` int unsigned NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`title` varchar(255) NOT NULL,
	`proportion` int,
	`penalty` int,
	`penalty_after` int,
	CONSTRAINT `assignment_entry_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_entry_metric` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`entry_id` int unsigned,
	`title` varchar(255) NOT NULL,
	`description` varchar(255) NOT NULL,
	`max` float NOT NULL,
	CONSTRAINT `assignment_entry_metric_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_entry_note` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`entry_id` int unsigned,
	`uuid` varchar(255) NOT NULL,
	`submitter_id` int unsigned NOT NULL,
	`submitted_at` datetime NOT NULL,
	`text` text NOT NULL,
	CONSTRAINT `assignment_entry_note_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_entry_submission` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`created_at` datetime NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`submitter_id` int unsigned NOT NULL,
	`entry_id` int unsigned NOT NULL,
	`content` text,
	`attachment_id` int unsigned,
	`points` int,
	`feedback_id` int unsigned,
	`penalty_score` int,
	`final_score` int,
	`scorer_id` int unsigned,
	`scored_at` datetime,
	`metrics` json,
	`comment` varchar(255),
	CONSTRAINT `assignment_entry_submission_id` PRIMARY KEY(`id`),
	CONSTRAINT `assignment_entry_submission_feedback_id_unique` UNIQUE(`feedback_id`),
	CONSTRAINT `assignment_entry_submission_attachment_id_unique` UNIQUE(`attachment_id`)
);
--> statement-breakpoint
CREATE TABLE `assignment_entry_submission_feedback` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`created_at` datetime NOT NULL,
	`submitter_id` int unsigned NOT NULL,
	CONSTRAINT `assignment_entry_submission_feedback_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `class` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`course_id` int unsigned NOT NULL,
	`semester_id` int unsigned NOT NULL,
	`name` varchar(255) NOT NULL,
	`student_list` json NOT NULL,
	CONSTRAINT `class_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `class_user_relation` (
	`class_id` int unsigned NOT NULL,
	`user_id` int unsigned NOT NULL,
	`role` enum('teacher','assistant','student') NOT NULL DEFAULT 'student',
	CONSTRAINT `class_user_relation_class_id_user_id` PRIMARY KEY(`class_id`,`user_id`)
);
--> statement-breakpoint
CREATE TABLE `course` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`number` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	CONSTRAINT `course_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `file` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`size` int NOT NULL,
	`upload_time` datetime,
	`name` varchar(255) NOT NULL,
	`parent_id` int unsigned,
	`type` tinyint NOT NULL,
	`s3_uuid` varchar(255),
	CONSTRAINT `file_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `found_item` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`created_at` datetime NOT NULL,
	`type` enum('id_card','campus_card','glasses'),
	`title` varchar(255) NOT NULL,
	`found_at` varchar(255),
	`contact` varchar(255) NOT NULL,
	`description` varchar(255),
	`images` json,
	`status` enum('under_review','published','retrieved','expired') NOT NULL DEFAULT 'under_review',
	`submitter_id` int unsigned NOT NULL,
	`publisher_id` int unsigned,
	`published_at` datetime,
	`offical_storage_id` int unsigned,
	`kept_at` varchar(255),
	CONSTRAINT `found_item_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `ioj_record` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`name` varchar(255) NOT NULL,
	`inputs` json,
	`outputs` json,
	`program` varchar(255) NOT NULL,
	CONSTRAINT `ioj_record_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `lost_found_storage` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`location` varchar(255) NOT NULL,
	CONSTRAINT `lost_found_storage_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `mikro_orm_migrations` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`name` varchar(255),
	`executed_at` datetime DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `mikro_orm_migrations_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `oauth2credential` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	`issuer` tinyint NOT NULL,
	`sub` varchar(255) NOT NULL,
	`access_token` varchar(255) NOT NULL,
	`refresh_token` varchar(255),
	`user_id` int unsigned NOT NULL,
	CONSTRAINT `oauth2credential_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `problem` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`assignment_entry_id` int unsigned,
	`type` enum('code','file') NOT NULL,
	`title` varchar(255) NOT NULL,
	`description` text NOT NULL,
	`judgement_args` json,
	`points` int NOT NULL,
	`uuid` varchar(255) NOT NULL,
	`submitter_id` int unsigned NOT NULL,
	`answers_of` varchar(255),
	CONSTRAINT `problem_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `semester` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`year` int NOT NULL,
	`season` enum('Spring','Summer','Fall','Winter') NOT NULL,
	CONSTRAINT `semester_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE TABLE `user` (
	`id` int unsigned AUTO_INCREMENT NOT NULL,
	`email` varchar(255) NOT NULL,
	`bio` varchar(255) NOT NULL DEFAULT '',
	`image` varchar(255) NOT NULL DEFAULT '',
	`created_at` datetime NOT NULL,
	`updated_at` datetime NOT NULL,
	`sid` varchar(255) NOT NULL,
	`name` varchar(255) NOT NULL,
	`lost_found_storage_id` int unsigned,
	CONSTRAINT `user_id` PRIMARY KEY(`id`)
);
--> statement-breakpoint
CREATE INDEX `answer_assignment_entry_submission_id_index` ON `answer` (`assignment_entry_submission_id`);--> statement-breakpoint
CREATE INDEX `answer_problem_id_index` ON `answer` (`problem_id`);--> statement-breakpoint
CREATE INDEX `answer_submitter_id_index` ON `answer` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `answer_feedback_assignment_entry_submission_feedback_id_index` ON `answer_feedback` (`assignment_entry_submission_feedback_id`);--> statement-breakpoint
CREATE INDEX `answer_files_answer_id_index` ON `answer_files` (`answer_id`);--> statement-breakpoint
CREATE INDEX `answer_files_file_id_index` ON `answer_files` (`file_id`);--> statement-breakpoint
CREATE INDEX `assignment_class_id_index` ON `assignment` (`class_id`);--> statement-breakpoint
CREATE INDEX `assignment_name_index` ON `assignment` (`name`);--> statement-breakpoint
CREATE INDEX `assignment_assignee_assignment_id_index` ON `assignment_assignee` (`assignment_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_assignment_id_index` ON `assignment_entry` (`assignment_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_metric_entry_id_index` ON `assignment_entry_metric` (`entry_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_note_entry_id_index` ON `assignment_entry_note` (`entry_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_note_submitter_id_index` ON `assignment_entry_note` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_submission_submitter_id_index` ON `assignment_entry_submission` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_submission_entry_id_index` ON `assignment_entry_submission` (`entry_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_submission_scorer_id_index` ON `assignment_entry_submission` (`scorer_id`);--> statement-breakpoint
CREATE INDEX `assignment_entry_submission_feedback_submitter_id_index` ON `assignment_entry_submission_feedback` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `class_course_id_index` ON `class` (`course_id`);--> statement-breakpoint
CREATE INDEX `class_semester_id_index` ON `class` (`semester_id`);--> statement-breakpoint
CREATE INDEX `class_user_relation_class_id_index` ON `class_user_relation` (`class_id`);--> statement-breakpoint
CREATE INDEX `class_user_relation_user_id_index` ON `class_user_relation` (`user_id`);--> statement-breakpoint
CREATE INDEX `file_uuid_index` ON `file` (`uuid`);--> statement-breakpoint
CREATE INDEX `file_parent_id_index` ON `file` (`parent_id`);--> statement-breakpoint
CREATE INDEX `found_item_submitter_id_index` ON `found_item` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `found_item_publisher_id_index` ON `found_item` (`publisher_id`);--> statement-breakpoint
CREATE INDEX `found_item_offical_storage_id_index` ON `found_item` (`offical_storage_id`);--> statement-breakpoint
CREATE INDEX `oauth2credential_user_id_index` ON `oauth2credential` (`user_id`);--> statement-breakpoint
CREATE INDEX `problem_assignment_entry_id_index` ON `problem` (`assignment_entry_id`);--> statement-breakpoint
CREATE INDEX `problem_submitter_id_index` ON `problem` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `user_lost_found_storage_id_index` ON `user` (`lost_found_storage_id`);--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_assignment_entry_submission_id_foreign` FOREIGN KEY (`assignment_entry_submission_id`) REFERENCES `assignment_entry_submission`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_attachment_id_foreign` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_problem_id_foreign` FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_record_id_foreign` FOREIGN KEY (`record_id`) REFERENCES `ioj_record`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_answer_id_foreign` FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_assignment_entry_submission_feedback_id_foreign` FOREIGN KEY (`assignment_entry_submission_feedback_id`) REFERENCES `assignment_entry_submission_feedback`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_attachment_id_foreign` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_files` ADD CONSTRAINT `answer_files_answer_id_foreign` FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`) ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_files` ADD CONSTRAINT `answer_files_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `file`(`id`) ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment` ADD CONSTRAINT `assignment_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `class`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_assignee` ADD CONSTRAINT `assignment_assignee_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignment`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry` ADD CONSTRAINT `assignment_entry_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignment`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_metric` ADD CONSTRAINT `assignment_entry_metric_entry_id_foreign` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_note` ADD CONSTRAINT `assignment_entry_note_entry_id_foreign` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_note` ADD CONSTRAINT `assignment_entry_note_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_attachment_id_foreign` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_entry_id_foreign` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_feedback_id_foreign` FOREIGN KEY (`feedback_id`) REFERENCES `assignment_entry_submission_feedback`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_scorer_id_foreign` FOREIGN KEY (`scorer_id`) REFERENCES `user`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission_feedback` ADD CONSTRAINT `assignment_entry_submission_feedback_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class` ADD CONSTRAINT `class_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class` ADD CONSTRAINT `class_semester_id_foreign` FOREIGN KEY (`semester_id`) REFERENCES `semester`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class_user_relation` ADD CONSTRAINT `class_user_relation_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `class`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class_user_relation` ADD CONSTRAINT `class_user_relation_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `file` ADD CONSTRAINT `file_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_offical_storage_id_foreign` FOREIGN KEY (`offical_storage_id`) REFERENCES `lost_found_storage`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_publisher_id_foreign` FOREIGN KEY (`publisher_id`) REFERENCES `user`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `oauth2credential` ADD CONSTRAINT `oauth2credential_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `problem` ADD CONSTRAINT `problem_assignment_entry_id_foreign` FOREIGN KEY (`assignment_entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `problem` ADD CONSTRAINT `problem_submitter_id_foreign` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `user` ADD CONSTRAINT `user_lost_found_storage_id_foreign` FOREIGN KEY (`lost_found_storage_id`) REFERENCES `lost_found_storage`(`id`) ON DELETE set null ON UPDATE cascade;
*/