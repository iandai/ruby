require_relative "train_problems"

describe "Train Problems" do
	before (:each) do 
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
	
	describe "#distance_ABC" do
		it "gets distance from A to B to C" do
			distance_ABC(@g).should eql 9
		end
	end

	describe "#distance_AD" do
		it "gets distance from A to D" do
			distance_AD(@g).should eql 5
		end
	end
	
	describe "#distance_ADC" do
		it "gets distance from A to D to C" do
			distance_ADC(@g).should eql 13
		end
	end
	
	describe "#distance_AEBCD" do
		it "gets distance from A to E to B to C to D" do
			distance_AEBCD(@g).should eql 22
		end
	end
	
	describe "#distance_AED" do
		it "gets distance from A to E to D" do
			distance_AED(@g).should eql "No Such Route."
		end
	end	
	
	describe "#find_route_number_by_transfer_time" do
		it "gets The number of trips starting at A and ending at C with exactly 4 stops." do
			number_of_trips = find_route_number_by_transfer_time('A','C',4,@g)
			number_of_trips.should eql 3
		end
	end	
	
	describe "#dijkstra_route" do
		it "The length of the shortest route (in terms of distance to travel) from A to C." do
			number_of_trips = @g.dijkstra_route("A","C")
			number_of_trips.should eql 9
		end
	end	

	describe "#find_shortest_route_to_self" do
		it "The length of the shortest route (in terms of distance to travel) from B to B." do
			number_of_trips = find_shortest_route_to_self("B",@g)
			number_of_trips.should eql 9
		end
	end	
	

	describe "#find_route_number_by_distance" do
		it "The number of different routes from C to C with a distance of less than 30." do
			number_of_trips = find_route_number_by_distance('C','C',30,@g)
			number_of_trips.should eql 7
		end
	end		
	
	
end