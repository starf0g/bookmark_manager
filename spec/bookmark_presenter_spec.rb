require 'bookmark_presenter'

describe BookmarkPresenter do
  describe '.all' do
    it 'return a list of all bookmarks' do
      bookmarks_list = [
        "https://www.github.com",
        "https://www.bbc.com",
        "https://www.google.com"
      ]
      bookmarks = BookmarkPresenter.all
      expect(bookmarks).to eq bookmarks_list
    end
  end
end