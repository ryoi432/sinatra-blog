require 'sinatra/base'
require 'csv'

class DeleteRoute < Sinatra::Base
  get '/delete/:article_id' do
    File.delete("data/blog_#{params[:article_id]}.txt")
    ranking = CSV.read("ranking.csv")
    CSV.open("ranking.csv", "w:utf-8") do |csv|
      ranking.each do |e|
        if e[0] != params[:article_id]
          csv << e
        end
      end
    end
    erb :deleted
  end
  run! if __FILE__ == $0
end
