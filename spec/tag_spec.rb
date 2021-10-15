# frozen_string_literal: true

require 'database_helpers'

require 'tag'
require 'bookmark'

describe Tag do
  describe '.create' do
    it 'creates a new tag' do
      tag = Tag.create(content: 'test tag')

      persisted_data = persisted_data(id: tag.id, table: 'tags')

      expect(tag).to be_a Tag
      expect(tag.id).to eq persisted_data.first['id']
      expect(tag.content).to eq 'test tag'
    end
  end

  describe '.where' do
    it 'returns tags linked to the given bookmark id' do
      # create bookmark
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      # create tags
      tag1 = Tag.create(content: 'test tag 1')
      tag2 = Tag.create(content: 'test tag 2')
      # create bookmark to tag links
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag1.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag2.id)

      # get the tags linked to our bookmark
      tags = Tag.where(bookmark_id: bookmark.id)
      tag = tags.first

      # tests
      expect(tags.length).to eq 2
      expect(tag).to be_a Tag
      expect(tag.id).to eq tag1.id
      expect(tag.content).to eq tag1.content
    end
  end
end
