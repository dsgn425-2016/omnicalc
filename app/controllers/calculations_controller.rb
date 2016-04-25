class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # @character_count_with_spaces = "Replace this string with your answer."

    @word_count = @text.split(' ').length

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @text_split = @text.split

    @occurrences = @text_split.count(@special_word)
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
    @r=@apr/(12*100)
    @n = @years*12
    @monthly_payment = (@principal*@r)/(1-((1+@r)**(-1*@n)))
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
    @minutes = @seconds/1.minute
    @hours = @seconds/1.hour
    @days = @seconds/1.day
    @weeks = @seconds/1.week
    @years = @seconds/1.year

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
    # ==============  ==================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    def median(array)
      sorted = array.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    @median = median(@numbers)

    @sum = @numbers.sum

    @mean = @sum/@count

    def variance (list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + (number-@mean)**2
      end
      final = running_total/@count
      return final
    end
    @variance = variance(@numbers)

    @standard_deviation = @variance ** (0.5)

    def mode(array)
      num_count= 0
      current_leader = nil
      array.each do|number|
        occurence=array.count(number)
        if occurence > num_count
          num_count=num_count+occurence
          current_leader=number
        end
      end
      return current_leader
    end
    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
