set :haml, :format => :html5

# how many circles can you fit into a width * length rectangle, if plants
# must be 2y apart and you are using a hexagonal lattice?
# For a derivation, see
# https://twitter.com/pozorvlak/status/388056883153473538/photo/1
def fit_hexagons(width, length, y)
  x = y/Math.sqrt(3)                # half the width of a hexagon side
  num_rows = (length / y - 1).floor
  num_cols = ((width / x - 1)/3).floor
  if num_rows.even?
    # all columns have equal length
    return num_rows * num_cols
  else
    # odd-numbered columns are one hex taller
    num_odds = (num_cols / 2).ceil
    return num_rows * num_cols + num_odds
  end
end

get '/' do
  width = params[:width]
  length = params[:length]
  diameter = params[:diameter]
  unless width.nil? or length.nil? or diameter.nil?
    num_hexes = fit_hexagons(width.to_f, length.to_f, diameter.to_f / 2)
  else
    num_hexes = nil
  end
  haml :index, :locals => {
    :width => width,
    :length => length,
    :diameter => diameter,
    :num_hexes => num_hexes
  }
end
