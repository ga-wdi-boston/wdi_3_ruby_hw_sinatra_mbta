RED_LINE =    ['south_station', 'park_st', 'kendall', 'central',
               'harvard', 'porter', 'davis', 'alewife']
GREEN_LINE =  ['haymarket', 'government_center', 'park_st', 'boylston', 'arlington', 'copley']
ORANGE_LINE = ['north_station', 'haymarket', 'park_st', 'state',
               'downtown_crossing', 'chinatown', 'back_bay', 'forest_hills']

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
    return calculate_distance_between_stops(line_on,  point_of_departure, line_on, 'park_st') +  calculate_distance_between_stops(line_off, 'park_st', line_off, destination)
  end
end