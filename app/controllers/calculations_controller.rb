class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.chomp.length

    @character_count_without_spaces = @text.chomp.delete!(" ").length

    @word_count = @text.split(" ").uniq.length

    @occurrences = "Replace this string with your answer."

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

    @monthly_payment = @principal*(@apr/1200)*(1+@apr/1200)**(@years*1200)/(1+@apr/1200)**(@years*1200)

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

    @seconds = (@ending-@starting).to_i
    @minutes = (@seconds/60).to_i
    @hours = (@minutes/60).to_i
    @days = (@hours/24).to_i
    @weeks = (@days/7).to_f
    @years =(@weeks/52).to_f

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

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum-@minimum

    @median = "Replace this string with your answer."

    @sum = @numbers.reduce( :+ )

    @mean = @sum/@count

    @variance = @sorted_numbers.map { |e| (e-=@mean)**2 }.inject(0, &:+)/@count

    @standard_deviation = @variance**0.5.to_f

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
