class Losernamegen
  def assignLoserNames(matches,weights)
    weights.each do |w|
      @matches = matches.select{|m| m.weight_id == w.id}
      if w.pool_bracket_type == "twoPoolsToSemi"
        twoPoolsToSemiLoser(@matches)
      elsif w.pool_bracket_type == "fourPoolsToQuarter"
        fourPoolsToQuarterLoser(@matches)
      elsif w.pool_bracket_type == "fourPoolsToSemi"
        fourPoolsToSemiLoser(@matches)
      end
    end
    return matches
  end

  def twoPoolsToSemiLoser(matches)
    @match1 = matches.select{|m| m.loser1_name == "Winner Pool 1"}.first
    @match2 = matches.select{|m| m.loser1_name == "Winner Pool 2"}.first
    @matchChange = matches.select{|m| m.bracket_position == "3/4"}.first
    @matchChange.loser1_name = "Loser of #{@match1.bout_number}"
    @matchChange.loser2_name = "Loser of #{@match2.bout_number}"
  end

  def fourPoolsToQuarterLoser(matches)
    @quarters = matches.select{|m| m.bracket_position == "Quarter"}
    @consoSemis = matches.select{|m| m.bracket_position == "Conso Semis"}
    @semis = matches.select{|m| m.bracket_position == "Semis"}
    @thirdFourth = matches.select{|m| m.bracket_position == "3/4"}.first
    @seventhEighth = matches.select{|m| m.bracket_position == "7/8"}.first
    @consoSemis.each do |match|
      if match.bracket_position_number == 1
        match.loser1_name = "Loser of #{@quarters.select{|m| m.bracket_position_number == 1}.first.bout_number}"
        match.loser2_name = "Loser of #{@quarters.select{|m| m.bracket_position_number == 2}.first.bout_number}"
      elsif match.bracket_position_number == 2
        match.loser1_name = "Loser of #{@quarters.select{|m| m.bracket_position_number == 3}.first.bout_number}"
        match.loser2_name = "Loser of #{@quarters.select{|m| m.bracket_position_number == 4}.first.bout_number}"
      end
    end
    @thirdFourth.loser1_name = "Loser of #{@semis.select{|m| m.bracket_position_number == 1}.first.bout_number}"
    @thirdFourth.loser2_name = "Loser of #{@semis.select{|m| m.bracket_position_number == 2}.first.bout_number}"
    @consoSemis = matches.select{|m| m.bracket_position == "Conso Semis"}
    @seventhEighth.loser1_name = "Loser of #{@consoSemis.select{|m| m.bracket_position_number == 1}.first.bout_number}"
    @seventhEighth.loser2_name = "Loser of #{@consoSemis.select{|m| m.bracket_position_number == 2}.first.bout_number}"
  end

  def fourPoolsToSemiLoser(matches)
    @semis = matches.select{|m| m.bracket_position == "Semis"}
    @thirdFourth = matches.select{|m| m.bracket_position == "3/4"}.first
    @consoSemis = matches.select{|m| m.bracket_position == "Conso Semis"}
    @seventhEighth = matches.select{|m| m.bracket_position == "7/8"}.first
    @thirdFourth.loser1_name = "Loser of #{@semis.select{|m| m.bracket_position_number == 1}.first.bout_number}"
    @thirdFourth.loser2_name = "Loser of #{@semis.select{|m| m.bracket_position_number == 2}.first.bout_number}"
    @seventhEighth.loser1_name = "Loser of #{@consoSemis.select{|m| m.bracket_position_number == 1}.first.bout_number}"
    @seventhEighth.loser2_name = "Loser of #{@consoSemis.select{|m| m.bracket_position_number == 2}.first.bout_number}"
  end
end