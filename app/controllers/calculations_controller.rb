class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================ㄋ

    @character_count_with_spaces = @text.count "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789"

    @character_count_without_spaces = @text.count "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789", "^ "

    @occurrences = @special_word.size
    # occurrences_count = Hash.new(0)
    # @text.each { |:user_word| occurrences_count[:user_word] += 1 }
    # puts occurrences_count

    @word_count = @text.scan(/(\w|-)+/).size

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

    @monthly_payment = (@principal * @apr / 100 / 12 ) / (1 - (1 + @apr / 100 / 12) ** -(@years * 12))


    #   P = (Pv*R) / [1 - (1 + R)^(-n)]
    #
    # where
    #
    #   Pv  = Present Value (beginning value or amount of loan)
    #   APR = Annual Percentage Rate (one year time period)
    #   R   = Periodic Interest Rate = APR/ # of interest periods per year
    #   P   = Monthly Payment
    #   n   = # of interest periods for overall time period (i.e., interest
    #         periods per year * number of years)


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
    @minutes = (@ending - @starting) / 60
    @hours = -((@starting - @ending) / 1.hour).round
    @days = (@ending - @starting) / 60 / 60 /24
    @weeks = (@ending - @starting) / 60 / 60 / 24 / 7
    @years = (@ending - @starting) / 60 / 60 / 24 / 365

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

    @sorted_numbers = @numbers.sort_by{ |i| i }

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median =  "Replace this string with your answer."

    # def median(ary)
    #   mid = ary.length / 2
    #   sorted = ary.sort
    #   ary.length.odd? ? sorted[mid] : 0.5 * (sorted[mid] + sorted[mid - 1])
    # end

    @sum = @numbers.sum

    @mean = @numbers.sum / @count

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    # def sum
    #   return self.inject(0){|accum, i| accum + i }
    # end
    #
    # def mean
    #   return self.sum / self.length.to_f
    # end
    #
    # def sample_variance
    #   m = self.mean
    #   sum = self.inject(0){|accum, i| accum + (i - m) ** 2 }
    #   return sum / (self.length - 1).to_f
    # end
    #
    # def standard_deviation
    #   return Math.sqrt(self.sample_variance)
    # end


    @mode = "Replace this string with your answer."
    # class Array
    #   def mode
    #     sort_by {|i| grep(i).length }.last
    #   end
    # end


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
