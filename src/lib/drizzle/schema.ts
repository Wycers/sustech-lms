import {
	mysqlTable,
	mysqlSchema,
	primaryKey,
	varchar,
	datetime,
	text,
	index,
	foreignKey,
	unique,
	int,
	tinyint,
	float,
	json,
	mysqlEnum
} from 'drizzle-orm/mysql-core';
import { relations, sql } from 'drizzle-orm';

export const prismaMigrations = mysqlTable(
	'_prisma_migrations',
	{
		id: varchar('id', { length: 36 }).notNull(),
		checksum: varchar('checksum', { length: 64 }).notNull(),
		finishedAt: datetime('finished_at', { mode: 'string', fsp: 3 }),
		migrationName: varchar('migration_name', { length: 255 }).notNull(),
		logs: text('logs'),
		rolledBackAt: datetime('rolled_back_at', { mode: 'string', fsp: 3 }),
		startedAt: datetime('started_at', { mode: 'string', fsp: 3 })
			.default(sql`CURRENT_TIMESTAMP(3)`)
			.notNull(),
		appliedStepsCount: int('applied_steps_count', { unsigned: true }).default(0).notNull()
	},
	(table) => {
		return {
			prismaMigrationsId: primaryKey({ columns: [table.id], name: '_prisma_migrations_id' })
		};
	}
);

export const answer = mysqlTable(
	'answer',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		assignmentEntrySubmissionId: int('assignment_entry_submission_id', {
			unsigned: true
		}).references(() => assignmentEntrySubmission.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		problemId: int('problem_id', { unsigned: true })
			.notNull()
			.references(() => problem.id, { onUpdate: 'cascade' }),
		content: text('content'),
		language: text('language'),
		attachmentId: int('attachment_id', { unsigned: true }).references(() => file.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		points: int('points'),
		recordId: int('record_id', { unsigned: true }).references(() => iojRecord.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		isValid: tinyint('is_valid')
	},
	(table) => {
		return {
			assignmentEntrySubmissionIdIdx: index('assignmentEntrySubmissionIdIdx').on(
				table.assignmentEntrySubmissionId
			),
			problemIdIdx: index('problemIdIdx').on(table.problemId),
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			answerId: primaryKey({ columns: [table.id], name: 'answer_id' }),
			answerAttachmentIdUnique: unique('answer_attachment_id_unique').on(table.attachmentId),
			answerRecordIdUnique: unique('answer_record_id_unique').on(table.recordId)
		};
	}
);

export const answerFeedback = mysqlTable(
	'answer_feedback',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		answerId: int('answer_id', { unsigned: true })
			.notNull()
			.references(() => answer.id, { onUpdate: 'cascade' }),
		assignmentEntrySubmissionFeedbackId: int('assignment_entry_submission_feedback_id', {
			unsigned: true
		})
			.notNull()
			.references(() => assignmentEntrySubmissionFeedback.id, { onUpdate: 'cascade' }),
		content: text('content'),
		attachmentId: int('attachment_id', { unsigned: true }).references(() => file.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		points: int('points')
	},
	(table) => {
		return {
			assignmentEntrySubmissionFeedbackIdIdx: index('assignmentEntrySubmissionFeedbackIdIdx').on(
				table.assignmentEntrySubmissionFeedbackId
			),
			answerFeedbackId: primaryKey({ columns: [table.id], name: 'answer_feedback_id' }),
			answerFeedbackAnswerIdUnique: unique('answer_feedback_answer_id_unique').on(table.answerId),
			answerFeedbackAttachmentIdUnique: unique('answer_feedback_attachment_id_unique').on(
				table.attachmentId
			)
		};
	}
);

export const answerFiles = mysqlTable(
	'answer_files',
	{
		answerId: int('answer_id', { unsigned: true })
			.notNull()
			.references(() => answer.id, { onDelete: 'cascade', onUpdate: 'cascade' }),
		fileId: int('file_id', { unsigned: true })
			.notNull()
			.references(() => file.id, { onDelete: 'cascade', onUpdate: 'cascade' })
	},
	(table) => {
		return {
			answerIdIdx: index('answerIdIdx').on(table.answerId),
			fileIdIdx: index('fileIdIdx').on(table.fileId),
			answerFilesAnswerIdFileId: primaryKey({
				columns: [table.answerId, table.fileId],
				name: 'answer_files_answer_id_file_id'
			})
		};
	}
);

export const assignment = mysqlTable(
	'assignment',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		name: varchar('name', { length: 255 }).notNull(),
		description: text('description').notNull(),
		points: int('points').notNull(),
		title: varchar('title', { length: 255 }).notNull(),
		classId: int('class_id', { unsigned: true })
			.notNull()
			.references(() => cls.id, { onUpdate: 'cascade' }),
		start: datetime('start', { mode: 'string' })
			.default(sql`CURRENT_TIMESTAMP`)
			.notNull(),
		end: datetime('end', { mode: 'string' })
			.default(sql`CURRENT_TIMESTAMP`)
			.notNull(),
		public: tinyint('public').default(1)
	},
	(table) => {
		return {
			classIdIdx: index('classIdIdx').on(table.classId),
			nameIdx: index('nameIdx').on(table.name),
			assignmentId: primaryKey({ columns: [table.id], name: 'assignment_id' })
		};
	}
);

export const assignmentAssignee = mysqlTable(
	'assignment_assignee',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		assignmentId: int('assignment_id', { unsigned: true })
			.notNull()
			.references(() => assignment.id, { onUpdate: 'cascade' }),
		start: datetime('start', { mode: 'string' }),
		end: datetime('end', { mode: 'string' }),
		toEvenyone: tinyint('to_evenyone')
	},
	(table) => {
		return {
			assignmentIdIdx: index('assignmentIdIdx').on(table.assignmentId),
			assignmentAssigneeId: primaryKey({ columns: [table.id], name: 'assignment_assignee_id' })
		};
	}
);

export const assignmentEntry = mysqlTable(
	'assignment_entry',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		assignmentId: int('assignment_id', { unsigned: true })
			.notNull()
			.references(() => assignment.id, { onUpdate: 'cascade' }),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		title: varchar('title', { length: 255 }).notNull(),
		proportion: int('proportion'),
		penalty: int('penalty'),
		penaltyAfter: int('penalty_after')
	},
	(table) => {
		return {
			assignmentIdIdx: index('assignmentIdIdx').on(table.assignmentId),
			assignmentEntryId: primaryKey({ columns: [table.id], name: 'assignment_entry_id' })
		};
	}
);

export const assignmentEntryMetric = mysqlTable(
	'assignment_entry_metric',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		entryId: int('entry_id', { unsigned: true }).references(() => assignmentEntry.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		title: varchar('title', { length: 255 }).notNull(),
		description: varchar('description', { length: 255 }).notNull(),
		max: float('max').notNull()
	},
	(table) => {
		return {
			entryIdIdx: index('entryIdIdx').on(table.entryId),
			assignmentEntryMetricId: primaryKey({
				columns: [table.id],
				name: 'assignment_entry_metric_id'
			})
		};
	}
);

export const assignmentEntryNote = mysqlTable(
	'assignment_entry_note',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		entryId: int('entry_id', { unsigned: true }).references(() => assignmentEntry.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		submittedAt: datetime('submitted_at', { mode: 'string' }).notNull(),
		text: text('text').notNull()
	},
	(table) => {
		return {
			entryIdIdx: index('entryIdIdx').on(table.entryId),
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			assignmentEntryNoteId: primaryKey({ columns: [table.id], name: 'assignment_entry_note_id' })
		};
	}
);

export const assignmentEntrySubmission = mysqlTable(
	'assignment_entry_submission',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		createdAt: datetime('created_at', { mode: 'string' }).notNull(),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		entryId: int('entry_id', { unsigned: true })
			.notNull()
			.references(() => assignmentEntry.id, { onUpdate: 'cascade' }),
		content: text('content'),
		attachmentId: int('attachment_id', { unsigned: true }).references(() => file.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		points: int('points'),
		feedbackId: int('feedback_id', { unsigned: true }).references(
			() => assignmentEntrySubmissionFeedback.id,
			{ onDelete: 'set null', onUpdate: 'cascade' }
		),
		penaltyScore: int('penalty_score'),
		finalScore: int('final_score'),
		scorerId: int('scorer_id', { unsigned: true }).references(() => user.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		scoredAt: datetime('scored_at', { mode: 'string' }),
		metrics: json('metrics'),
		comment: varchar('comment', { length: 255 })
	},
	(table) => {
		return {
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			entryIdIdx: index('entryIdIdx').on(table.entryId),
			scorerIdIdx: index('scorerIdIdx').on(table.scorerId),
			assignmentEntrySubmissionId: primaryKey({
				columns: [table.id],
				name: 'assignment_entry_submission_id'
			}),
			assignmentEntrySubmissionFeedbackIdUnique: unique(
				'assignment_entry_submission_feedback_id_unique'
			).on(table.feedbackId),
			assignmentEntrySubmissionAttachmentIdUnique: unique(
				'assignment_entry_submission_attachment_id_unique'
			).on(table.attachmentId)
		};
	}
);

export const assignmentEntrySubmissionFeedback = mysqlTable(
	'assignment_entry_submission_feedback',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		createdAt: datetime('created_at', { mode: 'string' }).notNull(),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' })
	},
	(table) => {
		return {
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			assignmentEntrySubmissionFeedbackId: primaryKey({
				columns: [table.id],
				name: 'assignment_entry_submission_feedback_id'
			})
		};
	}
);

export const cls = mysqlTable(
	'class',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		courseId: int('course_id', { unsigned: true })
			.notNull()
			.references(() => course.id, { onUpdate: 'cascade' }),
		semesterId: int('semester_id', { unsigned: true })
			.notNull()
			.references(() => semester.id, { onUpdate: 'cascade' }),
		name: varchar('name', { length: 255 }).notNull(),
		studentList: json('student_list').notNull()
	},
	(table) => {
		return {
			courseIdIdx: index('courseIdIdx').on(table.courseId),
			semesterIdIdx: index('semesterIdIdx').on(table.semesterId),
			classId: primaryKey({ columns: [table.id], name: 'class_id' })
		};
	}
);

export const classUserRelation = mysqlTable(
	'class_user_relation',
	{
		classId: int('class_id', { unsigned: true })
			.notNull()
			.references(() => cls.id, { onUpdate: 'cascade' }),
		userId: int('user_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		role: mysqlEnum('role', ['teacher', 'assistant', 'student']).default('student').notNull()
	},
	(table) => {
		return {
			classIdIdx: index('classIdIdx').on(table.classId),
			userIdIdx: index('userIdIdx').on(table.userId),
			classUserRelationClassIdUserId: primaryKey({
				columns: [table.classId, table.userId],
				name: 'class_user_relation_class_id_user_id'
			})
		};
	}
);

export const course = mysqlTable(
	'course',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		number: varchar('number', { length: 255 }).notNull(),
		name: varchar('name', { length: 255 }).notNull(),
		description: text('description').notNull()
	},
	(table) => {
		return {
			courseId: primaryKey({ columns: [table.id], name: 'course_id' })
		};
	}
);

export const file = mysqlTable(
	'file',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		size: int('size').notNull(),
		uploadTime: datetime('upload_time', { mode: 'string' }),
		name: varchar('name', { length: 255 }).notNull(),
		parentId: int('parent_id', { unsigned: true }),
		type: tinyint('type').notNull(),
		s3Uuid: varchar('s3_uuid', { length: 255 })
	},
	(table) => {
		return {
			uuidIdx: index('uuidIdx').on(table.uuid),
			parentIdIdx: index('parentIdIdx').on(table.parentId),
			fileParentIdForeign: foreignKey({
				columns: [table.parentId],
				foreignColumns: [table.id],
				name: 'file_parent_id_foreign'
			})
				.onUpdate('cascade')
				.onDelete('set null'),
			fileId: primaryKey({ columns: [table.id], name: 'file_id' })
		};
	}
);

export const foundItem = mysqlTable(
	'found_item',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		createdAt: datetime('created_at', { mode: 'string' }).notNull(),
		type: mysqlEnum('type', ['id_card', 'campus_card', 'glasses']),
		title: varchar('title', { length: 255 }).notNull(),
		foundAt: varchar('found_at', { length: 255 }),
		contact: varchar('contact', { length: 255 }).notNull(),
		description: varchar('description', { length: 255 }),
		images: json('images'),
		status: mysqlEnum('status', ['under_review', 'published', 'retrieved', 'expired'])
			.default('under_review')
			.notNull(),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		publisherId: int('publisher_id', { unsigned: true }).references(() => user.id, {
			onDelete: 'set null',
			onUpdate: 'cascade'
		}),
		publishedAt: datetime('published_at', { mode: 'string' }),
		officalStorageId: int('offical_storage_id', { unsigned: true }).references(
			() => lostFoundStorage.id,
			{ onDelete: 'set null', onUpdate: 'cascade' }
		),
		keptAt: varchar('kept_at', { length: 255 })
	},
	(table) => {
		return {
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			publisherIdIdx: index('publisherIdIdx').on(table.publisherId),
			officalStorageIdIdx: index('officalStorageIdIdx').on(table.officalStorageId),
			foundItemId: primaryKey({ columns: [table.id], name: 'found_item_id' })
		};
	}
);

export const iojRecord = mysqlTable(
	'ioj_record',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		name: varchar('name', { length: 255 }).notNull(),
		inputs: json('inputs'),
		outputs: json('outputs'),
		program: varchar('program', { length: 255 }).notNull()
	},
	(table) => {
		return {
			iojRecordId: primaryKey({ columns: [table.id], name: 'ioj_record_id' })
		};
	}
);

export const lostFoundStorage = mysqlTable(
	'lost_found_storage',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		location: varchar('location', { length: 255 }).notNull()
	},
	(table) => {
		return {
			lostFoundStorageId: primaryKey({ columns: [table.id], name: 'lost_found_storage_id' })
		};
	}
);

export const mikroOrmMigrations = mysqlTable(
	'mikro_orm_migrations',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		name: varchar('name', { length: 255 }),
		executedAt: datetime('executed_at', { mode: 'string' }).default(sql`CURRENT_TIMESTAMP`)
	},
	(table) => {
		return {
			mikroOrmMigrationsId: primaryKey({ columns: [table.id], name: 'mikro_orm_migrations_id' })
		};
	}
);

export const oauth2Credential = mysqlTable(
	'oauth2credential',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		createdAt: datetime('created_at', { mode: 'string' }).notNull(),
		updatedAt: datetime('updated_at', { mode: 'string' }).notNull(),
		issuer: tinyint('issuer').notNull(),
		sub: varchar('sub', { length: 255 }).notNull(),
		accessToken: varchar('access_token', { length: 255 }).notNull(),
		refreshToken: varchar('refresh_token', { length: 255 }),
		userId: int('user_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' })
	},
	(table) => {
		return {
			userIdIdx: index('userIdIdx').on(table.userId),
			oauth2CredentialId: primaryKey({ columns: [table.id], name: 'oauth2credential_id' })
		};
	}
);

export const problem = mysqlTable(
	'problem',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		assignmentEntryId: int('assignment_entry_id', { unsigned: true }).references(
			() => assignmentEntry.id,
			{ onDelete: 'set null', onUpdate: 'cascade' }
		),
		type: mysqlEnum('type', ['code', 'file']).notNull(),
		title: varchar('title', { length: 255 }).notNull(),
		description: text('description').notNull(),
		judgementArgs: json('judgement_args'),
		points: int('points').notNull(),
		uuid: varchar('uuid', { length: 255 }).notNull(),
		submitterId: int('submitter_id', { unsigned: true })
			.notNull()
			.references(() => user.id, { onUpdate: 'cascade' }),
		answersOf: varchar('answers_of', { length: 255 })
	},
	(table) => {
		return {
			assignmentEntryIdIdx: index('assignmentEntryIdIdx').on(table.assignmentEntryId),
			submitterIdIdx: index('submitterIdIdx').on(table.submitterId),
			problemId: primaryKey({ columns: [table.id], name: 'problem_id' })
		};
	}
);

export const semester = mysqlTable(
	'semester',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		year: int('year').notNull(),
		season: mysqlEnum('season', ['Spring', 'Summer', 'Fall', 'Winter']).notNull()
	},
	(table) => {
		return {
			semesterId: primaryKey({ columns: [table.id], name: 'semester_id' })
		};
	}
);

export const user = mysqlTable(
	'user',
	{
		id: int('id', { unsigned: true }).autoincrement().notNull(),
		email: varchar('email', { length: 255 }).notNull(),
		bio: varchar('bio', { length: 255 }).default('').notNull(),
		image: varchar('image', { length: 255 }).default('').notNull(),
		createdAt: datetime('created_at', { mode: 'string' }).notNull(),
		updatedAt: datetime('updated_at', { mode: 'string' }).notNull(),
		sid: varchar('sid', { length: 255 }).notNull(),
		name: varchar('name', { length: 255 }).notNull(),
		lostFoundStorageId: int('lost_found_storage_id', { unsigned: true }).references(
			() => lostFoundStorage.id,
			{ onDelete: 'set null', onUpdate: 'cascade' }
		)
	},
	(table) => {
		return {
			lostFoundStorageIdIdx: index('lostFoundStorageIdIdx').on(table.lostFoundStorageId),
			userId: primaryKey({ columns: [table.id], name: 'user_id' })
		};
	}
);

export const luciaUser = mysqlTable('lucia_user', {
	id: varchar('id', {
		length: 255
	}).primaryKey(),
	userId: int('user_id')
		.notNull()
		.references(() => user.id)
});

export const luciaSession = mysqlTable('lucia_session', {
	id: varchar('id', {
		length: 255
	}).primaryKey(),
	userId: varchar('user_id', {
		length: 255
	})
		.notNull()
		.references(() => luciaUser.id),
	expiresAt: datetime('expires_at').notNull()
});

export const luciaUserRelations = relations(luciaUser, ({ one }) => ({
	user: one(user)
}));
export const credentialRelations = relations(oauth2Credential, ({ one }) => ({
	user: one(user, {
		fields: [oauth2Credential.userId],
		references: [user.id]
	})
}));


export const usersRelations = relations(user, ({ many }) => ({
	userToCls: many(classUserRelation)
}));
export const clsRelations = relations(cls, ({ many }) => ({
	userToCls: many(classUserRelation)
}));
export const userToClsRelations = relations(classUserRelation, ({ one }) => ({
	class: one(cls, {
		fields: [classUserRelation.classId],
		references: [cls.id]
	}),
	user: one(user, {
		fields: [classUserRelation.classId],
		references: [user.id]
	})
}));