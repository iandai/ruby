require_relative 'graph'
require 'logger'
	
	def distance_ABC(g)
		return "No Such Route." if g.weight('A','B').nil? || g.weight('B','C').nil?
		g.weight('A','B') + g.weight('B','C')
	end
	
	def distance_AD(g)
		return "No Such Route." if g.weight('A','D').nil?
		g.weight('A','D')
	end
	
	def distance_ADC(g)
		return "No Such Route." if g.weight('A','D').nil? || g.weight('D','C').nil?
		g.weight('A','D') + g.weight('D','C')
	end
	
	def distance_AEBCD(g)
		return "No Such Route." if g.weight('A','E').nil? || g.weight('E','B').nil? || g.weight('B','C').nil? || g.weight('C','D').nil?
		g.weight('A','E') + g.weight('E','B') + g.weight('B','C')+ g.weight('C','D')
	end
	
	def distance_AED(g)
		return "No Such Route." if g.weight('A','E').nil? || g.weight('E','C').nil?
		g.weight('A','E') + g.weight('E','C')
	end
	
	def find_route_number_by_transfer_time(start_stop,end_stop,transfer_times,graph)
		last_stops = Array.new()
		current_stops = Array.new()
		last_stops << start_stop
		while transfer_times > 0
			last_stops.each do |stop|
				graph.ajacent_vertices(stop).each do |v|
					current_stops << v
				end
			end
			transfer_times -=1
			last_stops = current_stops.dup()
			current_stops = []
		end
		return last_stops.count(end_stop)
	end
	
	def find_route_number_by_distance(start_stop,end_stop,max_distance,graph)
		# stops_set is a set containing all the stops whose distance to start_stop less than max_distance
		last_stops = [[start_stop,0]]
		current_stops = []
		number_of_routes = 0 
		while(!last_stops.empty?)
			last_stops.each do |last_stop|
				graph.ajacent_vertices(last_stop[0]).each do |new_stop|	
					next	if !graph.weight(last_stop[0],new_stop)						
					if (last_stop[1] + graph.weight(last_stop[0],new_stop)) < 30 
						current_stops << [new_stop,(last_stop[1] + graph.weight(last_stop[0],new_stop))]
						if new_stop == end_stop
							number_of_routes +=1 
						end
					end
				end							
			end
		last_stops = current_stops
		current_stops = []
		end
		return number_of_routes		
	end
		
	INFINITY = 1 << 32
	def find_shortest_route_to_self(start_vertex,graph)
		min = INFINITY
		graph.previous_ajacent_vertices(start_vertex).each do |v|
			if graph.dijkstra_route(start_vertex,v) == INFINITY
				next			
			else
				total_distance = graph.dijkstra_route(start_vertex,v) + graph.weight(v,start_vertex)
			end
			return min = total_distance if min > total_distance
		end
	end
	
# Start Solve Problem
# Graph: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
# ruby 1.9.2  Rspec 2.9.0
g = Graph.new
g.add_edge("A","B",5)
g.add_edge("B","C",4)
g.add_edge("C","D",8)
g.add_edge("D","C",8)
g.add_edge("D","E",6)
g.add_edge("A","D",5)
g.add_edge("C","E",2)
g.add_edge("E","B",3)
g.add_edge("A","E",7)

puts "1. The distance of the route A-B-C."
puts "Output #1: #{distance_ABC(g)}"
puts "2. The distance of the route A-D."
puts "Output #2: #{distance_AD(g)}"
puts "3. The distance of the route A-D-C."
puts "Output #3: #{distance_ADC(g)}"
puts "4. The distance of the route A-E-B-C-D."
puts "Output #4: #{distance_AEBCD(g)}"
puts "5. The distance of the route A-E-D."
puts "Output #5: #{distance_AED(g)}"
puts "6. The number of trips starting at C and ending at C with a maximum of 3 stops. "
puts "Output #6: #{find_route_number_by_transfer_time('C','C',1,g) + find_route_number_by_transfer_time('C','C',2,g) + find_route_number_by_transfer_time('C','C',3,g)}"
puts "7. The number of trips starting at A and ending at C with exactly 4 stops. "
puts "Output #7: #{find_route_number_by_transfer_time('A','C',4,g)}"
puts "8. The length of the shortest route (in terms of distance to travel) from A to C."
puts "Output #8: #{g.dijkstra_route("A","C")}"
puts "9. The length of the shortest route (in terms of distance to travel) from B to B."
puts "Output #9: #{find_shortest_route_to_self("B",g)}"
puts "10. The number of different routes from C to C with a distance of less than 30."
puts "Output #10: #{find_route_number_by_distance('C','C',30,g)}"