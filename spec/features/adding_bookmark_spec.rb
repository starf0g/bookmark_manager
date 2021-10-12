feature "Adding Bookmark" do

  scenario "entering url and see it" do
    visit '/bookmarks/new'
    fill_in("url", with: "https://facebook.com")
    click_button "Submit"
    expect(page).to have_content("https://facebook.com")

  end

end