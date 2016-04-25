class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

# Number of characters with spaces
    @character_count_with_spaces = @text.length

# turning text into an array
    @arraytext = @text.split

# Word count overall
    @word_count = @arraytext.length

    # creating a new variable for without spaces
    @sanitizedtext =  @text.gsub(" ","")

    @character_count_without_spaces = @sanitizedtext.length

    @occurrences = @arraytext.count(@special_word)

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

# Defining monthly values
    @aprmonth = @apr/1200
    @nper = @years*12

# Calculating monthly payments
    @monthly_payment = @aprmonth*@principal/(1-(1+@aprmonth)**(-@nper))

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

# total time [assuming hours]
@totaltime = @starting-@ending

    @seconds = @totaltime*3600
    @minutes = @totaltime*60
    @hours = @totaltime
    @days = @totaltime/24
    @weeks = @totaltime/168
    @years = @totaltime/8760

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

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

# Median logic
     if @count.even?
       @median = (@numbers[@count/2]+@numbers[(@count/2)-1]/2]
     else @median = @numbers[@count/2]
     end

    @sum = 0


    @mean = @sum/@count

    @variance = "Replace this string with your answer."

    @standard_deviation = @variance**(2)

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
