# Program that generates the number of mines adjacent to a given space
# on a minesweeper board
#
# Alex Foggia 12/19/2021
#
# General Process:
#         1. Loop through each row of the board
#         2. Check and make sure that each row is valid:
#           - No differing lengths
#           - No faulty borders
#           - No invalid characters
#         3. Loop through each space in the row counting any mines in:
#           - The three spaces above the current point
#           - The spaces beside the current point
#           - The three spaces below the current point
#         4. Once all adjacent mines have been counted,
#            then update the space with the count

class Board

  def self.transform(board)
      # Get the height of the board so we can find the top and bottom
      max_rows = board.length-1
      # Get the width of the first row so we know the width of the board
      row_width = board[0].length-1
      # Next we iterate on each row of the board
      board.each_with_index { |row,row_num| 
      # First lets make sure that this row is the right width
      if (row.length-1) != row_width
          raise ArgumentError.new
      # As long as this row is the right length then we can go ahead
      # and update the mine counts
      else
          # Now we iterate on each spot in the row
          row.each_char.with_index do |char,index| 
              # IF this is a top/bottom row then we just need to 
              # make sure that they are made up of the right symbols
              # Otherwise, we error out
              if row_num == 0 or row_num == max_rows
                  if char == "+" or char == "-"
                      ""
                  else
                      raise ArgumentError.new
                  end
              # IF this is the first or last character of the row
              # then it should be a border and we can check to make
              # sure that it is the right symbol
              # Otherwise, we error out
              elsif index == 0 or index == row_width
                  if char != "|" 
                      raise ArgumentError.new
                  end
              # Last check is to make sure that there are no invalid
              # characters lingering around in this row
              # IF we found one then we error out
              elsif char.match(/[^-\0-9|+*\s]/)
                  raise ArgumentError.new
              # As long as this character is not a mine,
              # we can go ahead and evaluate the space
              elsif char != "*"
                  mine_count = board[row_num-1][index-1..index+1].count("*")
                  mine_count += board[row_num].chars.values_at(index-1, index+1).count("*")
                  mine_count += board[row_num+1][index-1..index+1].count("*")
                  mine_count = mine_count == 0 ? " " : mine_count
                  board[row_num][index] = mine_count.to_s
              end
          end
      end
      # Display the row with the counts applied
      puts row
      }
  end
end
