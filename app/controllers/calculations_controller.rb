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

    @word_count = 1 + @text.count(" ")
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

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    rate_calc = @apr/100/12
    period_calc = @years*12
    principal_calc = @principal.to_f
    payment_calc = principal_calc * (rate_calc / (1-(1+rate_calc)**(-period_calc)))

    @monthly_payment = payment_calc

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

    @minimum = @numbers[0]

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    if @sorted_numbers.length.odd?                   #is the length of the array odd?
      @median = @sorted_numbers[(@sorted_numbers.length - 1) / 2] #find value at this index
    else @sorted_numbers.length.even?                #is the length of the array even?
      @median = (@sorted_numbers[@sorted_numbers.length/2] + @sorted_numbers[@sorted_numbers.length/2 - 1] )/2.to_f
      #average the values found at these two indexes and convert t float.
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    top, n = 0.0, 0
    while n < @numbers.length
      top += (@mean.to_f - @numbers[n])**2
      n += 1
    end

    @variance = top/@numbers.length

    @standard_deviation = Math.sqrt(@variance.to_f)
    unique_numbers = @numbers.sort.uniq
     mode = 0
     global_max = 0
     # if all numbers are unique then select the lowest number as the mode
     if @numbers.length == unique_numbers.length
       mode = @numbers.min
     else
       # if not all unique, find the mode
       unique_counter = 0
       # for each unique number ...
       while unique_counter < unique_numbers.length do
         current_max = 0
         numbers_counter = 0
         # ... find how many times it exists in original set
         while numbers_counter < @numbers.sort.length do
           # if a match found, increment current_max
           if unique_numbers[unique_counter] == @numbers.sort[numbers_counter]
             current_max = 1
           end
           numbers_counter = 1
         end
         # if current max is greater than the global max, set new mode to current number being tested and save global count
         if current_max > global_max
           global_max = current_max
           mode = unique_numbers[unique_counter]
         end
         unique_counter = 1
       end
     end

     @mode = mode
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
