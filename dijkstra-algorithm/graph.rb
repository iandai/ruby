class Graph
	def initialize()
		# @g[a][b],@[a][c]  => {a => { b => weight, c => weight}}
		@graph = {}
		@vertices = Array.new
		@INFINITY = 1 << 32
	end
	
	def add_edge(source,target,weight)
		if !@vertices.include?(source)
			@vertices << source
		end
		if !@vertices.include?(target)
			@vertices << target
		end	
		
		if !@graph.has_key?(source)	 
			@graph[source] = {target => weight}		 
		else
			@graph[source][target] = weight        
		end 
	end
	
	# returns nil if no such route
	def weight(x,y)
		@graph[x][y] if @graph[x]
	end
	
	def ajacent_vertices(current_vertex)
		if @graph[current_vertex]
			@graph[current_vertex].keys 
		else
			[]
		end
	end
	
	def previous_ajacent_vertices(current_vertex)
		previous_vertices = []
		@vertices.each do |v|
			if @graph[v]
				previous_vertices << v unless @graph[v][current_vertex] == nil
			end
		end
		return previous_vertices
	end

	# if no such route, returns @infinity number; for the same vertex, returns 0
	# distance_to_start stores the distance from start_vertex to current_vertex
	# previous stores the current_vertex's father vertex
	def dijkstra_route(start_vertex,end_vertex)
		distance_to_start = {}
		previous = {}
		current_vertex = String.new
		for v in @vertices
			distance_to_start[v] = @INFINITY
			previous[v] = ""
		end
		distance_to_start[start_vertex] = 0
		known_set = []
		unknown_set = @vertices.dup()
		# main part of algorithm
		while !unknown_set.empty?
			min_distance = @INFINITY
			unknown_set.each do |v|
				if min_distance >= distance_to_start[v]
					min_distance = distance_to_start[v] 
					current_vertex = v
				end
			end
			unknown_set.delete(current_vertex)
			return total_distance = distance_to_start[current_vertex] if current_vertex == end_vertex
			known_set << current_vertex
			ajacent_vertices(current_vertex).each do |v|
				if !known_set.include?(v)
					if distance_to_start[v] > distance_to_start[current_vertex] + weight(current_vertex,v)
						distance_to_start[v] = distance_to_start[current_vertex] + weight(current_vertex,v)
						previous[v] = current_vertex
					end
				end	
			end
		end
	end
	
end