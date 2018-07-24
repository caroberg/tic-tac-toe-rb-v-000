WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

board = Array.new(9, " ")

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, position)
  !(board[position] == " " || board[position] == nil)
end

def valid_move?(board, position)
  position.between?(1, 9) && position == " "
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if token == "X" || token == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  puts "Please enter a move: 1-9"
  position = gets.strip
    if valid_move?(board, position)
      token = current_player(board)
      move(board, position, token)
      display_board(board)
    else
      return turn(board)
    end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      return false
    end
  end
  return false
end

def full?(board)
  board.all? do |token|
    token == "X" || token == "O"
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif !(full?(board))
    return false
  else
    return true
  end
end

def over?(board)
  if won?(board)
    return true
  elsif full?(board)
    return true
  elsif draw?(board)
    return true
  else !(full?(board))
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return "X"
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return "O"
    else
      return false
    end
  end
  return nil
end

def play(board)
  puts turn(board)
  if won?(board)
    puts "You won!"
  elsif draw?(board)
    puts "It's a draw!"
  elsif full?(board)
    puts "Game over!"
  else
    return play(board)
  end
end
