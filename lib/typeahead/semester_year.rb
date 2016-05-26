module Typeahead
  class SemesterYear < Base
    def self.strategy_slug
      'semester_year'
    end

    def self.strategy_inputs_schema
      {
        'query' => String
      }
    end

    def strategy_data
      semesters.map do |semester|
        {
          value: semester.year,
          label: semester.year
        }
      end
    end

    private

    def semesters
      Semester.
        where(year_node.matches("#{query}%")).
        select(:year).
        group(:year).
        order(year: :desc)
    end

    def arel_table
      Semester.arel_table
    end

    def year_node
      Arel::Nodes::NamedFunction.new(
        'CONCAT',
        [
          arel_table[:year],
          Arel::Nodes.build_quoted('')
        ]
      )
    end
  end
end
