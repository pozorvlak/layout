set :haml, :format => :html5

# how many circles can you fit into a width * height rectangle, if plants
# must be 2y apart and you are using a hexagonal lattice?
# For a derivation, see
# https://twitter.com/pozorvlak/status/388056883153473538/photo/1
def fit_hexagons(width, height, y)
  x = y/Math.sqrt(3)                # half the width of a hexagon side
  num_rows = (height / y - 1).floor
  num_cols = ((width / x - 1)/3).floor
  if num_rows.even?
    # all columns have equal height
    return num_rows * num_cols
  else
    # odd-numbered columns are one hex taller
    num_odds = (num_cols / 2).ceil
    return num_rows * num_cols + num_odds
  end
end

get '/' do
  width = params[:width].to_f
  height = params[:height].to_f
  y = params[:y].to_f
  unless (y.nil? || width.nil? || height.nil?)
    num_hexes = fit_hexagons(width, height, y)
  end
  haml :index, :locals => {
    :width => width,
    :height => height,
    :y => y,
    :num_hexes => num_hexes
  }
end
