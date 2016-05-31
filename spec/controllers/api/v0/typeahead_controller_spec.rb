require 'rails_helper'

describe Api::V0::TypeaheadController do
  describe 'GET #index' do
    it do
      strategy_data = [
        {
          'value' => 1,
          'label' => 'Label1'
        },
        {
          'value' => 2,
          'label' => 'Label2'
        }
      ]
      strategy_stub = double(
        strategy_data: strategy_data
      )
      strategy_slug = 'strategy_slug_name'
      strategy_inputs = {
        'a' => 'b'
      }
      allow(Typeahead).to receive(:new_strategy).
        with(strategy_slug, strategy_inputs).
        and_return(strategy_stub)
      get(
        :index,
        strategy_slug: strategy_slug,
        strategy_inputs: JSON.generate(strategy_inputs)
      )
      reponse_data = JSON.parse(response.body)

      expect(reponse_data).to eq(
        'results' => strategy_data
      )
    end
  end
end
