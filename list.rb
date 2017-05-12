require 'sinatra/base'

class ListRoute < Sinatra::Base
  get '/list' do
    @article_list = []
    list = []
    Dir.foreach('./data'){|file|
      next if file =~ /^\.+$/
      list.push(file)
    }
    list.sort!{|a, b| b <=> a}
    list.each do |e|
      File.open("data/#{e}", 'r:utf-8') do |file|
        hash = {}
        hash[:title] = file.readline
        hash[:article_id] = /blog_(\d+).txt/.match(e).to_a[1]
        hash[:filename] = e
        @article_list.push(hash)
      end
    end
    erb :list
  end
  run! if __FILE__ == $0
end
