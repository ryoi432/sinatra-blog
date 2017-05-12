require 'sinatra/base'
require 'csv'

class WatchRoute < Sinatra::Base
  get '/watch/:article_id' do
    @article_id = params[:article_id]
    dates = /(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/.match(@article_id).to_a
    @date = "#{dates[1]}/#{dates[2]}/#{dates[3]} #{dates[4]}:#{dates[5]}:#{dates[6]}"
    File.open("data/blog_#{@article_id}.txt", 'r:utf-8') do |file|
      @title = file.readline
      @body = file.read
    end
    ranking = CSV.read("ranking.csv")
    ranking.each do |e|
      if e[0] == @article_id
        count = e[1].to_i
        count += 1
        e[1] = count.to_s
      end
    end
    CSV.open("ranking.csv", "w:utf-8") do |csv|
      ranking.each do |e|
        csv << e
      end
    end
    erb :watch
  end
  run! if __FILE__ == $0
end
