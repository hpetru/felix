require 'rails_helper'

feature 'user sign in' do
  scenario 'user sign in with correct credentials' do
    password_stub = '1' * 10
    user = create(
      :user,
      password: password_stub
    )
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password_stub
    click_button 'Log in'

    expect(page).to_not have_content 'Log in'
  end
end
