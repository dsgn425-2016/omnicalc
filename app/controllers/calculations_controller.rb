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

    @character_count_without_spaces = @text.gsub(" ", "").length

    counter = @text.split(" ")
    @word_count =counter.count

    special_word = @text.gsub(" ", "").split(@special_word)
    @occurrences = special_word.count-1

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

    @monthly_apr = @apr/12/100
    @months = @years*12
    @rate_value = (1+@monthly_apr)**@months

    @monthly_payment = (@monthly_apr*@principal*@rate_value)/(@rate_value-1)

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

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    if @count.odd?
      @median = @sorted_numbers[@count/2]
    elsif
      @median = (@sorted_numbers[(@count/2)-1]+@sorted_numbers[(@count/2)])/2
    end

    @counter = 0
    @running_total = 0

      @sorted_numbers.each do |number|
      @running_total = @running_total + number
      end

    @sum = @running_total

    @mean = @sum / @count

    def variance(list_of_numbers)
      @var_total = 0
      list_of_numbers.each do |number|
        @var_total = @var_total + ((number-@mean)**2)
      end
      return @var_total/@count
    end

    @variance = variance(@sorted_numbers)

    @standard_deviation = Math.sqrt(@variance)

    def mode(list_of_numbers)
      @current_mode = @sorted_numbers[0]
      @new_mode_counter = 0
      @old_mode_counter = 0
      list_of_numbers.each do |number|
        if number == @current_mode
          @new_mode_counter = @new_mode_counter + 1
        elsif
          if @new_mode_counter > @old_mode_counter
          @current_mode = number
          @old_mode_counter = @new_mode_counter
          @new_mode_counter = 0
          elsif @new_mode_counter <= @old_mode_counter
          @new_mode_counter = 0
        end
      end
      end
    return @current_mode
  end

    @mode = mode(@sorted_numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
