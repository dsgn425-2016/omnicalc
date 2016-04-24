class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    textarray = @text.split

    @character_count_with_spaces = @text.length

    @word_count = @text.split.size

    @character_count_without_spaces = @character_count_with_spaces-@word_count+1

    @occurrences = textarray.count(@special_word)

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

    monthly_rate=@apr/100/12
    number_of_months=@years*12

    @monthly_payment = @principal*(monthly_rate/(1-(1+monthly_rate)**(-number_of_months)))

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

    @seconds = @ending-@starting
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

    def median(array)
      len = array.length
      (array[(len - 1) / 2] + array[len / 2]) / 2.0
    end

    @median = median(@sorted_numbers)

    @sum = @numbers.sum

    def mean(array)
      len=array.length
      array.sum/len
    end

    @mean = mean(@numbers)

    def variance(array)
      sum = 0
      array.each do|number|
        sum = sum + (number-@mean)**2
      end
      variance=sum/@count
      return variance
    end

    @variance = variance(@numbers)

    @standard_deviation = Math.sqrt(@variance)

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
