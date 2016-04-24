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

    @character_count_without_spaces = @text.length - @text.count(" ")

    @word_count = @text.count(" ") + 1

    @occurrences = @text.scan(@special_word).count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    monthly_rate = @apr/100/12
    term = @years*12
    payment_amount= ((monthly_rate * @principal)/(1-(1+ monthly_rate)**(-term)))

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = payment_amount

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
    @years = @weeks/52.17857143

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

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    @median = (@sorted_numbers[@count/2]+(@sorted_numbers[@count/2]-1))/2

    @sum = @numbers.sum

    @mean = @sum/@count


    top, n = 0.0, 0
    x = 0
         numerator = 0
        while x <= @count-1
          numerator = numerator + ((@numbers[x]-@mean)**2)
          x = x+1
        end
 @variance = numerator / @count


    @standard_deviation = @variance**(0.5)

a=0
first_num=@numbers(0)
end

first_num_count=@numbers.count(first_num)
while a<=@count-1
  test=@numbers[a]
  test_count=@numbers.count(test)
  if test_count>first_num_count
    first_num=test
  else
  end
  a=a+1
end
    @mode = test
    # appearance = @sorted_numbers.scan().count


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
