class SoccerRanking
  attr_accessor :result_score

  def initialize
    self.result_score = Hash.new(0)
    accepted_formats = ['.txt']
    p 'Enter filename: '
    filename = $stdin.gets.chomp
    return unless (accepted_formats.include? File.extname(filename)) && File.file?(filename)

    fill_results(filename)
    sort_results
    print_result
  end

  private

  def fill_results(filename)
    confrontations_array = File.read(filename).split("\n")
    confrontations_array.each do |line|
      confrontation = line.split(',')
      first_array = confrontation[0].split(' ')
      second_array = confrontation[1].split(' ')
      first_team_score = first_array.pop
      first_team_name = first_array.join(' ')
      second_team_score = second_array.pop
      second_team_name = second_array.join(' ')
      if first_team_score > second_team_score
        result_score[first_team_name] += 3
        result_score[second_team_name] += 0
      elsif second_team_score > first_team_score
        result_score[first_team_name] += 0
        result_score[second_team_name] += 3
      else
        result_score[first_team_name] += 1
        result_score[second_team_name] += 1
      end
    end
  end

  def sort_results
    self.result_score = result_score.sort_by { |key, value| [-value, -key] }.to_h
  end

  def print_result
    i = 0
    result_score.each do |key, value|
      i += 1
      puts "#{i}. #{key}, #{value} pts"
    end
  end
end

SoccerRanking.new
