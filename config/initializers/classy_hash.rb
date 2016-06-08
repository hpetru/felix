module ClassyHash
  ValidationException = Class.new(Exception)

  def self.raise_error(parent_path, key, message)
    raise(
      ValidationException,
      "#{join_path(parent_path, key)} is not #{message}"
    )
  end
end
