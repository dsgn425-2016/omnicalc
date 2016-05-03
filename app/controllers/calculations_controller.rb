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

    text = @text.split

    @word_count = text.count

    @character_count_without_spaces = @text.length - @word_count + 1

    occurrences = 0

    text.each do |match|
      if match == @special_word
        occurrences = occurrences + 1
      end
    end

    @occurrences = occurrences

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

    month_interest_rate = @apr/1200

    periods = @years*12

    monthly_payment = @principal * month_interest_rate/(1-(1+month_interest_rate)**(-1*periods))

    @monthly_payment = monthly_payment

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

    secs_min = 60
    secs_hour = secs_min*60
    secs_day = 24*secs_hour
    secs_week = secs_day*7
    secs_year = secs_week*52



    @seconds = -(@starting - @ending)
    @minutes = -(@starting - @ending)/secs_min
    @hours = -(@starting - @ending)/secs_hour
    @days = -(@starting - @ending)/secs_day
    @weeks = -(@starting - @ending)/secs_week
    @years = -(@starting - @ending)/secs_year

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
    #
    # def bubble_sort(array)
    #   n = array.length
    #   loop do
    #     swapped = false
    #
    #     (n-1).times do |i|
    #       if array[i] > array[i+1]
    #         array[i], array[i+1] = array[i+1], array[i]
    #         swapped = true
    #       end
    #     end
    #
    #     break if not swapped
    #   end
    #   array
    # end

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range =  @maximum - @minimum

    if @count/2 != 2
      middle_number = @count/2-0.5
      median = @sorted_numbers[middle_number]
    else
      middle_lower = @count/2
      middle_upper = middle_lower + 1
      median = (middle_upper-middle_lower)/2
    end
    @median = median

    total = 0
    @sorted_numbers.each do |agg_sum|
      total = total + agg_sum
    end

    @sum = total

    @mean =  @sum/@count

    #calculate the variance of the list
    sum_squ = 0
    @sorted_numbers.each do |agg_sum_squ|
      sum_squ = sum_squ + (agg_sum_squ - @mean)**2
    end

    @variance = sum_squ/@count

    @standard_deviation = Math.sqrt(@variance)

  # occurrences = 0
  # @sorted_numbers.each do |match1|
  #   @previous_match=match1
  #       @sorted_numbers.each do |match2|
  #         if match == @previous_match
  #           occurrences = occurrences + 1
  #           mode = match
  #         end
  #       end
  #     end

    @mode = median

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
