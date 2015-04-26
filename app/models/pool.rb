class Pool
	def generatePools(pools,wrestlers,weight,tournament,matches)
		@pools = pools
		@pool = 1
		while @pool <= @pools
			matches = roundRobin(@pool,wrestlers,weight,tournament,matches)
			@pool = @pool + 1
		end
		return matches
	end

	def roundRobin(pool,wrestlers,weight,tournament,matches)
		@wrestlers = wrestlers.select{|w| w.generatePoolNumber == pool}.to_a
		@poolMatches = RoundRobinTournament.schedule(@wrestlers).reverse
		@poolMatches.each_with_index do |b,index|
			@bout = b.map
			@bout.each do |bout|
				if bout[0] != nil and bout[1] != nil
					@match = Match.new
					@match.w1 = bout[0].id
					@match.w2 = bout[1].id
					@match.weight_id = weight.id
					@match.round = index + 1
					matches << @match
				end
			end
		end
	return matches
	end
end