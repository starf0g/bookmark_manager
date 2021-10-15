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
end