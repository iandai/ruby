# ruby 1.9.2  Rspec 2.9.0
require_relative 'graph'

describe Graph do
	before(:each) do 
		# Graph: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
		@g = Graph.new
		@g.add_edge("A","B",5)
		@g.add_edge("B","C",4)
		@g.add_edge("C","D",8)
		@g.add_edge("D","C",8)
		@g.add_edge("D","E",6)
		@g.add_edge("A","D",5)
		@g.add_edge("C","E",2)
		@g.add_edge("E","B",3)
		@g.add_edge("A","E",7)
	end
	
	describe "#add_edge" do
		it "add edge to the graph to existing vertices" do
			@g.add_edge("B","A",5)
			@g.weight("B","A").should eql 5
		end
		
		it "add edge to the graph to non-exsiting vertices" do
			@g.add_edge("G","F",8)
			@g.weight("G","F").should eql 8
		end
	end

	describe "#weight" do
		it "get weight of two existing vertices" do
			@g.weight("A","B").should eql 5
		end
		
		it "get weight of non-exsiting vertices" do
			@g.weight("S","T").should eql nil
		end
	end

	describe "#ajacent_vertices" do
		it "gets a vertex and returns it's next vertices" do
				@g.ajacent_vertices("A").should eql ["B","D","E"]
		end
		
		it "gets a vertex not included in the Graph vertices" do
				@g.ajacent_vertices("F").should eql []
		end
	end
	
	describe "#previous_ajacent_vertices" do
		it "gets a vertex and returns it's previous vertices" do
			@g.previous_ajacent_vertices("B").should eql ["A","E"]
		end
		
		it "gets a vertex and returns []" do
			@g.previous_ajacent_vertices("A").should eql []
		end
	end

	describe "#dijkstra_route" do
		it "gets the number of the shortest route for different vertices" do
			@g.dijkstra_route("A","C").should eql 9
		end
		
		it "gets the number of the shorest route for the same vertices" do
			@g.dijkstra_route("B","B").should eql 0
		end
	end
	
end