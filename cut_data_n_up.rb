require 'csv'

if File.exists?('input_mailing_data.csv')
  puts "How Many Up?"
  n_up = gets
  
  #file = CSV.read('input_mailing_data.csv','r', :headers => true).sort_by{|a| a.values_at(0)}
  file = CSV.read('input_mailing_data.csv','r', :headers => true)
  headers = file.first.headers
  header_string = ""
  file.first.headers.each do |h|
    header_string = "#{header_string}" + "#{h}" + ","
  end
  length = 0
  file.each do |row|
    length += 1
  end
  puts "File Has #{length} Records"
  puts "Current Headers => #{header_string}"
  new_file_length = (length / n_up.to_f).ceil
  puts "New File Will Be #{new_file_length} Records"
  n_up_times = n_up.to_i - 1
  new_headers = Array.new
  n_up.to_i.times do |t|
    headers.each do |h|
      new_headers << "#{h}_#{t+1}"
    end
  end
  puts "#{new_headers}"
  new_file = CSV.open('output.mailing_data.csv','wb')
  new_file << new_headers
  
  start_line = 0
  new_file_length.times do |t|
    start_line = t
    get_lines = [t]
    new_line = []
    n_up_times.times do |n|
      t = t + new_file_length
      get_lines << t
    end
    puts "#{get_lines}\n"
    get_lines.each do |l|
      unless file[l].nil?
        file[l].each do |col|
          new_line << col[1]
        end
      end
    end
    new_file << new_line
    
  end
  
else
  puts "You Need a file named 'input_mailing_data.csv' in this folder"
end
