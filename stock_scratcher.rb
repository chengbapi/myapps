require 'open-uri'
require 'parallel'

%w{sz ss}.each do |market|
  Parallel.each(1.upto(2600).to_a,:in_threads => 8) do |code|
    try = 0
    attempts = 5 
    str_code = if market == 'ss' 
                 ("%04d" % code).prepend("60")
               else
                 "%06d" % code
               end
    begin
      puts "#{str_code} existed ...";next if File.exist?("./#{market}.#{str_code}.csv")
      puts "fetching data for #{market}.#{str_code}....."
      open("http://ichart.finance.yahoo.com/table.csv?s=#{str_code}.#{market}&a=1&b=1&c=1991",'rb') do |read_file|
        File.open("./#{market}.#{str_code}.csv","wb") do |save_file|
          save_file.write(read_file.read)
        end
        puts "#{market}.#{str_code} has download successfully"
      end
    rescue Exception => ex
      if ex.message == "404 Not Found"
        puts "#{market}.#{str_code} has no found"
        next
      else
        puts ex.message + "... retry ..."
        try += 1
        retry if try < attempts
      end
    end
  end
end
Parallel.each(1.upto(2600).to_a,:in_threads => 8) do |code|
  str_code =("%04d" % code).prepend("30") 
  try = 0
  attemps = 5 
  begin
    next if File.exist?("./cyb.#{str_code}.csv")
    puts "fetching data for #{str_code}....."
    open("http://ichart.finance.yahoo.com/table.csv?s=#{str_code}.sz&a=1&b=24&c=1997",'rb') do |read_file|
      File.open("./cyb.#{str_code}.csv","wb") do |save_file|
         save_file.write(read_file.read)
      end
      puts "cyb.#{str_code} has download successfully"
    end
  rescue Exception => ex
    if ex.message == "404 Not Found"
      puts "cyb.#{str_code} has no found"
      next
    else
      try += 1
      retry if try < attempts
    end
  end
end
