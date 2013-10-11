set :haml, :format => :html5

get '/' do
  haml :index, :locals => { :y => params[:y] }
end
