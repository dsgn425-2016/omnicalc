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

    # Code below is Matt Kiepura's solution to OmniCalc - Descriptive Stats

    numbersSorted = @numbers.sort
    @sorted_numbers = numbersSorted

    numCount = numbersSorted.count
    @count = numCount

    minNum = numbersSorted[0]
    @minimum = minNum

    maxNum = numbersSorted.last
    @maximum = maxNum

    @range = maxNum - minNum

    # Median calculation
    if numCount % 2 > 0   # we have an odd array length
      index = (numCount - 1) / 2   # (-1) due to array index starting at 0
      @median = numbersSorted[index]
    else                  # we have an even array length and need to average
      indexR = numCount / 2
      indexL = indexR - 1
      @median = (numbersSorted[indexR] + numbersSorted[indexL]) / 2.0
    end

    # Sum calculation
    runningTotal = 0
    numbersSorted.each do |arrayNum|
      runningTotal += arrayNum
    end
    @sum = runningTotal

    @mean = @sum.to_f / numCount

    # Variance calculation
    runningVariance = 0
    numbersSorted.each do |arrayNum|
      difference = arrayNum - @mean
      runningVariance += difference**2
    end
    @variance = runningVariance / numCount

    @standard_deviation = @variance**(0.5)

    # Mode Calculation
    bestMode = numbersSorted[0]   # Make default Mode the first element (=MIN)
    bestOccurences = 1            # Corresponds with the default Mode above
    lastIter = numbersSorted.count - 2   # stop 1 short of array end to avoid index errors
    for i in 0..lastIter
      j = i + 1
      tempOccurences = 1
      while numbersSorted[i] == numbersSorted[j]
        tempOccurences += 1
        if tempOccurences > bestOccurences
          bestMode = numbersSorted[i]
          bestOccurences = tempOccurences
        end
        if j < numbersSorted.length - 1
          j += 1
        else
          break   # This is the case where the last two elements match
        end
      end
    end
    @mode = bestMode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
