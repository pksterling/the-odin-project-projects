# Find maximum potential profit after buying stock on day one of given array
def check_sales(remaining_array)
  highest_profit = 0
  days = 0

  # Find the profit of each potential sale day
  for sale in remaining_array do
    profit = sale - remaining_array[0]
    
    # If profit on a given day beats previous record, log the new details
    next unless profit > highest_profit

    highest_profit = profit
    days = remaining_array.index(sale)
  end

  # Return details of highest day of profit
  profit_days = [highest_profit, days]
end

# Check every possible buy/sell day combination
# Return array containing the best buy/sell days
def stock_picker(stocks)
  i = 0
  highest_profit = 0
  purchase_date = 0
  sale_date = 0

  while i < stocks.length
    profit_days = check_sales(stocks[i..])
    profit = profit_days[0]

    # If the maximum potential profit of a buy day beats the record,
    # Log the details
    if profit > highest_profit
      highest_profit = profit
      purchase_date = i
      sale_date = i + profit_days[1]
    end

    i += 1
  end

  buy_sell = [purchase_date, sale_date]
end

p stock_picker([17,3,6,9,15,8,6,1,10])