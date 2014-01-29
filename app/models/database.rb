class Database < ActiveRecord::Base

	# attr_accessible :config

	def to_hash
		self.attributes.select{|k, v| %w{adapter host encoding database username password}.include? k }
	end

	after_initialize do
		self.config = eval(self.config || '')
	end

	before_save do
		self.config = make_config.to_s if self.config.blank?
	end

	def make_config
		tables = {}
		
		begin

			padrao = Rails.application.config.database_configuration[Rails.env]
			ActiveRecord::Base.establish_connection self.to_hash

			ActiveRecord::Base.connection.tables.each do |table| 
				columns = ActiveRecord::Base.connection.columns(table).collect{|p| p.name} 
				belongs_to = columns.map{|p| p[0...-3] if p.end_with? '_id' }.compact	

				tables[table.singularize] = {
					inflection: table,
					association: {belongs_to: belongs_to, has_many: [], has_and_belongs_to_many: []}
				}

		 end
	   
	   #gerar has_many
	   tables.each do |k, v|
	   	v[:association][:belongs_to].each do |table| 
	   		(tables[table][:association][:has_many] << k.pluralize) rescue nil
	   	end
	   end

		ensure
		
			ActiveRecord::Base.establish_connection padrao
			tables

		end
	end

end
