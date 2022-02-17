class MainClass
  attr_accessor :result_score

  def initialize
    self.result_score = Hash.new(0)
    accepted_formats = [".txt"]
    p "Enter filename: "
    filename = STDIN.gets.chomp
    return unless (accepted_formats.include? File.extname(filename)) && File.file?(filename)
    confrontations_array = File.read("score.txt").split("\n")
    confrontations_array.each { |line|
      confrontation = line.split(',')
      # puts "size= "
      # words_in_first_name = confrontation[0].split(' ').size - 1
      # words_in_second_name = confrontation[1].split(' ').size - 1
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
    self.result_score = self.result_score.sort_by {|_key, value| value}.reverse.to_h
    #@result_score = self.result_score.fetch("team_name")
  end

  private

end

MainClass.new