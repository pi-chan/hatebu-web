
@login_link = "Login with Hatena"
@logout_link = "Log out"

step 'visit root page' do
  visit '/'
end

step 'redirect to login page' do
  expect(page.current_path).to eq("/login")
end

step 'there should be a login link' do
  expect(page).to have_link(@login_link)
end

step 'I clicked the login link' do
  @user = create_user
  setup_omniauth_test(@user)
  click_link @login_link
end

step 'login completes' do
  expect(page).to have_selector('h1',"#{@user.name} home")
end

step 'visit login page' do
  visit '/login'
end

step 'redirect to root page' do
  expect(page.current_path).to eq("/")
end

step 'there should be a logout link' do
  expect(page).to have_link(@logout_link)
end

step 'I clicked the logout link' do
  click_link @logout_link
end

step 'logout completes' do
  expect(page.current_path).to eq("/login")
end



