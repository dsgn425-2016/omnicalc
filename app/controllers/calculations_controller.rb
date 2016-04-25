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

    spaces = @text.count " "

    @character_count_without_spaces = @character_count_with_spaces - spaces

    splits = @text.split(" ")
    @word_count = splits.length.to_s

    @occurrences = splits.count(@special_word) #{@special_word}

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

    rate = (@apr/12) / 100
    periods = @years * 12
    numerator = rate * @principal * ((1+rate)**periods)
    denominator = ((1 + rate) ** periods) - 1
    the_payment = numerator / denominator
    @monthly_payment = the_payment.to_s

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
    number_minutes = @seconds / 60
    @minutes = number_minutes
    number_hours = number_minutes / 60
    @hours = number_hours.round(2)
    number_days = number_hours / 24
    @days = number_days.round(2)
    number_weeks = number_days / 7
    @weeks = number_weeks.round(2)
    number_years = number_days / 365.25
    @years = number_years.round(2)

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
    entries = @numbers.split(" ")

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    range_of_numbers = "#{@numbers.min} to #{@numbers.max}"

    @range = range_of_numbers
    list_of_sorted_numbers = @numbers.sort
      choice = list_of_sorted_numbers.length / 2

if list_of_sorted_numbers.length.odd? == true
  @median = list_of_sorted_numbers[choice.ceil]
else
    @median = (list_of_sorted_numbers[choice] + list_of_sorted_numbers[choice - 1]) /2
  end





list_of_numbers = @numbers
    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |entry|
        running_total = running_total + entry
      end
      return running_total
    end
    @sum = list_of_numbers.sum

    @mean = (list_of_numbers.sum / @numbers.length).round(2)

mean = list_of_numbers.sum / list_of_numbers.length
squared_errors = list_of_numbers.map{|i| (i-mean)**2}

  @variance = (squared_errors.sum / list_of_numbers.length).round(2)
variance = @variance
  @standard_deviation = Math.sqrt(variance).round(2)


  @mode = "Replace this string with your answer."

  # ================================================================================
  # Your code goes above.
  # ================================================================================

  render("descriptive_statistics.html.erb")
end
end
