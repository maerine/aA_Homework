require_relative "player"

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    array = []
    (0..13).each do |i|
      if i == 6 || i == 13
        array << []
      else
        array << [:stone, :stone, :stone, :stone]
      end
    end

    array
  end

  def valid_move?(start_pos)
    if !(start_pos < 13 && start_pos >= 0)
      raise "Invalid starting cup"
    end
    if @cups[start_pos].empty?
      raise "Starting cup is empty"
    end 
  end

  def make_move(start_pos, current_player_name)
    if valid_move?(start_pos)
      stones = @cups[start_pos]
      @cups[start_pos] = []
      
      (start_pos)
       << stones.drop(1)
    end
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
