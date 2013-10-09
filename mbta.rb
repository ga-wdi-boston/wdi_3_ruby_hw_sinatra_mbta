require 'pry'

RED_LINE =    ['south station', 'park st', 'kendall', 'central',
               'harvard', 'porter', 'davis', 'alewife']
GREEN_LINE =  ['haymarket', 'government center', 'park st', 'boylston', 'arlington', 'copley']
ORANGE_LINE = ['north station', 'haymarket', 'park st', 'state',
               'downtown crossing', 'chinatown', 'back bay', 'forest hills']

MBTA_SUBWAY_SYSTEM = { red: RED_LINE, green: GREEN_LINE, orange: ORANGE_LINE }

def calculate_position_of_stop(line, stop)
  MBTA_SUBWAY_SYSTEM[line.to_sym].index(stop)
end

def calculate_distance_between_stops(line_on, start, line_off, stop)
  (calculate_position_of_stop(line_on, start) - calculate_position_of_stop(line_off, stop)).abs
end

def calculate_number_of_stops(line_on, point_of_departure, line_off, destination)
  if line_on == line_off
    return calculate_distance_between_stops(line_on, point_of_departure, line_off, destination)
  else
    return calculate_distance_between_stops(line_on,  point_of_departure, line_on, 'park st') +  calculate_distance_between_stops(line_off, 'park st', line_off, destination)
  end
end