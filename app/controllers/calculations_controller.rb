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

    length = @text.length
    spaces = @text.count(" ")
    length = length.to_i
    spaces = spaces.to_i
    without_spaces = length - spaces

    @character_count_without_spaces = "#{without_spaces}"
    @word_count =  @text.scan(/(\w|-)+/).size
    @occurrences =  @text.split.count(@special_word)

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

    @monthly_rate = @apr/1200
    @term = @years*12
    @top = @monthly_rate*@principal
    @bottom = 1-(1+@monthly_rate)**-@term

    @monthly_payment = @top/@bottom

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

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    if @count%2 != 0
      @median = @sorted_numbers[@count/2]
    else
     @median = (@sorted_numbers[@count/2] + @sorted_numbers[@count/2-1])/2
     end

    @sum = @numbers.sum

    @mean = @sum/@count

   top, n = 0.0, 0
     while n < @numbers.length
      top += (@mean.to_f - @numbers[n])**2
      n += 1
    end

     @variance = top/@numbers.length

    @standard_deviation = Math.sqrt(@variance)

    @mode = @numbers.uniq.max_by{ |i| @numbers.count( i ) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
