class BitmapEditor
  def initialize
    @command_array = [ ]
    @grid_x_size = 0
    @grid_y_size = 0
    @error = false
  end

# Command:  Format      - Function.
# I:        I M N       - Create new image of size MxN with all pixels of colour White (O).
# C:        C           - Clears image setting all pixels to white (O).
# L:        L X Y C     - Colour pixel XY with colour C.
# V:        V X Y1 Y2 C - Colour pixels in vertical Y line from Y1 to Y2 in colour C.
# H:        H X1 X2 Y C - Colour pixels in horizontal X line from X1 to X2 in colour C.
# S:        S           - Show contents of the current image.

  def run(file)
    #1.0 Read file into array...
    @command_array = File.readlines(file).map do |line|
      line.chomp.split(' ')
    end

    #2.0 Create loop to cycle through instruction array...
    @command_array.each do |command_line|

      # 2.1 COMMAND FILE PARSER: Check the commands are valid...
      case command_line.first

        # 2.1.1 Command I: I M N - Create new image of size MxN with all pixels of colour White (O).
        when "I" then
          # Check correct number of arguments...
          if command_line.length != 3
            puts("Error 1: Command \"I\" #{command_line.length - 1} arguments found, should be 2.")
            @error = true

          # Check that numerical arguments are numbers...
          elsif (/[^0-9]/.match(command_line[1]) || /[^0-9]/.match(command_line[2]))
            puts("Error 2: Command \"I\" argument value not a number.")
            @error = true

          # Check that numerical values are larger than 0...
          elsif (command_line[1].to_i <= 0 || command_line[2].to_i <= 0)
            puts("Error 3: Command \"I\" argument should be greater than 0.")
            @error = true

          # If all good, store the values for reference in later checking...
          else
             @grid_x_size = command_line[1].to_i
             @grid_y_size = command_line[2].to_i
          end

        # 2.1.2 Command C: C - Clears image setting all pixels to white (O).
        when "C" then
          if command_line.length != 1
            puts("Error 4: Command \"C\" arguments found, command should not have arguments.")
            @error = true
          end

        # Command L: L X Y C - Colour pixel XY with colour C.
        when "L" then
          # Check correct number of arguments...
          if command_line.length != 4
            puts("Error 5: Command \"L\" #{command_line.length - 1} arguments found, should be 3.")
            @error = true
          end

          # Check that numerical arguments are numbers...
          if (/[^0-9]/.match(command_line[1]) || /[^0-9]/.match(command_line[2]))
            puts("Error 6: Command \"L\" argument value not a number.")
            @error = true
          end

          # Check that numerical values are larger than 0...
          if (command_line[1].to_i <= 0 || command_line[2].to_i <= 0)
            puts("Error 7: Command \"L\" argument should be greater than 0.")
            @error = true
          end

          # Check that the value of X is within grid range...
          if (command_line[1].to_i > @grid_x_size)
            puts("Error 8: Command \"L\" argument out of X grid range.")
            @error = true
          end

          # Check that the value of Y is within grid range...
          if (command_line[2].to_i > @grid_y_size)
            puts("Error 9 : Command \"L\" argument out of Y grid range.")
            @error = true
          end

        # 2.1.3 Command V: V X Y1 Y2 C - Colour pixels in vertical Y line from Y1 to Y2 in colour C.
        when "V" then
          # Check correct number of arguments...
          if command_line.length != 5
            puts("Error 10: Command \"V\" #{command_line.length - 1} arguments found, should be 4.")
            @error = true
          end

          # Check that numerical arguments are numbers...
          if (/[^0-9]/.match(command_line[1]) || /[^0-9]/.match(command_line[2]) || /[^0-9]/.match(command_line[3]) )
            puts("Error 11: Command \"V\" argument value not a number.")
            @error = true
          end

          # Check that numerical values are larger than 0...
          if (command_line[1].to_i <= 0 || command_line[2].to_i <= 0 || command_line[3].to_i <= 0)
            puts("Error 12: Command \"V\" argument value should be greater than 0.")
            @error = true
          end
          # Check that the value of X is within grid range...
          if (command_line[1].to_i > @grid_x_size)
            puts("Error 13: Command \"V\" argument out of X grid range.")
            @error = true
          end

          # Check that the Y start value is larger than the Y end value.
          if (command_line[2].to_i >= command_line[3].to_i)
            puts("Error 14: Command \"V\" argument Y1 (start) to large, should be smaller than Y2 (end).")
            @error = true
          end

          # Check that the value of Y is within grid range...
          if (command_line[3].to_i > @grid_y_size)
            puts("Error 15: Command \"V\" argument out of Y grid range.")
            @error = true
          end

        # 2.1.4 Command H: H X1 X2 Y C - Colour pixels in horizontal X line from X1 to X2 in colour C.
        when "H" then
          # Check correct number of arguments...
          if command_line.length != 5
            puts("Error 16: Command \"H\" #{command_line.length - 1} arguments found, should be 4.")
            @error = true
          end
          # Check that numerical arguments are numbers...
          if (/[^0-9]/.match(command_line[1]) || /[^0-9]/.match(command_line[2]) || /[^0-9]/.match(command_line[3]) )
            puts("Error 17: Command \"H\" argument value not a number.")
            @error = true
          end
          # Check that numerical values are larger than 0...
          if (command_line[1].to_i <= 0 || command_line[2].to_i <= 0 || command_line[3].to_i <= 0)
            puts("Error 18: Command \"H\" argument value should be greater than 0.")
            @error = true
          end

          # Check that the X start point is greater than the X end point...
          if (command_line[1].to_i >= command_line[2].to_i)
            puts("Error 19: Command \"H\" argument X1 (start) to large, should be smaler than X2 (end).")
            error = true
          end

          # Check that the end value of X is within grid range...
          if (command_line[2].to_i > @grid_x_size)
            puts("Error 20: Command \"H\" argument out of X grid range.")
            @error = true
          end

          # Check that the value of Y is within grid range...
          if (command_line[3].to_i > @grid_y_size)
            puts("Error 21: Command \"H\" argument out of Y grid range.")
            @error = true
          end

        # 2.1.5 Command S: S - Show contents of the current image.
        when "S" then
          if command_line.length != 1
            puts("Error 22: Command \"S\" - Arguments found, command should not have arguments.")
            @error = true
          end

        # 2.1.6 Command not recognised.
        else
            puts("Error 23: Command \"#{command_line.first}\" unknown.")
            @error = true
      end

      # 2.2
      # Only execute commands if no errors...
      if @error === false
        case command_line.first

          #2.2.1 Create array...
          when "I" then
            @grid = Array.new(command_line[2].to_i) { Array.new(command_line[1].to_i, "O") }
          #2.3.2 Clear array...

          when "C" then
            @grid.each{|row| row.replace(row.map{"O"})}

          #2.2.3 Change a single sub-element of array...
          when "L" then
            @grid[(command_line[2].to_i) - 1][(command_line[1].to_i) - 1] = command_line[3]

          # 2.2.4 Change a vertical series of elements in array...
          when "V" then
            x = (command_line[1].to_i) - 1
            ystart = (command_line[2].to_i) - 1
            ystop = (command_line[3].to_i) - 1
            colour = command_line[4]
            plindex = 0

            @grid.each do |pixel_line|
              if ( (plindex >= ystart) && (plindex <= ystop) )
                pixel_line[x] = colour
              end
                plindex = plindex + 1
              end

          # 2.2.5 Change a horizontal series of elements in array...
          when "H" then
            xstart = (command_line[1].to_i) - 1
            xstop = (command_line[2].to_i) - 1
            y = (command_line[3].to_i) - 1
            colour = command_line[4]
            pindex = 0

            @grid[y].each do |pixel|
              if ((pindex >= xstart) && (pindex <= xstop))
                @grid[y][pindex] = colour
              end
              pindex = pindex + 1
            end

          # 2.2.6 Show contents of current image...
          when "S"
            @grid.each { |x|
             puts x.join(" ")
            }
        end
      end
    end
  end
end
