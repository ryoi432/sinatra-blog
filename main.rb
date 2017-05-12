# 1:34:50
require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'post'
require_relative 'list'
require_relative 'watch'
require_relative 'edit'
require_relative 'delete'
require_relative 'ranking'
require_relative 'index'

class SinatraBlogApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  use PostRoute
  use ListRoute
  use WatchRoute
  use EditRoute
  use DeleteRoute
  use RankingRoute
  use IndexRoute

  run! if __FILE__ == $0
end
