require 'sinatra/base'

class IndexRoute < Sinatra::Base
  get '/' do
    @article_list = []
    list = []
    Dir.foreach('./data'){|file|
      next if file =~ /^\.+$/
      list.push(file)
    }
    list.sort!{|a, b| b <=> a}
    list = list.slice(0, 3)
    list.each do |e|
      File.open("data/#{e}", 'r:utf-8') do |file|
        hash = {}
        hash[:title] = file.readline
        hash[:article_id] = /blog_(\d+).txt/.match(e).to_a[1]
        hash[:filename] = e
        dates = /(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/.match(hash[:article_id]).to_a
        hash[:date] = "#{dates[1]}/#{dates[2]}/#{dates[3]} #{dates[4]}:#{dates[5]}:#{dates[6]}"
        hash[:body] = file.read
        @article_list.push(hash)
      end
    end
    erb :index
  end
  run! if __FILE__ == $0
end
