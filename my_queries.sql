# Selezionare tutti gli studenti nati nel 1990 (160)
/*
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990
*/

# Selezionare tutti i corsi che valgono più di 10 crediti (479)
/*
SELECT *
FROM `courses`
WHERE `cfu` > 10
ORDER BY `cfu`
*/

# Selezionare tutti gli studenti che hanno più di 30 anni
/*
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) < 1995
ORDER BY YEAR(`date_of_birth`)
*/
/*
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) < YEAR(CURDATE()) - 30
*/

# Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
/*
SELECT *
FROM `courses`
WHERE `period` = "I semestre" AND `year` = 1
*/

# Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
/*
SELECT *
FROM `exams`
WHERE `date` = "2020-06-20" AND `hour` >= "14:00:00"
*/

# Selezionare tutti i corsi di laurea magistrale (38)
/*
SELECT *
FROM `degrees`
WHERE `level` = "magistrale"
*/

# Da quanti dipartimenti è composta l'università? (12)
/*
SELECT COUNT(*) as `how_many_departments`
FROM `departments`
*/

# Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
/*
SELECT COUNT(*) as `teachers_without_phone_number`
FROM `teachers`
WHERE `phone` IS NULL
*/


#GROUP BY

# Contare quanti iscritti ci sono stati ogni anno
/*
SELECT COUNT(*) as `how_many_iscritti`, YEAR(`enrolment_date`)
FROM `students`
GROUP BY YEAR(`enrolment_date`)
*/

# Contare gli insegnanti che hanno l'ufficio nello stesso edificio
/*
SELECT COUNT(*) as `teachers`, `office_address`
FROM `teachers`
GROUP BY `office_address`
*/

# Calcolare la media dei voti di ogni appello d'esame
/*
SELECT `exam_id`, AVG(`vote`) as `average_vote`
FROM `exam_student`
GROUP BY `exam_id`
*/

# Contare quanti corsi di laurea ci sono per ogni dipartimento
/*
SELECT COUNT(*) as `degrees`, `department_id`
FROM `degrees`
GROUP BY `department_id`
*/


# ESERCIZI CON JOIN FATTI IN CLASSE
# Selezionare tutti i corsi del Corso di Laurea in Informatica (22)

#forma estesa
/*
SELECT *
FROM `courses`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Informatica"
*/

#forma filtrata
/*
SELECT `courses`.`id` AS `coursesId`, `courses`.`cfu`, `courses`.`name`, `courses`.`description`, `courses`.`period`, `courses`.`website`, `degrees`.`name`
FROM `courses`
JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Informatica"
*/


#  Selezionare le informazioni sul corso con id = 144, con tutti i relativi appelli d’esame

# estesa
/*
SELECT *
FROM `courses`
JOIN `exams` ON `exams`.`course_id` = `courses`.`id`
WHERE `courses`.`id` = 144
*/

#filtrata
/*
SELECT `courses`.`id` AS `coursesID`, `courses`.`name`, `courses`.`cfu`, `exams`.`id` AS `examsId`, `exams`.`date`, `exams`.`hour`, `exams`.`location`, `exams`.`address`
FROM `courses`
JOIN `exams` ON `exams`.`course_id` = `courses`.`id`
WHERE `courses`.`id` = 144
*/

# Selezionare a quale dipartimento appartiene il Corso di Laurea in Diritto dell'Economia (Dipartimento di Scienze politiche, giuridiche e studi internazionali)
/*
SELECT *
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Diritto dell'Economia"
*/
/*
SELECT `departments`.`id`, `departments`.`name` AS `departmentsName`, `departments`.`address` AS `departmentsAddress`, `departments`.`head_of_department`, `degrees`.`id`, `degrees`.`name` AS `degreesName`
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Diritto dell'Economia"
*/

# Selezionare tutti gli appelli d'esame del Corso di Laurea Magistrale in Fisica del primo anno
# tabelle necessarie: exams (tutti gli appelli d'esame), degrees (Corso di Laurea Magistrale in Fisica), courses (del primo anno)
/*
SELECT degrees.name AS Laurea, courses.name AS Corso, courses.period, courses.year, exams.date, exams.hour, exams.location, exams.address
FROM degrees
JOIN courses ON courses.degree_id = degrees.id
JOIN exams ON exams.course_id = courses.id
WHERE degrees.name = "Corso di Laurea Magistrale in Fisica" AND courses.year = 1
*/

#Selezionare tutti i docenti che insegnano nel Corso di Laurea in Lettere (21)
#cosa serve: teachers, degrees, course_teachers, courses
/*
SELECT DISTINCT teachers.name, teachers.surname, teachers.office_address
FROM teachers
JOIN course_teacher ON course_teacher.teacher_id = teachers.id
JOIN courses ON course_teacher.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
WHERE degrees.name = "Corso di Laurea in Lettere"
*/

# Selezionare il libretto universitario di Mirco Messina (matricola n. 620320)
# cosa serve: students (name, surname, enrolment_date, registration_number), courses , exams, exam_student 
/*
SELECT students.name AS studentName, students.surname AS studentSurname, students.enrolment_date, students.registration_number, courses.name AS coursesName, exam_student.vote
FROM students
JOIN exam_student ON exam_student.student_id = students.id
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
WHERE students.name = "Mirco" AND students.surname = "Messina" AND exam_student.vote >= 18
*/

# Selezionare il voto medio di superamento d'esame per ogni corso, con anche i dati del corso di laurea associato, ordinati per media voto decrescente
# exam_student, exams, courses, degrees
/*
SELECT ROUND(AVG(exam_student.vote), 1) AS media_voto, courses.name AS courseName, degrees.name AS laurea
FROM exam_student
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
WHERE exam_student.vote >= 18
GROUP BY courses.id
ORDER BY media_voto DESC
*/


#Utilizzando lo stesso database di ieri, eseguite le query in allegato.
# Caricate un secondo file nella stessa repo di ieri (db-university) con le query di oggi.

# Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
# cosa serve: students, degrees

SELECT *
FROM students
JOIN degrees ON students.degree_id = degrees.id
WHERE degrees.name = "Corso di Laurea in Economia";




# Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
# cosa serve: degrees, departments

SELECT *
FROM degrees
JOIN departments ON degrees.department_id = departments.id
WHERE degrees.level = "magistrale" AND departments.name = "Dipartimento di Neuroscienze";


# Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
# cosa serve: teachers, courses, course_teacher

SELECT teachers.name AS teacherName, teachers.surname AS teacherSurname, courses.id, courses.name
FROM courses
JOIN course_teacher ON course_teacher.course_id = courses.id
JOIN teachers ON course_teacher.teacher_id = teachers.id
WHERE teachers.name = "Fulvio" AND teachers.surname = "Amato";



#Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
# cosa serve: students, degrees, departments

SELECT students.id, students.surname, students.name, degrees.name AS degree, departments.name AS department
FROM students
JOIN degrees ON students.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
ORDER BY students.surname, students.name;





# Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
# cosa serve: degrees, courses => course_teacher => teachers

SELECT degrees.name AS degree, courses.name AS course, teachers.name AS teacherName, teachers.surname AS teacherSurname
FROM degrees
JOIN courses ON degrees.id = courses.degree_id
JOIN course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON course_teacher.teacher_id = teachers.id
ORDER BY degrees.name;





#Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
#cosa serve: teachers => course_teacher => courses, degrees, departments
SELECT DISTINCT teachers.id, teachers.name, teachers.surname, departments.name
FROM teachers
JOIN course_teacher ON teachers.id = course_teacher.teacher_id
JOIN courses ON course_teacher.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
WHERE departments.name = "Dipartimento di Matematica"
ORDER BY teachers.id





















