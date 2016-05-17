namespace :load do
  def csv_foreach(filepath, &block)
    CSV.foreach(filepath, headers: true, &block)
  end

  def upsert_record!(model_class, attributes, save_attributes = nil)
    save_attributes ||= attributes
    record = model_class.where(
      attributes
    ).first

    unless record
      record = model_class.create(
        save_attributes
      )
      unless record.valid?
        Rails.logger.error(
          "[UPSERT] #{model_class} #{record.errors.to_json}"
        )
        raise
      end
    end

    Rails.logger.debug(
      "[UPSERT] #{model_class} - #{save_attributes.to_json}"
    )

    record
  end

  def filter_keys(hash, keys)
    Hash[hash.select { |key, _| keys.include? key }]
  end

  def year_from_grade(grade, study_year=nil)
    if study_year.nil?
      study_year = Date.today.month > 8 ? Date.today.year : Date.today.year - 1
    end
    study_year - grade + 1
  end

  task setup_logger: :environment do
    Rails.logger = Logger.new(STDOUT)
  end

  task subjects: :setup_logger do
    filepath = 'tmp/csvs/subjects.csv'
    csv_foreach filepath do |subject|
      upsert_record!(
        Subject,
        name: subject['name']
      )
    end
  end

  task addresses: :setup_logger do
    filepath = 'tmp/csvs/addresses.csv'
    csv_foreach filepath do |adress|
      city = upsert_record!(
        City,
        name: adress['city']
      )

      upsert_record!(
        Address,
        street: adress['street'],
        city: city
      )
    end
  end

  task teachers: :setup_logger do
    filepath = 'tmp/csvs/teachers.csv'
    csv_foreach filepath do |teacher|
      if teacher['graduated_from']
        institution  = upsert_record!(
          Institution,
          name: teacher['graduated_from']
        )
      end

      if teacher['subjects']
        subjects = teacher['subjects'].split(';').map do |subject|
          upsert_record!(
            Subject,
            name: subject.strip
          )
        end
      else
        subjects = []
      end

      upsert_record!(
        Teacher,
        filter_keys(
          teacher.to_h,
          [
            'first_name',
            'last_name'
          ]
        ),
        {
          graduated_from: institution,
          subjects: subjects,
        }.merge(
          filter_keys(
            teacher.to_h,
            [
              'first_name',
              'last_name',
              'degree',
              'degree_reeval_year',
              'retired',
              'syndicate_member',
              'gender',
              'idnp_token',
              'birthday'
            ]
          )
        )
      )
    end
  end

  task student_groups: :setup_logger do
    filepath = 'tmp/csvs/student_groups.csv'
    csv_foreach filepath do |student_group|
      main_teacher = Teacher.where(
        last_name: student_group['main_teacher']
      ).first!

      upsert_record!(
        StudentGroup,
        promotion: year_from_grade(
          student_group['study_year'].to_i
        ),
        suffix: student_group['suffix'].upcase,
        main_teacher: main_teacher
      )
    end
  end

  task students: :setup_logger do
    foreign_languages = {
      'f' => Subject.where(name: 'Limba franceză').first!,
      'g' => Subject.where(name: 'Limba germană').first!
    }
    filepath = 'tmp/csvs/students.csv'
    csv_foreach filepath do |student|
      group = StudentGroup.where(
        promotion: year_from_grade(
          student['study_year'].to_i
        ),
        suffix: student['group_suffix'].upcase
      ).first!

      if student['address_street']
        city = upsert_record!(
          City,
          name: student['address_city']
        )
        address = upsert_record!(
          Address,
          city: city,
          street: student['address_street']
        )
      end

      if student['came_from']
        came_from = upsert_record!(
          Institution,
          name: student['came_from']
        )
      end

      nationality = Nationality.where(
        name: student['nationality'].capitalize
      ).first_or_create!

      foreign_language = student['foreign_language'].nil? ? nil :
        foreign_languages.fetch(
          student['foreign_language']
        )

      upsert_record!(
        Student,
        {
          first_name: student['first_name'],
          last_name: student['last_name'],
          student_group: group
        },
        {
          address: address,
          student_group: group,
          came_from: came_from,
          nationality: nationality,
          foreign_language: foreign_language
        }.merge(
          filter_keys(
            student,
            [
              'first_name',
              'last_name',
              'inside_code_token',
              'came_at',
              'gender',
              'idnp_token',
              'mother_phone_number',
              'father_phone_number',
              'mother_last_name',
              'mother_first_name',
              'father_last_name',
              'father_first_name',
              'born_at',
              'mother_email',
              'father_email',
              'address_house',
              'address_appartment'
            ]
          )
        )
      )
    end
  end

  task grades: :setup_logger do
    def is_float?(fl)
      !!Float(fl) rescue false
    end

    filepath = 'tmp/csvs/grades.csv'
    csv_foreach filepath do |row|
      study_year = row["study_year"].to_i # clasa
      year = row["year"].to_i             # anul de studii
      student = Student.joins(:student_group).find_by(
        first_name: row["first_name"],
        last_name: row["last_name"],
        student_groups: {
          promotion: year_from_grade(study_year, row["year"].to_i)
        }
      )

      next if !student || !row["grade_type"].include?('Sem')
      semester_type = row["grade_type"] == 'Sem I' ? :first_semester : :second_semester
      semester = Semester.find_by!(semester_type: semester_type, year: year)
      grades = row.to_hash.except(
        "first_name",
        "last_name",
        "study_year",
        "suffix",
        "year",
        "grade_type",
        "average"
      )

      grades.each do |subject_name, value|
        subject = Subject.find_by(name: subject_name)
        next if !subject || !is_float?(value)

        upsert_record!(
          StudentSemesterGrade,
          {
            student: student,
            semester: semester,
            subject: subject,
          },
          {
            value: value.to_f,
            student: student,
            semester: semester,
            subject: subject
          }
        )
      end
    end
  end
end
