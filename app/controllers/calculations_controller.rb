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

    wordsArray = @text.split(" ")

    @word_count = wordsArray.length;

    @character_count_without_spaces = @character_count_with_spaces - @word_count + 1

    $i = 0
    $count = 0
    while $i < @word_count do
      if wordsArray[$i].gsub(/\W/,"") == @special_word
        $count += 1
      end
      $i += 1
    end
    @occurrences = $count

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

    mpr = @apr/12/100

    months = @years * 12

    @monthly_payment = @principal * mpr / (1 - ((1 + mpr) ** (-months)))


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

    @minutes = @seconds / 60.0

    @hours = @minutes / 60.0

    @days = @hours / 24.0

    @weeks = @days / 7.0

    @years = @weeks / (365.25 / 7.0)

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

    numberArray = @numbers

    @count = numberArray.length


    # min, max, sum, tempSort

    min = Float::INFINITY
    max = - Float::INFINITY
    sum = 0
    sortedArray = Array.new(@count)

    $i = 0
    while $i < @count do
      min = [min, numberArray[$i]].min
      max = [max, numberArray[$i]].max
      sum += numberArray[$i]
      sortNumber = 0
      $j = 0
      while $j < @count do
        if (numberArray[$j] < numberArray[$i])
          sortNumber += 1
        end
        $j += 1
      end
      sortedArray[sortNumber] = numberArray[$i]
      $i += 1
    end

    @minimum = min
    @maximum = max
    @range = @maximum - @minimum

    @sum = sum
    @mean = sum/@count


    # sortArray, mode
    $i = 0
    prevNumber = nil
    tempMode = nil
    tempModeCount = 1
    mode = nil
    modeCount = 1
    while $i < @count do
      if (sortedArray[$i] != nil)
        prevNumber = sortedArray[$i]
      else
        sortedArray[$i] = prevNumber
        tempMode = prevNumber
        tempModeCount += 1
        if(tempModeCount > modeCount)
          mode = tempMode
          modeCount = tempModeCount
        end
      end
      $i += 1
    end

    @sorted_numbers = sortedArray

    @mode = mode

    if(@count.odd?)
      @median = sortedArray[(@count - 1) / 2]
    else
      @median = (sortedArray[@count/2 - 1] + sortedArray[@count/2])/2.0
    end


    # var, stdev

    var = 0

    $i = 0
    while $i < @count do
      var += (numberArray[$i] - @mean) ** 2 / @count
      $i += 1
    end

    @variance = var
    @standard_deviation = var ** 0.5

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
