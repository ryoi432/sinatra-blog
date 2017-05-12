require 'sinatra/base'
require 'csv'

class RankingRoute < Sinatra::Base
  get '/ranking' do
    @ranking = CSV.read("ranking.csv")
    @ranking.sort!{|a, b| b[1].to_i <=> a[1].to_i}
    @ranking = @ranking.slice(0, 5)
    @ranking.each do |e|
      File.open("data/blog_#{e[0]}.txt", 'r:utf-8') do |file|
        e[2] = file.readline
      end
    end
    erb :ranking
  end
  run! if __FILE__ == $0
end
