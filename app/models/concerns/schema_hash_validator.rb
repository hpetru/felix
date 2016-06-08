module SchemaHashValidator
  extend ActiveSupport::Concern

  def validate_hash_schema(schema, validatable_hash, errors_key)
    schema.each_pair do |key_name, constraint|
      input_value = validatable_hash[key_name]
      begin
        classy_hash_key_validate(
          validatable_hash,
          input_value,
          key_name,
          constraint
        )
      rescue ClassyHash::ValidationException => error
        errors.add(
          "#{errors_key}.#{key_name}",
          error.to_s
        )
      end
    end
  end

  def classy_hash_key_validate(validatable_hash, input_value, key_name, constraint)
    parent_path = nil
    if validatable_hash.include?(key_name)
      ClassyHash.check_one(key_name, input_value, constraint, parent_path)
    elsif !(constraint.is_a?(Array) && constraint.include?(:optional))
      ClassyHash.raise_error(parent_path, key_name, 'present')
    end
  end
end
