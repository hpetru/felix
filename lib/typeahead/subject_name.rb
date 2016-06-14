module Typeahead
  class SubjectName < Base
    def self.strategy_slug
      'subject_name'
    end

    def self.strategy_inputs_schema
      {
        'query' => String
      }
    end

    def strategy_data
      subjects.map do |subject|
        {
          value: subject.id,
          label: subject.name
        }
      end
    end

    private

    def subjects
      arel = Subject.arel_table
      Subject.where(
        arel[:name].matches("%#{query}%")
      ).order(:name)
    end
  end
end
