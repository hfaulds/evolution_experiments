require 'Population'

population = Population.new(1000, "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
i=0
until population.next_generation == 0 do
	i+=1
	puts "generation " + i.to_s
	population.log_best
end
population.order_population
population.log
puts "generation " + i.to_s + " best :"
population.log_best
