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

    @all_words = @text.split(" ")
    @word_count = @all_words.length

    #Number of spaces=No. of words-1
    @character_count_without_spaces = @character_count_with_spaces-@word_count+1
    @occurrences=0

    @all_words.each do |word|
      if word.to_s==@special_word.to_s
        @occurrences=@occurrences+1
      end
end
    @occurrences

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

      @monthlyrate=@apr/1200 #monthly rate
      @months=@years*12 #number of months
      @num= @monthlyrate * @principal #numerator intermediate variable
      @den= 1- (1+@monthlyrate)**-@months #denominator intermediate variable
      @monthly_payment= (@num/@den).round(2)
      @monthly_payment

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    @sum = 0
    @count=0
    @numbers.each do |number|
      @count=@count+1
      @sum = @sum + number
    end

    @sorted_numbers = @numbers.sort

    @count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    if @count.odd?
      @median = @sorted_numbers[(@count-1)/2]
    else
        @median = (@sorted_numbers[(@count)/2] + @sorted_numbers[(@count)/2 -1])/2
    end


    @sum

    @mean = @sum/@count

#Variance calculation
@variance=0
@numbers.each do |number|
  @variance=@variance+(number-@mean)**2
end
  @variance=@variance/@count

  @standard_deviation = @variance**(0.5)

#calculate mode
@i=0
@frequency=Array.new(@count,0)
@mode=@sorted_numbers[0]
@sorted_numbers.each do |number|
  if(@sorted_numbers[@i]==@sorted_numbers[@i+1])
    @mode=@sorted_numbers[@i]
    @frequency[@i]=@frequency[@i]+1
  else @frequency[@i]=@frequency[@i]+1
    end
  @i=@i+1
end
    @mode


    render("descriptive_statistics.html.erb")
  end
end
