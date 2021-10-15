# frozen_string_literal: true

class Tag
  def self.create(content:)
    result = DatabaseConnection.query(
      "INSERT INTO tags (content) VALUES($1) RETURNING id, content;",
      [content]
    )
    Tag.new(
      id: result[0]['id'],
      content: result[0]['content']
    )
  end

  def self.where(bookmark_id:)
    result = DatabaseConnection.query(
      "SELECT id, content FROM bookmarks_tags INNER JOIN tags ON tags.id = bookmarks_tags.tag_id WHERE bookmarks_tags.bookmark_id = $1;",
      [bookmark_id]
    )
    result.map do |tag|
      Tag.new(
        id: tag['id'],
        content: tag['content'],
      )
    end
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content    
  end
end
