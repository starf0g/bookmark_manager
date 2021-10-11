feature 'Viewing bookmarks' do
  scenario 'visiting /bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content 'https://www.github.com'
    expect(page).to have_content 'https://www.bbc.com'
    expect(page).to have_content 'https://www.google.com'
  end
end
