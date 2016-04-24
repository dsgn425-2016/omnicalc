class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # Code below is Matt Kiepura's solution to OmniCalc - Word Count

    # Count the number of characters in the string, including spaces
    @character_count_with_spaces = @text.length

    # Count the number of characters in the string, NO spaces
    @character_count_without_spaces = @text.gsub(" ","").length

    # Count the number of words in the string
    @word_count = @text.split.length

    # Count the number of occurrences of the "special" word (NOT case sensitive)
    textNoSpecialChars = @text.to_s.gsub(/["'?.!@,:;*$%&]/,"")
    textAllLower = textNoSpecialChars.downcase
    specialWordLower = @special_word.to_s.downcase
    wordsArray = textAllLower.split
    @occurrences = wordsArray.count(specialWordLower)

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

    # Code below is Matt Kiepura's solution to OmniCalc - Loan Payment

    ratePER = @apr / 100 / 12
    periods = @years * 12
    principalAMT = @principal

    @monthly_payment = (ratePER * principalAMT) / (1 - (1 + ratePER)**(-1 * periods))

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

    # Code below is Matt Kiepura's solution to OmniCalc - Time Between

    secs_in_Min = 60
    secs_in_HR = secs_in_Min * 60
    secs_in_Day = secs_in_HR * 24
    secs_in_WK = secs_in_Day * 7
    secs_in_YR = secs_in_Day * 365.25

    timeDIFF_secs = @ending - @starting

    @seconds = timeDIFF_secs
    @minutes = timeDIFF_secs / secs_in_Min
    @hours = timeDIFF_secs / secs_in_HR
    @days = timeDIFF_secs / secs_in_Day
    @weeks = timeDIFF_secs / secs_in_WK
    @years = timeDIFF_secs / secs_in_YR

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

    @sorted_numbers = "Replace this string with your answer."

    @count = "Replace this string with your answer."

    @minimum = "Replace this string with your answer."

    @maximum = "Replace this string with your answer."

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
