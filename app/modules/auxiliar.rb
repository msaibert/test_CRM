module Auxiliar

	require 'active_record'
	require 'pg'
	
	def make_class(class_name, config_db, options)

		klass = Class.new(ActiveRecord::Base) do
			table_name = options[:inflection] || class_name.downcase.pluralize
			# set_table_name table_name
			
			# adicionando as inflections, para que na hora de chamar determinados attributos		
			ActiveSupport::Inflector.inflections do |inflect|
				inflect.irregular class_name.camelize, table_name.camelize
				inflect.irregular class_name.underscore, table_name.underscore 
			end
		
			# criado as associações
			(options[:association] || {}).each do |ass, values|
				values.each {|v| send(ass.to_sym, v.to_sym)}
			end

		end

		Object.const_set( class_name.classify, klass )

		class_name.classify.constantize.establish_connection config_db
		class_name.classify.constantize
	end

	def make_classes(config_db)
  	config = config_db.config
		config_db = config_db.to_hash

		# padrão:
		# {'turma' => {inflection: 'turmas', association: {
		# 						has_many: ['jogadores', 'pessoa'],
		# 						belongs_to: ['user'],
		# 						has_and_belongs_to_many: ['mother_fucker']}}
		# }
		config.collect do |table, values|
				make_class(table, config_db, values) 
		end
	end
end