require 'sinatra/base'

class EditRoute < Sinatra::Base
  get '/edit/:article_id' do
    @article_id = params[:article_id]
    File.open("data/blog_#{params[:article_id]}.txt", 'r:utf-8') do |file|
      @title = file.readline
      @body = file.read
    end
    erb :edit
  end
  post '/edit/:article_id' do
    File.open("data/blog_#{params[:article_id]}.txt", 'w:utf-8') do |file|
      file.write("#{params[:title]}\n#{params[:body]}")
    end
    erb :edited
  end
  run! if __FILE__ == $0
end
