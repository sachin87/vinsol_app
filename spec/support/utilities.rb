include ApplicationHelper

  def sign_in(user)
    visit root_path
    fill_in "Name", with: (user.name || "Example User")
    click_button "Go"
  end