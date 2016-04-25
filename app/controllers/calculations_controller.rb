class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count(" ")


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

    @monthly_payment = ((@apr/12/100)*@principal)/(1-((1+(@apr/12/100))**(-@years*12)))
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
    @minutes = @seconds/1.minutes
    @hours = @seconds/1.hours
    @days = @seconds/1.days
    @weeks = @seconds/1.weeks
    @years = @seconds/1.years

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

    @minimum = @numbers[0]

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    @median = (@sorted_numbers[(@count-1)/2]+@sorted_numbers[@count/2]) / 2.0

    @sum = @sorted_numbers.inject(:+)

    @mean = @sum / @count

    @variance = @numbers.inject(0){|sum, element| sum+(element-@mean)**2}/@count

    @standard_deviation = Math.sqrt(@variance)

    @i = 0
    @index = 0
    @count_temp = []

    while @i < @count do
      @count_temp << @numbers.count(@numbers.at(@i))
      @i = @i + 1
    end

    @index = @count_temp.index(@count_temp.max)

    @mode = @numbers[@index]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
