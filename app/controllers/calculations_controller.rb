class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_array = @text.split(' ')

    text_occurrences = text_array.count(@special_word)

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - text_array.length + 1

    @word_count = text_array.length

    @occurrences = text_occurrences

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

    calculated_rate = @apr/100/12
    calculated_period = @years*12
    calculated_principal = @principal.to_f
    calculated_monthly_payment = calculated_principal * (calculated_rate / (1-(1+calculated_rate)**(-calculated_period)))

    @monthly_payment = calculated_monthly_payment

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

    numbers_sorted = @numbers.sort

    @sorted_numbers = numbers_sorted

    @count = @numbers.length

    @minimum = numbers_sorted[0]

    @maximum = numbers_sorted[@count-1]

    @range = @maximum - @minimum


    #median calculation#

    if @count % 2 == 1
      @median = numbers_sorted[(@count-1)/2]
    else
      @median = (numbers_sorted[@count/2]+(numbers_sorted[(@count/2)-1]))/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    #variance calculation#

    x = 0
    variance_numerator = 0
    while x <= @count-1
      variance_numerator = variance_numerator + ((@numbers[x]-@mean)**2)
      x = x+1
    end

    @variance = variance_numerator / @count

    @standard_deviation = @variance ** (0.5)

    #mode calculation#

    y = 0
    current_lead = @numbers[0]
    current_lead_count = @numbers.count(current_lead)

    while y <= @count-1
      current_competitor = @numbers[y]
      current_competitor_count = @numbers.count(current_competitor)

      if current_competitor_count > current_lead_count
        current_lead = current_competitor
      else
      end

      y = y+1
    end

    @mode = current_lead

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
