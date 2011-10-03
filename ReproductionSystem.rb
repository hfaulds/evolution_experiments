class ReproductionSystem
	attr_reader :genes
	def initialize(genes)
		@genes = genes
	end

	def self.random_gene_part
		32 + rand(94)
	end

	def self.create_random(genes_length)
		genes = []
		genes_length.times do
			genes.push(random_gene_part)
		end
		ReproductionSystem.new(genes)	
	end

	def to_s
		out = ''
		genes.each do |part|
			out += part.chr
		end
		out
	end

	def mate_with(mate)
		mate.be_mated_with(genes)
	end
	
	def be_mated_with(foreign_genes)
		gene_length = genes.length

		this_half = genes.slice(0, gene_length/2)
		other_half = foreign_genes.slice(gene_length/2, gene_length-1)

		new_genes = this_half + other_half
		new_genes[rand(gene_length)] = ReproductionSystem.random_gene_part
		
		ReproductionSystem.new(new_genes)
	end
end
