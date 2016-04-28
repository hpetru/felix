User.create!(
  email: 'hincupetru@gmail.com',
  password: 'babuin2015'
)

first_semester = Semester.create(
  year: 2015,
  semester_type: 'first_semester'
)
second_semester = Semester.create(
  year: 2015,
  semester_type: 'second_semester'
)

subjects = {}
[
  'Limba şi literatura română',
  'Limba  germană',
  'Limba franceză',
  'Matematică',
  'Fizică, Astronomie',
  'Chimie',
  'Biologie',
  'Geografie',
  'Educaţie civică',
  'Informatică'
].each do |name|
  subjects[name] = Subject.where(name: name).first_or_create!
end

sveta = Teacher.create!(
  first_name: 'Svetlana',
  last_name: 'Vîrlan',
  degree: 'first_degree',
  birthday: Date.current - 20.years
)

ana = Teacher.create!(
  first_name: 'Ana',
  last_name: 'Raţă',
  degree: 'second_degree',
  birthday: Date.current - 20.years
)

ion = Teacher.create!(
  first_name: 'Ion',
  last_name: 'Adomnita',
  degree: 'third_degree',
  birthday: Date.current - 17.year
)

grupa1 = StudentGroup.create!(
  promotion: 2010,
  suffix: 'A',
  profile_slug: 'real',
  main_teacher: ana
)

StudentGroup.create!(
  promotion: 2011,
  suffix: 'B',
  profile_slug: 'real',
  main_teacher: sveta
)

TeachingSubject.create!(
  teacher: ion,
  subject: subjects['Biologie'],
  student_group: grupa1
)

Student.create!(
  first_name: 'Andrei',
  last_name: 'Bernic',
  student_group: grupa1,
  semester_grades: [
    StudentSemesterGrade.new(
      value: 10,
      subject: subjects['Matematică'],
      semester: first_semester
    ),
    StudentSemesterGrade.new(
      value: 8,
      subject: subjects['Matematică'],
      semester: second_semester
    )
  ],
  anual_grades: [
    StudentAnualGrade.new(
      subject: subjects['Matematică'],
      value: 9,
      year: 2015
    )
  ],
  thesis_grades: [
    StudentThesisGrade.new(
      subject: subjects['Matematică'],
      value: 8,
      semester: first_semester
    ),
    StudentThesisGrade.new(
      subject: subjects['Matematică'],
      value: 8,
      semester: second_semester
    )
  ]
)
