class BookmarkTag
  def self.create(bookmark_id:, tag_id:)
    result = DatabaseConnection.query(
      "INSERT INTO bookmarks_tags (bookmark_id, tag_id) VALUES($1, $2) RETURNING bookmark_id, tag_id;",
      [bookmark_id, tag_id]
    )
    BookmarkTag.new(bookmark_id: result[0]['bookmark_id'], tag_id: result[0]['tag_id'])
  end

  attr_reader :bookmark_id, :tag_id

  def initialize(bookmark_id:, tag_id:)
    @bookmark_id = bookmark_id
    @tag_id = tag_id
  end
end
