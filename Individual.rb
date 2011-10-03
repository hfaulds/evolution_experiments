require 'ReproductionSystem'

class Individual
	attr_reader :score

	def initialize(target, reproduction_system)
		@target = target
		@reproduction_system = reproduction_system
		@score = calc_score
	end

	def self.create_random(target, output_length)
		Individual.new(target, ReproductionSystem.create_random(output_length))
	end

	def calc_score
		score = 0
		@reproduction_system.genes.each_index do |index|
			score += (@target[index] - @reproduction_system.genes[index]).abs
		end
		score
	end
	
	def mate_with(mate)
		@reproduction_system.mate_with(mate)
	end
	
	def be_mated_with(genetic_code)
		Individual.new(@target, @reproduction_system.be_mated_with(genetic_code))
	end

	def to_s
		@reproduction_system.to_s + "  :  " + score.to_s
	end
end
