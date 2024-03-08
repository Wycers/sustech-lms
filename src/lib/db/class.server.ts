import { eq } from 'drizzle-orm';
import { db } from './db.server';
import { classUserRelation } from '$lib/drizzle/schema';

export async function getUserClasses(userId: number) {
	const classesOnUsers = await db.query.classUserRelation.findMany({
		where: eq(classUserRelation.userId, userId),
		with: {
			class: true
		}
	});

	return {
		classes: classesOnUsers.map((c) => c.class)
	};
}

// export async function getClass(userId: number, classId: number) {
// 	const userClass = await db.classesOnUsers.findFirst({
// 		where: {
// 			userId,
// 			classId
// 		},
// 		include: {
// 			class: true
// 		}
// 	});

// 	if (!userClass) {
// 		return null;
// 	}
// 	return userClass;
// }

// export async function getAssignments(userId: number, classId: number) {
// 	const userClass = await db.classesOnUsers.findFirst({
// 		where: {
// 			userId,
// 			classId
// 		},
// 		include: {
// 			class: true
// 		}
// 	});

// 	if (!userClass) {
// 		return null;
// 	}

// 	const assignments = await db.assignment.findMany({
// 		where: {
// 			classId
// 		}
// 	});

// 	return assignments;
// }
