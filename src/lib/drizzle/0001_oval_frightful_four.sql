ALTER TABLE `answer` DROP FOREIGN KEY `answer_assignment_entry_submission_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer` DROP FOREIGN KEY `answer_attachment_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer` DROP FOREIGN KEY `answer_problem_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer` DROP FOREIGN KEY `answer_record_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer` DROP FOREIGN KEY `answer_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer_feedback` DROP FOREIGN KEY `answer_feedback_answer_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer_feedback` DROP FOREIGN KEY `answer_feedback_assignment_entry_submission_feedback_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer_feedback` DROP FOREIGN KEY `answer_feedback_attachment_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer_files` DROP FOREIGN KEY `answer_files_answer_id_foreign`;
--> statement-breakpoint
ALTER TABLE `answer_files` DROP FOREIGN KEY `answer_files_file_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment` DROP FOREIGN KEY `assignment_class_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_assignee` DROP FOREIGN KEY `assignment_assignee_assignment_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry` DROP FOREIGN KEY `assignment_entry_assignment_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_metric` DROP FOREIGN KEY `assignment_entry_metric_entry_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_note` DROP FOREIGN KEY `assignment_entry_note_entry_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_note` DROP FOREIGN KEY `assignment_entry_note_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` DROP FOREIGN KEY `assignment_entry_submission_attachment_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` DROP FOREIGN KEY `assignment_entry_submission_entry_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` DROP FOREIGN KEY `assignment_entry_submission_feedback_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` DROP FOREIGN KEY `assignment_entry_submission_scorer_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` DROP FOREIGN KEY `assignment_entry_submission_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `assignment_entry_submission_feedback` DROP FOREIGN KEY `assignment_entry_submission_feedback_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `class` DROP FOREIGN KEY `class_course_id_foreign`;
--> statement-breakpoint
ALTER TABLE `class` DROP FOREIGN KEY `class_semester_id_foreign`;
--> statement-breakpoint
ALTER TABLE `class_user_relation` DROP FOREIGN KEY `class_user_relation_class_id_foreign`;
--> statement-breakpoint
ALTER TABLE `class_user_relation` DROP FOREIGN KEY `class_user_relation_user_id_foreign`;
--> statement-breakpoint
ALTER TABLE `found_item` DROP FOREIGN KEY `found_item_offical_storage_id_foreign`;
--> statement-breakpoint
ALTER TABLE `found_item` DROP FOREIGN KEY `found_item_publisher_id_foreign`;
--> statement-breakpoint
ALTER TABLE `found_item` DROP FOREIGN KEY `found_item_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `oauth2credential` DROP FOREIGN KEY `oauth2credential_user_id_foreign`;
--> statement-breakpoint
ALTER TABLE `problem` DROP FOREIGN KEY `problem_assignment_entry_id_foreign`;
--> statement-breakpoint
ALTER TABLE `problem` DROP FOREIGN KEY `problem_submitter_id_foreign`;
--> statement-breakpoint
ALTER TABLE `user` DROP FOREIGN KEY `user_lost_found_storage_id_foreign`;
--> statement-breakpoint
DROP INDEX `answer_assignment_entry_submission_id_index` ON `answer`;--> statement-breakpoint
DROP INDEX `answer_problem_id_index` ON `answer`;--> statement-breakpoint
DROP INDEX `answer_submitter_id_index` ON `answer`;--> statement-breakpoint
DROP INDEX `answer_feedback_assignment_entry_submission_feedback_id_index` ON `answer_feedback`;--> statement-breakpoint
DROP INDEX `answer_files_answer_id_index` ON `answer_files`;--> statement-breakpoint
DROP INDEX `answer_files_file_id_index` ON `answer_files`;--> statement-breakpoint
DROP INDEX `assignment_class_id_index` ON `assignment`;--> statement-breakpoint
DROP INDEX `assignment_name_index` ON `assignment`;--> statement-breakpoint
DROP INDEX `assignment_assignee_assignment_id_index` ON `assignment_assignee`;--> statement-breakpoint
DROP INDEX `assignment_entry_assignment_id_index` ON `assignment_entry`;--> statement-breakpoint
DROP INDEX `assignment_entry_metric_entry_id_index` ON `assignment_entry_metric`;--> statement-breakpoint
DROP INDEX `assignment_entry_note_entry_id_index` ON `assignment_entry_note`;--> statement-breakpoint
DROP INDEX `assignment_entry_note_submitter_id_index` ON `assignment_entry_note`;--> statement-breakpoint
DROP INDEX `assignment_entry_submission_submitter_id_index` ON `assignment_entry_submission`;--> statement-breakpoint
DROP INDEX `assignment_entry_submission_entry_id_index` ON `assignment_entry_submission`;--> statement-breakpoint
DROP INDEX `assignment_entry_submission_scorer_id_index` ON `assignment_entry_submission`;--> statement-breakpoint
DROP INDEX `assignment_entry_submission_feedback_submitter_id_index` ON `assignment_entry_submission_feedback`;--> statement-breakpoint
DROP INDEX `class_course_id_index` ON `class`;--> statement-breakpoint
DROP INDEX `class_semester_id_index` ON `class`;--> statement-breakpoint
DROP INDEX `class_user_relation_class_id_index` ON `class_user_relation`;--> statement-breakpoint
DROP INDEX `class_user_relation_user_id_index` ON `class_user_relation`;--> statement-breakpoint
DROP INDEX `file_uuid_index` ON `file`;--> statement-breakpoint
DROP INDEX `file_parent_id_index` ON `file`;--> statement-breakpoint
DROP INDEX `found_item_submitter_id_index` ON `found_item`;--> statement-breakpoint
DROP INDEX `found_item_publisher_id_index` ON `found_item`;--> statement-breakpoint
DROP INDEX `found_item_offical_storage_id_index` ON `found_item`;--> statement-breakpoint
DROP INDEX `oauth2credential_user_id_index` ON `oauth2credential`;--> statement-breakpoint
DROP INDEX `problem_assignment_entry_id_index` ON `problem`;--> statement-breakpoint
DROP INDEX `problem_submitter_id_index` ON `problem`;--> statement-breakpoint
DROP INDEX `user_lost_found_storage_id_index` ON `user`;--> statement-breakpoint
CREATE INDEX `assignmentEntrySubmissionIdIdx` ON `answer` (`assignment_entry_submission_id`);--> statement-breakpoint
CREATE INDEX `problemIdIdx` ON `answer` (`problem_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `answer` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `assignmentEntrySubmissionFeedbackIdIdx` ON `answer_feedback` (`assignment_entry_submission_feedback_id`);--> statement-breakpoint
CREATE INDEX `answerIdIdx` ON `answer_files` (`answer_id`);--> statement-breakpoint
CREATE INDEX `fileIdIdx` ON `answer_files` (`file_id`);--> statement-breakpoint
CREATE INDEX `classIdIdx` ON `assignment` (`class_id`);--> statement-breakpoint
CREATE INDEX `nameIdx` ON `assignment` (`name`);--> statement-breakpoint
CREATE INDEX `assignmentIdIdx` ON `assignment_assignee` (`assignment_id`);--> statement-breakpoint
CREATE INDEX `assignmentIdIdx` ON `assignment_entry` (`assignment_id`);--> statement-breakpoint
CREATE INDEX `entryIdIdx` ON `assignment_entry_metric` (`entry_id`);--> statement-breakpoint
CREATE INDEX `entryIdIdx` ON `assignment_entry_note` (`entry_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `assignment_entry_note` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `assignment_entry_submission` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `entryIdIdx` ON `assignment_entry_submission` (`entry_id`);--> statement-breakpoint
CREATE INDEX `scorerIdIdx` ON `assignment_entry_submission` (`scorer_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `assignment_entry_submission_feedback` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `courseIdIdx` ON `class` (`course_id`);--> statement-breakpoint
CREATE INDEX `semesterIdIdx` ON `class` (`semester_id`);--> statement-breakpoint
CREATE INDEX `classIdIdx` ON `class_user_relation` (`class_id`);--> statement-breakpoint
CREATE INDEX `userIdIdx` ON `class_user_relation` (`user_id`);--> statement-breakpoint
CREATE INDEX `uuidIdx` ON `file` (`uuid`);--> statement-breakpoint
CREATE INDEX `parentIdIdx` ON `file` (`parent_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `found_item` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `publisherIdIdx` ON `found_item` (`publisher_id`);--> statement-breakpoint
CREATE INDEX `officalStorageIdIdx` ON `found_item` (`offical_storage_id`);--> statement-breakpoint
CREATE INDEX `userIdIdx` ON `oauth2credential` (`user_id`);--> statement-breakpoint
CREATE INDEX `assignmentEntryIdIdx` ON `problem` (`assignment_entry_id`);--> statement-breakpoint
CREATE INDEX `submitterIdIdx` ON `problem` (`submitter_id`);--> statement-breakpoint
CREATE INDEX `lostFoundStorageIdIdx` ON `user` (`lost_found_storage_id`);--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_assignment_entry_submission_id_assignment_entry_submission_id_fk` FOREIGN KEY (`assignment_entry_submission_id`) REFERENCES `assignment_entry_submission`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_problem_id_problem_id_fk` FOREIGN KEY (`problem_id`) REFERENCES `problem`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_attachment_id_file_id_fk` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_record_id_ioj_record_id_fk` FOREIGN KEY (`record_id`) REFERENCES `ioj_record`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer` ADD CONSTRAINT `answer_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_answer_id_answer_id_fk` FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_assignment_entry_submission_feedback_id_assignment_entry_submission_feedback_id_fk` FOREIGN KEY (`assignment_entry_submission_feedback_id`) REFERENCES `assignment_entry_submission_feedback`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_feedback` ADD CONSTRAINT `answer_feedback_attachment_id_file_id_fk` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_files` ADD CONSTRAINT `answer_files_answer_id_answer_id_fk` FOREIGN KEY (`answer_id`) REFERENCES `answer`(`id`) ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `answer_files` ADD CONSTRAINT `answer_files_file_id_file_id_fk` FOREIGN KEY (`file_id`) REFERENCES `file`(`id`) ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment` ADD CONSTRAINT `assignment_class_id_class_id_fk` FOREIGN KEY (`class_id`) REFERENCES `class`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_assignee` ADD CONSTRAINT `assignment_assignee_assignment_id_assignment_id_fk` FOREIGN KEY (`assignment_id`) REFERENCES `assignment`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry` ADD CONSTRAINT `assignment_entry_assignment_id_assignment_id_fk` FOREIGN KEY (`assignment_id`) REFERENCES `assignment`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_metric` ADD CONSTRAINT `assignment_entry_metric_entry_id_assignment_entry_id_fk` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_note` ADD CONSTRAINT `assignment_entry_note_entry_id_assignment_entry_id_fk` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_note` ADD CONSTRAINT `assignment_entry_note_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_entry_id_assignment_entry_id_fk` FOREIGN KEY (`entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_attachment_id_file_id_fk` FOREIGN KEY (`attachment_id`) REFERENCES `file`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_feedback_id_assignment_entry_submission_feedback_id_fk` FOREIGN KEY (`feedback_id`) REFERENCES `assignment_entry_submission_feedback`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission` ADD CONSTRAINT `assignment_entry_submission_scorer_id_user_id_fk` FOREIGN KEY (`scorer_id`) REFERENCES `user`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `assignment_entry_submission_feedback` ADD CONSTRAINT `assignment_entry_submission_feedback_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class` ADD CONSTRAINT `class_course_id_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class` ADD CONSTRAINT `class_semester_id_semester_id_fk` FOREIGN KEY (`semester_id`) REFERENCES `semester`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class_user_relation` ADD CONSTRAINT `class_user_relation_class_id_class_id_fk` FOREIGN KEY (`class_id`) REFERENCES `class`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `class_user_relation` ADD CONSTRAINT `class_user_relation_user_id_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_publisher_id_user_id_fk` FOREIGN KEY (`publisher_id`) REFERENCES `user`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `found_item` ADD CONSTRAINT `found_item_offical_storage_id_lost_found_storage_id_fk` FOREIGN KEY (`offical_storage_id`) REFERENCES `lost_found_storage`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `oauth2credential` ADD CONSTRAINT `oauth2credential_user_id_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `problem` ADD CONSTRAINT `problem_assignment_entry_id_assignment_entry_id_fk` FOREIGN KEY (`assignment_entry_id`) REFERENCES `assignment_entry`(`id`) ON DELETE set null ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `problem` ADD CONSTRAINT `problem_submitter_id_user_id_fk` FOREIGN KEY (`submitter_id`) REFERENCES `user`(`id`) ON DELETE no action ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE `user` ADD CONSTRAINT `user_lost_found_storage_id_lost_found_storage_id_fk` FOREIGN KEY (`lost_found_storage_id`) REFERENCES `lost_found_storage`(`id`) ON DELETE set null ON UPDATE cascade;