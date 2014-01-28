class SeletoresController < ApplicationController


	include Auxiliar

	# def index
	# 	@seletor = Seletor.new
	# end


	def teste
		@resultado = eval(params['seletor']['codigo'])
		render :partial => "resultados"
	end

end
