require 'rails_helper'

describe Api::V0::FlexyTableController do
  describe 'GET #index' do
    it 'success with valid strategy_inputs' do
      sign_in create(:user)
      table_strategy_slug = ''
      column_strategy_slug = ''
      strategy_inputs = {}
      data_stub = {
        'cells' => [
          [1, 2],
          [3, 4]
        ],
        'strategy_column' => {
          'label' => 'Test column'
        }
      }
      strategy_stub = double(
        :strategy,
        valid?: true,
        data: data_stub,
      )
      allow(FlexyTable).to receive(:build_strategy).
        with(table_strategy_slug, column_strategy_slug, strategy_inputs).
        and_return(strategy_stub)

      get(
        :index,
        table_strategy_slug: table_strategy_slug,
        column_strategy_slug: column_strategy_slug,
        strategy_inputs: strategy_inputs
      )
      response_json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response_json).to eq(data_stub)
    end

    it 'return errors with invalid inputs' do
      sign_in create(:user)
      table_strategy_slug = ''
      column_strategy_slug = ''
      strategy_inputs = {}
      errors_stub = {
        'error.1' => 'message'
      }
      strategy_stub = double(
        :strategy,
        valid?: false,
        errors: errors_stub,
      )
      allow(FlexyTable).to receive(:build_strategy).
        with(table_strategy_slug, column_strategy_slug, strategy_inputs).
        and_return(strategy_stub)

      get(
        :index,
        table_strategy_slug: table_strategy_slug,
        column_strategy_slug: column_strategy_slug,
        strategy_inputs: strategy_inputs
      )
      response_json = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_json).to eq(errors_stub)
    end
  end
end
