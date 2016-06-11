  class CalculationsController < ApplicationController

    def word_count
      @text = params[:user_text]
      @special_word = params[:user_word]

      # ================================================================================
      # Your code goes below.
      # The text the user input is in the string @text.
      # The special word the user input is in the string @special_word.
      # ================================================================================

      #Turn text into array
      @array_text = @text.split
      #Remove spaces
      @text_no_spaces = @text.gsub(" ","")

      @character_count_with_spaces = @text.length

      @character_count_without_spaces = @text_no_spaces.length

      @word_count = @array_text.count

      @occurrences = @array_text.count(@special_word)

      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("word_count.html.erb")
    end

    def loan_payment
      @apr = params[:annual_percentage_rate].to_f
      @years = params[:number_of_years].to_i
      @principal = params[:principal_value].to_f

      # ================================================================================
      # Your code goes below.
      # The annual percentage rate the user input is in the decimal @apr.
      # The number of years the user input is in the integer @years.
      # The principal value the user input is in the decimal @principal.
      # ================================================================================
      @interest_monthly=@apr/12/100
      @loan_term=@years*12

      @monthly_payment = @principal * @interest_monthly * (1+@interest_monthly)**@loan_term / (((1+@interest_monthly)**@loan_term)-1)

      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("loan_payment.html.erb")
    end

    def time_between
      @starting = Chronic.parse(params[:starting_time])
      @ending = Chronic.parse(params[:ending_time])

      # ================================================================================
      # Your code goes below.
      # The start time is in the Time @starting.
      # The end time is in the Time @ending.
      # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
      #   So if you subtract one time from another, you will get an integer
      #   number of seconds as a result.
      # ================================================================================

      @seconds = @ending - @starting
      @minutes = @seconds/60
      @hours = @minutes/60
      @days = @hours/24
      @weeks = @days/7
      @years = @weeks/52

      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("time_between.html.erb")
    end

    def descriptive_statistics
      @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

      # ================================================================================
      # Your code goes below.
      # The numbers the user input are in the array @numbers.
      # ================================================================================

      @sorted_numbers = @numbers.sort

      @count = @numbers.count

      @minimum = @numbers.min

      @maximum = @numbers.max

      @range = @maximum - @minimum

      @median = (@numbers.sort[(@numbers.length - 1) / 2] + @numbers.sort[@numbers.length / 2 ]) / 2

      @sum = @numbers.sum

      @mean = @sum/@count

      @variance = @numbers.inject(0){|sum, element| sum+(element-@mean)**2}/@count

      @standard_deviation = Math.sqrt(@variance)

      def mode(array)
        num_count= 0
        most_common_number = nil
        array.each do|number|
          occurence=array.count(number)
          if occurence > num_count
            num_count=num_count+occurence
            most_common_number=number
          end
        end
        return most_common_number
      end

      @mode = mode(@numbers)

      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("descriptive_statistics.html.erb")
    end
  end
