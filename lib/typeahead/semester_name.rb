module Typeahead
  class SemesterName < Base
    SEMESTER_MAPPING = {
      'I' => 'first_semester',
      'II' => 'second_semester',

      '1' => 'first_semester',
      '2' => 'second_semester'
    }

    def self.strategy_slug
      'semester_name'
    end

    def self.strategy_inputs_schema
      {
        'query' => String,
        'year' => Integer
      }
    end

    def strategy_data
      semesters.map do |semester|
        {
          value: semester.id,
          label: semester.display_label
        }
      end
    end

    private

    def semesters
      Semester.where(
        year: year,
        semester_type: semester_type
      )
    end

    def semester_type
      SEMESTER_MAPPING[query]
    end

    def year
      @strategy_inputs['year']
    end
  end
end
