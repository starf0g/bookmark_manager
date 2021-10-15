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

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content    
  end
end
