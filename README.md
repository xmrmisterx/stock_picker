# stock_picker

So, this stock_picker method will take in an array of stock prices, so I guess the first parameter is an array, arr1. It returns 2 values, first the best day to buy, and second the best day to sell. The best day to buy, is when the price is the lowest, and the best day to sell, is when the price is the highest generally. Can we initialize our array like this inside the parameter? We're gonna try it. Putting it in terminal, seems like it works.

Let's go over the example given. So, the array of prices given is [17,3,6,9,15,8,6,1,10], and the solution would be [1,4], which represents the 2nd and 5th days. So, buying on the 2nd day at 3 dollars, then selling on the 5th day at 15 dollars, nets a 12 dollar profit. There are a couple of pitfalls mentioned. One is that you must buy before you sell. The other is that the lowest day (best day to buy) can be the last day (in which case you'd have to pick the 2nd lowest day I guess) and the highest day can be the first day (so you wouldn't be able to sell on this day, as you'd need to buy first)

Alright, let's push out a pseudocode for what we want to do... Given an array of numbers, our function will loop through them, and find the lowest number. We will return that as the best day to buy. Then it finds the highest number, and that will be returned as the best day to sell. Once we get this working, we need to code for the exceptions. What are the exceptions, beyond the ones mentioned in the assignment? Looking over the sample array of stock prices, we see that even though 17 was the highest number, we didn't sell then bc that was the first day, and we can't sell on the first day, so an if statement if the highest value is on the first day, we can't use it to sell. We also notice that 1 is the lowest value, not 3, but we bought at 3, bc there is a greater difference between 15 and 3, than 1 and the only possible day to sell it, at 10. Ok, so we'll define "best day to buy and sell as" the day when the difference between buy and sell dates is the highest. Alright, let's get coding and see what roadblocks we run into.

Ok, so let's repeat what we are trying to find again. The 'best day to buy', which is the day with the biggest possible difference in price. Let's again break down our thought process, as if we are the computer. How would we go about determining the best possible day to buy and sell, given an array of prices. To buy, we'd zone in on all the lowest prices, but it's not as simple as picking out the lowest price. We need to find a day after that we can sell for, that gives us the highest difference between the 2. So...looking at this array, 3 and 1 jumps out at us. So, 3 can be minused from 15, and 1 can be minused from 10, so 3 and 15 is the correct answer here. The computer can't just stop at the 2 lowest numbers, it would have to find, or sort, the numbers by highest to lowest. Then, it would substract that number from all the future days after it, to find the biggest difference. 

Ok, we want to break it up into the small chunks. The first thing we'll do, is sort for the smallest number. Ok, so we create the sort_lowest_price function, and it works with the '.sort' method, and see that 6 appears twice. Is this a problem? Do we want duplicates? For now, we'll just leave it in. Now, let's subtract every number from our original array to see what gives us the biggest difference. We need to make sure we return the first item in the sorted array, bc it is the smallest. Actually we probably want to loop through this whole array, so we won't want to do that. Now that we look at our function, after renaming it to sort array, all we had to do was call sort on the array, didn't need a function bc 'sort' is already a function lol.

Next, we need to get the biggest difference between all the buy prices, and sell prices. So, we're gotta iterate through our sorted list, starting with the lowest prices. We want to start with the lowest prices first as a heuristic for human comparison, but for a computer, I think we just run the code that calculates the best difference between every buy point (every array component), with all the possible sell prices.

Ok, we need a function to determine what prices we can actually sell a bought stock at, the parameter for this function being the stock price. Can it be the same day? I think so. If we were given a stock price that is always dropping, I think it can be the same day, but I think this exercise assumes we can only sell the next day or later. So, we take the stock price parameter, determine whatever index it is (via find_index) on the original price array, then create a sellable prices array that only houses the prices at ".find_index(x) + 1" to the end of the array. Then we iterate through the sellable prices array, perform a simple subtraction with our buy price, and find the highest positive value. We get the index of that price, and the index of our price, and those become the solution to our question.

Now that we think about it some more. There's no real reason to sort the initial array. Let's just loop through the initial array, assume thats the buy price, and subtract it from all possible sell days to find the best profit. Let's talk it out some more. We take the first item in the array, and subtract all the possible selling days from it (this would be all the days to the right of it, up to the end), then we take the next item, so we are looping through the price array, and subtract it from all the prices to the right of it. I think it's that simple. We keep trying to make new functions and such, but I don't think it's that complicated. We don't need to sort, and we dont need to make new sellable arrays to compare to.

We're getting an error when we test this method. not sure what it means 'nil class '-''. It's compiling, but when we try to run stock_picker it gives us that error. This is kinda aggravating. Not sure if it's talking about the minus sign error or what. Oh, googling that error message says we are using square bracket notation from an object, but object is missing or nil. I think we need to put a limit on when to stop our function. Yeah, that was it. We needed to put an if statement in there, so we needed a variable for next_index, and put that "if next_index <= arr1.length -1", then we stop. It was trying to perform operations for objects past our array I guess, so returned an error. I think we're burned out or something, took us so long to catch that. Let's stop for now.

So, we get a bunch of differences from subtracting, now what? First off, or all of these subtractions valid? Yes, we are subtracting after we buy, so all of these dates are possible sell dates, some more profitable than others. However, looking at the code reveals that we are only subtracting the next day, so essentially all our data is based upon buying it on 1 day, then selling it the very next day. That's not the logic we're trying to program. What we WANT to do, is for each buy, loop through the array a second time, and sell at each possible sell point, those sell points being any day after the buying day. Right now this data set is a little big, which makes is kinda hard to test. Let's try a data set of 3 numbers, and figure out our logic on that, instead of testing the code on this larger data set and taking longer to debug, and causing more confusion.

Let's put into words what we want the loop inside a loop to do... The first loop loops through our array, like a normal loop, from 0 to 2 for an array of 3 things. The inner loop, for item 0 from the outer loop, will take the difference starting from its index value, plus 1, which actually all the inner loops will be like this. So, at 0, we check the difference from 1 and 2, then at 1, we check from 2, then at 2, we can't check, so basically we can remove all buys from the last day, but in code form... we stop when next index >= index.length. This is very similar to the loop within a loop we did last assignment, the substrings one. Can we hack out the code here?

Alright, so we've formatted our code for easier readability and and debugging, now... Let's try to find the correct code for the loop within a loop. Remember that it coulda be just 2 for loops like in substrings, it doesn't have to be arr1.each loops. Ok, so our first loop, are the buying prices, so let's set that loops variable to "buy_price", and the second loop, those are our selling prices, so "sell_price". What we want to do is subtract the buy prices from all the sell prices, unless... the sell prices index spot relative to the buy price index spot is on the same day or before, in other words, if the sell price is at least 1 index value past the buy price; furthermore, once the index of the sell price is >= index.length, we stop subtracting, we can no longer take profit bc that is the last date in our price array. Alright, so we run the code, and it seems to work, but we are looking at our outputs and buy price 6 and sell price 6 isn't showing up as 1 of our outputs. Why is that? We aren't using the values of the indices, so it's not like 6 and 6 are duplicates. The first 6 and the 2nd 6 have different index spots, so they should be subtracted, but we don't see them. Let's make a sample price array of all duplicates, or half duplicates, and see if maybe we're just reading it wrong. It does look like some of the values are being skipped. Let's put p in the arrays and see what's actually happening.

Ater some debugging, I think we figured it out. The sell price index is seemingly finding the first iteration of the array at the sell price. which is why duplicates aren't showing up correctly. If our array has [6,x, 6] and we say take the array index at 6 and subtract index at 6, it finds the first 6 both times and we get 6-6=0, which doesn't meet our requirement to take profit bc it thinks its subtracting the same day that we bought. Hmm... this is an interesting bug. How do we tell it we want the index from that 6, not the first 6. We did some googling and there seems to be alot of convoluted ways to get the index in an array of duplicates. What if we used the double for loops, does that avoid the duplicates problem? Hmm.. what if we word it a different way that doesn't involve index values? Technically, the best selling day might actually be a day in which we lose money, but the rest of the selling days we lose even more money. However, this assignment is assuming profit. So, we can just put a stipulation into the prices themselves, and not the index value. Something along the lines of, if the sell price is less than the buy price, we don't take profit. This still accomplishes the assignment, and avoids the duplicate index value problem in an array, but we will have a less complete data set. But maybe we should learn how to avoid duplicates in arrays now anyway? Lol. After rethinking, yeah, this isn't really important. Basically we will be missing data points where the profit is 0, I don't think this problem really affects the final outcome of the assignment, so we can just ignore it. 

Ok, so we get all the relevant profit values, now what? We figure out the greatest value among those, but then we need to spit out the buy and sell values. It sounds like we need a hash, but can the profit be a key, and then the buy and sell values be key values? Can we have 2 key values for 1 key in a hash? We're gonna have to google that. But before everything else, have we considered the all the exceptions for buying and selling? We considered that we can't buy on the last day right? Yeah I think we covered that with "arr1.find_index(sell_price) <= (arr1.length - 1)", which means we can't sell on the last day. We've considered that we can't buy and sell on the same day with "(arr1.find_index(sell_price) - arr1.find_index(buy_price)) >= 1". We've considered the highest value being the first day exception, as the profits calculated would make it not show up as being most profitable. Alright, let's google if we can have 2 hash values per key, then put our values into a hash. Ok, yes, the formatting is what we'd imagine, we just set 2 values for 1 key, we want the buy price as the first hash value, so that the output is the same as in the assignment. We used "hash[:profit]..." for profit, but it printed ":profit" for the key, is it actually "hash[profit]"? OK, it is, but we see we aren't adding to the hash, how do we add each figure to hash. It seems ".merge!(new hash)" is what we're looking for, and its apparently a predicate method. Wait a minute, apparently we can only have 1 key and 1 key value? I think what we want to use is a dictionary instead, and how to add to it, so google "dictionary" instead.

Looking around, we might actually be using the incorrect syntax. To add an array of values, we need brackets, so "profit => [x,y]", instead of "profit => x,y" Ok, yeah that worked. Not sure if we're dumb or what, but we looked through multiple hash tutorials before finally figuring that out. Not sure why it wasn't explicit in other places, maybe bc this isn't the best way if we want 1 key assigned to multiple values? It works I guess, but the hashes aren't adding. How do we keep accumulating in the hash? Ok, think we figured it out. We have to declare the hash outside of all the loops, add to it inside the loops, then print it out outside of all the loops. It was probably returned the correct hash, but we just printed inside the loops and it was only printing each loop iteration, maybe.

Alright, so we have this profits hash, so simply take the highest value key, and return the value associated with it. Ok, so let's use ".sort" on this hash and see what we get. Then maybe '.last' to get the highest value, then return that value. "Sort" does give it from smallest to largest, so let's print the largest (last) value. So it seems there is an inbuilt ".first" method, but no inbuilt ".last" method. I guess we can reverse this and use the first method? Lol, we keep trying to figure out these inbuilt methods ourself and having a bad time at it. So we see that the syntax for the value at a hash key is "hash[key]" so we use "reversesorted_profit_hash[reversesorted_profit_hash.first] and get an error, but looking it up, "hash.first" is the way to get the value from the first key. Hmmm, that actually printed out the whole thing, key and value pair, but we just want the value pair. It seems like this is the end, but we are having such a hard time just outputting the values , the hell? So, let's try "reversesorted_profit_hash.[12]" since we know one of the keys is 12, does this just give us our values? Nope, an error, wrong syntax. Let's try "reversesorted_profit_hash[12]", we can't even output the key and value now lol. That was an interesting output. It didn't sort or reverse when it gave us that key and value, it was -7... which is 12th index, when not reversed. Alright, let's replace 12 with 0 and see what outputs. 0 did give us the key and value pair that we wanted, so this bracket notation, is by the index of the key, not by the key value. Somehow we got that confused when trying all these different syntaxes. So, we have a way to pull up the key and values via "hash[key]", now we just want it to only print the value.

Hmmm... it seems we might have to iterate through with map. I guess we can iterate through our hash with map, pull out all the values, then just get the first index item. Using "reversedsorted_profit_hash.map {|x|x.values[0]}" gives an error saying "undefined method 'values' for 12=> 3, 15", so that seems to be calling the correct array, but values doesn't work for this, is it bc the values has 2 values? Not sure, now let's try just "|x|x.values", to see if we can get all the values of the hash to print. This "values" method, this article was written 2017, maybe it's obsolete, bc everytime we've tried to use it it just shoots out errors. We get the same error, that values is not a method. We look at ruby API and it says its a public method that returns a new array with just the values, so let's try to make our reversed and sorted hash into a new hash with just the values "hash.values". Lmao,same error. This is getting rediculous. We're literally at the last step, doing what google tells us, and getting constant errors. Looking at further documentation reveals "hsh[key] → value", so let's try this, even though I think we've already tried this way? We can try "hash[0]" , which we knows returns the key and value, or "hash[12]" bc 12 is our actual key. Both of those worked, but they returned the 12 as well. I think we may have noticed something. Looking at the output of the hash, they look like arrays within arrays. Maybe it's no longer a hash, but an array, which is why values isn't working? I think puts and p are giving us different looks, but puts we can see pretty clearly our "hash" is an array within an array. Ok, let's puts out hash[0,0] and hash[0,1] and see what it says. [0,0] is blank, while [0,1] gives us our [12, [3,15]] array, just like hash[0]. What about [1,0] and [1,1]? The first one is nothing, and the second one is [9,[1,10]]. Let's examine the differences between p and puts. Let's p out the reversesorted_price_hash and see if we see the array within an array, then figure out if maybe we need to flatten this array out, or how to access our values. Wait up, if we do index 0 of the hash and it shows [12,[3,15]], can't we do the index of this value to get 3, 15? For example, if an array is [12,[3,15]], can we find a way to just print out 3,15? Ok, yeah, so p is actually the same, we just didn't notice it. I think we were returning the results before, which shows 12 => [3,15]? Let's try that to make sure. Then, let's try this out. Given an array within an array, how to we return just the 2nd part. Ok, so the code finally compiled and the return is actually the same thing, an array within an array, they all showed it was an array within an array, we just blindly looked it over and assumed our answer was a hash key and value. 

Alright, so, let's do some simple coding. If arr1 = [12,[3,15]], then what is arr1[0] and arr1[1]. We put it into terminal and get 12, and [3,15]! This is the answer we've been looking for, jesus, think we spent 2 hours here, at the finish line, unable to cross lol. Is the notation array[0].[1]? Or we we have to set our reversesorted array into a different array, then call different_array[1]? Let's try that. Lol, not sure why we thought 0.1 would work, but it didn't. Let's hope the other method works. It should, according to our array testing we just did. Ok, that got us the [3,15], but we just looked at the assignment and it actually wanted the days to buy, not the prices lol... The returned values should be [1,4]. Alright, we got the desired outcome now. Since our variables were well defined, we simply changed new hash from being a hash with the profit, buy price, and sell price, into a hash with profit, buy price index, and sell price index, and that changed all our hashes and arrays into indices instead of prices. Let's try to edit the readme and rb file before we upload. 

Below is the unedited rb file after we got the correct solution. Note that stock_picker2 is the correct stock picker function.

def stock_picker (arr1= [17,3,6,9,15,8,6,1,10])
  
  arr1.each do |current_price|

  next_price_index = arr1.find_index(current_price) + 1
  next_price = arr1[next_price_index]

    if next_price_index <= (arr1.length - 1)
      difference = next_price - current_price
      puts "current_price: #{current_price}"
      puts "next price: #{next_price}"
      puts "difference: #{difference}"
    end
  end
end

stock_picker

# def sort_array (arr1= [17,3,6,9,15,8,6,1,10])
#  sorted_array = arr1.sort
#  p sorted_array
#  return sorted_array[0]
# end

def stock_picker2 (arr1=[11,25,8])
  profit_hash = {}
  arr1.each do |buy_price|

  # sell_price_index = arr1.find_index(buy_price) + 1
  # sell_price = arr1[sell_price_index]
  # p buy_price
    arr1.each do |sell_price|

      # if sell_price_index <= (arr1.length - 1)
    # p sell_price
      
      # profit_hash = {}
      
      sell_price_index = arr1.find_index(sell_price)
      buy_price_index = arr1.find_index(buy_price)

      if ((arr1.find_index(sell_price) - arr1.find_index(buy_price)) >= 1) && (arr1.find_index(sell_price) <= (arr1.length - 1))
      
        # if arr1.find_index(sell_price) <= (arr1.length - 1)
        profit = sell_price - buy_price
        # profit_hash[profit] = buy_price, sell_price
        # new_hash = {profit=> [buy_price, sell_price]}
        new_hash = {profit=> [buy_price_index, sell_price_index]}
        puts "new_hash: #{new_hash}"
        profit_hash.merge!(new_hash)
        puts "buy_price_index: #{buy_price_index}, sell price_index: #{sell_price_index}, profit: #{profit}"

      else puts "buy_price: #{buy_price}, buy_price_index: #{buy_price_index}  sell price: #{sell_price}, sell_price_index: #{sell_price_index}, did not calculate profit"
      end

      puts "profit_hash: #{profit_hash}"
    end
  end

  # puts "profit_hash: #{profit_hash}"
  reversedsorted_profit_hash = profit_hash.sort.reverse
  # puts "reversedsorted_profit_hash: #{reversedsorted_profit_hash}"
  # p reversedsorted_profit_hash
  # return Hash[*reversedsorted_profit_hash.to_a.at(0)]
  # values_hash = reversedsorted_profit_hash.values
  # puts "reversedsorted_profit_hash[1,0]: #{reversedsorted_profit_hash[1,0]}"
  # puts "reversedsorted_profit_hash[1,1]: #{reversedsorted_profit_hash[1,1]}"
  
  final_array = reversedsorted_profit_hash[0]
  return final_array[1]
  # return reversedsorted_profit_hash[0].[1]
end
stock_picker2(arr1= [17,3,6,9,15,8,6,1,10])

stock_picker2(arr1= [3,6,5])


