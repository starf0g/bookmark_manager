# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './lib/comment'
require './lib/tag'
require './database_connection_setup'
require 'pg'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = 
    "You must submit a valid URL" unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect('/bookmarks')
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'tags/new'
  end
  
  post '/bookmarks/:id/tags' do
    # move this to the model
    # we need to create the tag
    # we then need to add an entry to the BookmarksTags table to link the
    # bookmark id with the tag id

    # connect to the db
    connection = PG.connect(dbname: 'bookmark_manager_test')
    # create the tag and store the id and content
    tag = Tag.create(content: params[:tag])
    # add the bookmark id and tag id to the bookmarks_tags db
    connection.exec_params(
      "INSERT INTO bookmarks_tags (bookmark_id, tag_id) VALUES($1, $2)",
      [params[:id], tag.id]
    )
    p params[:tag]
    p params[:id]
    # p result[0]['id']
    # p result[0]['content']
    p tag.id
    p tag.content
    
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
