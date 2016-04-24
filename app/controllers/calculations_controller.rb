class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.length


    @occurrences = @text.split.count(@special_word)

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
    @monthly_apr = @apr/1200
    @term = @years*12

    @numerator = @monthly_apr * @principal
    @denominator = 1 - (1 + @monthly_apr)**-@term

    @monthly_payment = @numerator/@denominator

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
    @years = @days/365

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

    @count = @numbers.length

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @sorted_numbers.last - @sorted_numbers.first

    if @count.odd?
      @median = @sorted_numbers[(@sorted_numbers.length-1)/2]
    else @count.even?
      @median = (@sorted_numbers[@sorted_numbers.length/2] + @sorted_numbers[@sorted_numbers.length/2 -1])/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count

   var_counter = 0
   delta_sum = 0
    while var_counter < @count
    delta_sum += ((@sorted_numbers[var_counter] - @mean)**2)
     var_counter +=1
   end

    @variance = delta_sum/@count

    @standard_deviation = @variance **0.5

    leading_num = nil
    leading_counter = 0

    @numbers.each do |num|
      repeats = @numbers.count(num)
      if repeats > leading_counter
        leading_num = num
        leading_counter = repeats
      end
    end

    @mode = leading_num

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
