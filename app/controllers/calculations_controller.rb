class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # Count number of characters with spaces
    @character_count_with_spaces = @text.length

    # Turn text into an array
    @array_text = @text.split

    #  Count number of words
    @word_count = @array_text.count

    # Count number of times the special word appears in the array
    @occurrences = @array_text.count(@special_word)

    # Count number of characters without spaces
    @sanitized_text = @text.gsub(" ", "")

    @character_count_without_spaces = @sanitized_text.length

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
    # Convert the APR into monthly percentage
    @apr_monthly = @apr/1200
    # Multiply the number of years to months in order to find number of periods of payment
    @nper = @years*12

    # Formula from wikipedia
    @monthly_payment = @apr_monthly*@principal/(1-((1+@apr_monthly)**(-1*@nper)))

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52.1429

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

    # Calculate the median for odd number of values and even number of values
    if @count.odd? == true
      @median = @numbers[@count/2]
    else
      @median = (@numbers[(@count/2)-1]+@numbers[@count/2])/2
    end

    # Define sum method
    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end

      return running_total
    end

    @sum = sum(@numbers)

    @mean = @sum/@count

    # Define variance method
    def variance(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + (number - @mean)**2
      end

      return running_total/@count
    end

    @variance = variance(@numbers)

    @standard_deviation = @variance**0.5

    def mode(list_of_numbers)
      counter= 0
      leader = nil
      list_of_numbers.each do|number|
        occurence=list_of_numbers.count(number)
        if occurence > counter
          counter=counter+occurence
          leader=number
        end
      end
      return leader
    end
    @mode = mode(@numbers)

    render("descriptive_statistics.html.erb")
  end
end
