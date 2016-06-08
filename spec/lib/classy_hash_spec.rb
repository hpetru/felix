require 'rails_helper'

describe ClassyHash do
  describe '.raise_error' do
    it do
      expect { described_class.raise_error('a', 'b', 'c') }.to raise_error(
        ClassyHash::ValidationException
      )
    end
  end
end
