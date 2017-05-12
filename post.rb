require 'sinatra/base'

require 'date'
require 'csv'

class PostRoute < Sinatra::Base
  get '/post' do
    erb :post
  end
  post '/post' do
    date = DateTime.now
    article_id = date.strftime('%Y%m%d%H%M%S')
    File.open("data/blog_#{article_id}.txt", 'w:utf-8') do |file|
      file.write("#{params[:title]}\n#{params[:body]}")
    end
    ranking = CSV.read("ranking.csv")
    ranking.push([article_id, 0])
    CSV.open("ranking.csv", "w:utf-8") do |csv|
      ranking.each do |e|
        csv << e
      end
    end
    erb :posted
  end
  run! if __FILE__ == $0
end
