class StaticPagesController < ApplicationController

	def index
		@tournaments = Tournament.all
	end
	def up_matches
		if params[:tournament]
	      @tournament = Tournament.find(params[:tournament])
		end
	    if @tournament
				@matches = @tournament.matches
				if @matches.empty?
					redirect_to "/static_pages/noMatches?tournament=#{@tournament.id}"
				end
	    end
	end

	def team_scores
		if params[:tournament]
	      @tournament = Tournament.find(params[:tournament])
		end
	    if @tournament
	    	@schools = School.where(tournament_id: @tournament.id)
	    	@schools.sort_by{|x|[x.score]}
	    end
	end

	def results
		if params[:tournament]
	      @tournament = Tournament.find(params[:tournament])
		end
    if @tournament
    	@matches = @tournament.matches
    end
		@matches = @matches.where(finished: 1)
	end

	def brackets
	    if params[:weight]
	    	@weight = Weight.find(params[:weight])
	    	@tournament = Tournament.find(@weight.tournament_id)
	    	@matches = @tournament.matches.select{|m| m.weight_id == @weight.id}
	    	@wrestlers = Wrestler.where(weight_id: @weight.id)
				if @matches.empty? or @wrestlers.empty?
					redirect_to "/static_pages/noMatches?tournament=#{@tournament.id}"
				else
					@pools = @weight.poolRounds(@matches)
					@bracketType = @weight.pool_bracket_type
				end
	    end
	end

	def all_brackets
	    if params[:tournament]
	    	@tournament = Tournament.find(params[:tournament])
	    end
	end

	def weights
		if params[:tournament]
	      @tournament = Tournament.find(params[:tournament])
		end
	    if @tournament
	    	@weights = Weight.where(tournament_id: @tournament.id)
	    	@weights = @weights.sort_by{|x|[x.max]}
	    end
	end

	def createCustomWeights
		if user_signed_in?
		else
			redirect_to root_path
		end
			@tournament = Tournament.find(params[:tournament])
		  @custom = params[:customValue].to_s
			@tournament.createCustomWeights(@custom)

		redirect_to "/tournaments/#{@tournament.id}"
	end


	def noMatches
		if params[:tournament]
			@tournament = Tournament.find(params[:tournament])
		end
	end

	def generate_matches
		if !user_signed_in?
	      redirect_to root_path
	    elsif user_signed_in?
			if params[:tournament]
	      		@tournament = Tournament.find(params[:tournament])
			end
	    	if @tournament
	 			@tournament.generateMatchups
	    	end
		end
	end
end
