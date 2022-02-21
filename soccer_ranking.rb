class SoccerRanking
  attr_accessor :result_score

  def initialize
    self.result_score = Hash.new(0)
    accepted_formats = [".txt"]
    p "Enter filename: "
    filename = STDIN.gets.chomp
    return unless (accepted_formats.include? File.extname(filename)) && File.file?(filename)
    fill_results(filename)
    sort_results
    print_result
  end

  private

  def fill_results(filename)
    confrontations_array = File.read(filename).split("\n")
    confrontations_array.each { |line|
      confrontation = line.split(',')
      first_array = confrontation[0].split(' ')
      second_array = confrontation[1].split(' ')
      first_team_score = first_array.pop
      first_team_name = first_array.join(" ")
      second_team_score = second_array.pop
      second_team_name = second_array.join(" ")
      if first_team_score > second_team_score
        self.result_score[first_team_name] += 3
        self.result_score[second_team_name] += 0
      elsif second_team_score > first_team_score
        self.result_score[first_team_name] += 0
        self.result_score[second_team_name] += 3
      else
        self.result_score[first_team_name] += 1
        self.result_score[second_team_name] += 1
      end
    }
  end

  def sort_results
    self.result_score = self.result_score.sort_by {|_key, value| value}.reverse.to_h
  end

  def print_result
    i = 0
    self.result_score.each do |key, value|
      i += 1
      puts "#{i}. #{key}, #{value} pts"
    end
  end
end

SoccerRanking.new