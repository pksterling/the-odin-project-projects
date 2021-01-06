require "csv"
require "google/apis/civicinfo_v2"
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

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

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exist? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def find_registration_hour(datetime)
  DateTime.strptime(datetime, "%m/%d/%y %k:%M").hour
end

def find_registration_day(datetime)
  DateTime.strptime(datetime, "%m/%d/%y %k:%M").wday
end

def find_busiest_hour(hour_tally)
# Will also work for weekdays
  active_hours = hour_tally.uniq
  active_hour_frequency = {}
  peak_hours = []

  active_hours.each do |hour|
    active_hour_frequency["#{hour}"] = hour_tally.count(hour)
  end

  sorted_hour_frequency = active_hour_frequency.sort_by {|k, v| -v}
  highest_frequency = sorted_hour_frequency[0][1]

  sorted_hour_frequency.each do |hour_with_frequency|
    if hour_with_frequency[1] == highest_frequency
      peak_hours.push(hour_with_frequency[0])
    end
  end

  "#{highest_frequency} citizen(s) registered during the following peak time period(s): #{peak_hours.join(", ")}"
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
registration_hour_tally = []
registration_day_tally = []

contents.each do |row|
  id = row[0]
  registration_hour = find_registration_hour(row[:regdate])
  registration_day = find_registration_day(row[:regdate])
  name = row[:first_name]
  phone_number = clean_phone_number(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)

  registration_hour_tally.push("#{registration_hour}:00-#{registration_hour}:59")
  registration_day_tally.push("#{Date::DAYNAMES[registration_day]}s")
end

p find_busiest_hour(registration_hour_tally)
p find_busiest_hour(registration_day_tally)