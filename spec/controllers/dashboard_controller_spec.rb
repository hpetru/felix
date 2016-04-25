require 'rails_helper'

describe DashboardController do
  render_views

  describe '#index' do
    context 'with signed in user' do
      it do
        sign_in create(:user)
        get :index

        expect(response.body).to have_content('Hello')
      end
    end

    context 'without signed in user' do
      it do
        get :index

        expect(response).to redirect_to(
          new_user_session_path
        )
      end
    end
  end
end
