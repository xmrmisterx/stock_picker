def stock_picker (arr1=[17,3,6,9,15,8,6,1,10])
  profit_hash = {} # We define an empty hash where we want our profit values put inside. Since there are 2 answers, we decided a hash was good to use.
  arr1.each do |buy_price| # Loop through the array a first time. Each value is a possible "buy_price"

    arr1.each do |sell_price| # For each "buy_price" in the first loop, loop through the array again and use the array values as sell prices now.
      
      sell_price_index = arr1.find_index(sell_price) # We want to set the indices for our buy and sell prices to variables, so that we can debug easier and access them when needed.
      buy_price_index = arr1.find_index(buy_price)

      if ((arr1.find_index(sell_price) - arr1.find_index(buy_price)) >= 1) && (arr1.find_index(sell_price) <= (arr1.length - 1)) # We only want to include the difference between the buy and sell prices, or the "profit", to our profit_hash when 2 conditions are both met. First, the index of the sell price minus the index of the buy price must be greater than or equal to 1. This agrees with the stipulation that we must first buy before we sell. This is saying that we can only sell if we've bought the stock at least 1 day before, and no later than that. The second condition is that the index of the sell price has to be less than or equal to the array length, minus 1. This means we stop selling when the stock we buy is the last item in the stock prices array, or later. It also means we can't buy and sell on the last day.  
      
        profit = sell_price - buy_price
        new_hash = {profit=> [buy_price_index, sell_price_index]} # Because the solution requires the index of the best possible profit, we get the profit of all possible buys and sells, then add them to a temporary new_hash with their accompanying buy and sell price indices...
        # puts "new_hash: #{new_hash}"
        profit_hash.merge!(new_hash) # which we then add to our profit_hash via the merge method. We couldn't find a way to just add to the profit hash directly and keep accumulating the result, so we had to do this.
        # puts "buy_price_index: #{buy_price_index}, sell price_index: #{sell_price_index}, profit: #{profit}"

      # else puts "buy_price: #{buy_price}, buy_price_index: #{buy_price_index}  sell price: #{sell_price}, sell_price_index: #{sell_price_index}, did not calculate profit"
      end

      # puts "profit_hash: #{profit_hash}"
    end
  end

  reversedsorted_profit_hash = profit_hash.sort.reverse # We want to sort our profit_hash, which gives us the profits from lowest to highest value, and since the first value of a hash is easier to work with, we reverse the order of the sorted hash
  
  final_array = reversedsorted_profit_hash[0] # Our reversesorted_profit_hash is a hash of arrays within arrays, so in order to access the solution array, within an array of an array, we set the first item in our reversesorted array equal to a final_array...
  return final_array[1] # The final_array is [12,[1,4]], so to return [1,4] as the answer, we have to call for the 2nd item in the final array, thus "final_array[1]"

end
stock_picker => [1, 4]








