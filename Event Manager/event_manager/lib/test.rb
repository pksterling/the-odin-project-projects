def clean_phone_number(phone_number)
  phone_number = phone_number.to_s
  if (phone_number.length < 10 ||
      phone_number.length > 11 ||
      phone_number.length == 11 && phone_number[0] != 1)
    phone_number = "Invalid Number"
  elsif (phone_number == 11)
    phone_number = phone_number[1..10]
  end
  phone_number
end

p clean_phone_number(nil)
p clean_phone_number("123456789")
p clean_phone_number("123456789012")
p clean_phone_number("01234567891")
p clean_phone_number("12345678901")
p clean_phone_number("0123456789")