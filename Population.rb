require 'Individual'

class Population
	def initialize(population_size, target)
		@target = target

		@population = []
		population_size.times do
			@population.push Individual.create_random(target, target.length)
		end
	end

	def next_generation
		target_length = @population.length
		cull_population
		repopulate(target_length).first.score
	end

	def cull_population
		order_population
		@population.each_index do |index|
			if should_be_culled?(index)
				@population.delete_at(index)
			end
		end	
	end
	
	def repopulate(target_length)
		order_population
		growth = target_length - @population.length
		babies = []
		growth.times do
			mate_a = find_mate(@population)
			mate_b = find_mate_for(mate_a)
			babies << mate_a.mate_with(mate_b)
		end
		@population += babies
	end
	
	def should_be_culled?(index)
		rand(@population.length) <= index	
	end

	def should_mate(index)
		rand(@population.length) > index
	end
	
	def find_mate(population)
		while true do
			population.each_index do |index|
				if should_mate(index)
						return population[index]
				end
			end
		end
	end
	
	def find_mate_for(individual)
		their_index = @population.index(individual)
		rest_of_pop = @population.slice((0..their_index-1)) + @population.slice((their_index+1..@population.length))
		find_mate(rest_of_pop)
	end

	def order_population
		@population.sort! do |a,b,|
			a.score <=> b.score
		end	
	end
	
	def log
		puts "-----"
		@population.each do |individual|
			puts individual.to_s
		end
	end

	def log_best
		puts @population.first.to_s
	end
end
