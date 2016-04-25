class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @char_count_spaces = @text.length
    @all_words = @text.split(" ")
    @word_count = @all_words.length

      @char_count_without_spaces = @char_count_spaces-@word_count+1
   @occurrences=0

   @all_words.each do |typeword|
     if typeword.to_s==@special_word.to_s
       @occurrences=@occurrences+1
     end
end
   @occurrences

   render("word_count.html.erb")
 end
# *****************************************************************#

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

   @variance = "Replace this string with your answer."

   @standard_deviation = "Replace this string with your answer."

   @mode = "Replace this string with your answer."

   # ================================================================================
   # Your code goes above.
   # ================================================================================

   render("descriptive_statistics.html.erb")
 end
end
