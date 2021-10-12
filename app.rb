# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require 'pg'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  

  get '/bookmarks/new' do
    url = params[:url]
    erb :new
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/bookmarks' do

    Bookmark.create(url: params[:url])
    redirect '/bookmarks'

  end
end
