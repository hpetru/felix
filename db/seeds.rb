User.create!(
  email: 'hincupetru@gmail.com',
  password: 'babuin2015'
)

User.create!(
  email: 'doringutsu@gmail.com',
  password: 'messenger'
)

User.create!(
  email: 'grigore.vasilache@gmail.com',
  password: 'grigore.vasilache@gmail.com'
)

(2000..2025).each do |year|
  Semester.create!(
    year: year,
    semester_type: :first_semester
  )

  Semester.create!(
    year: year,
    semester_type: :second_semester
  )
end
