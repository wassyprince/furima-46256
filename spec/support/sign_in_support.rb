# spec/support/sign_in_support.rb
module SignInSupport
  def sign_in(user)
     visit new_user_session_path
    expect(page).to have_selector('#email') # 描画を待つ
    find('#email').set(user.email)
    find('#password').set(user.password)
    click_button 'ログイン'
  end
end