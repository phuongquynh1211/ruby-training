class Schedule
    attr_reader :name, :sessions

    def initialize(name)
        @name = name
        @sessions = []
        yield self if block_given? #check xem co block nao duoc truyen vao k
    #yeild self: goi block duoc truyen vao voi doi tuong hien tai
    end 
    def add_session(subject, time:, room:, teacher: )
        @sessions << {subject: subject, time: time, room: room, teacher: teacher}
    end
    def print_schedule
        puts "#{@name}:"
        @sessions.sort_by {|s| parse_time(s[:time])}.each do |session|
            puts "Subject: #{session[:subject]}"
            puts "Time: #{session[:time]}"
            puts "Room: #{session[:room]}"
            puts "Teacher: #{session[:teacher]}"
        end
    end
    private #phuong thuc noi bo, vi chi co class moi can dung parse_time
    def parse_time(time_range)
        start_time = time_range.split("-").first
        hour,min = start_time.split(":").map(&:to_i)
        hour * 60 + min
    end
end
schedule = Schedule.new("Lịch học Ruby") do |s|
    s.add_session "Ruby nâng cao", time: "13:00-15:00", room: "A1.02", teacher: "Trần Thị B"
    s.add_session "Ruby cơ bản", time: "9:00-11:00", room: "A1.01", teacher: "Nguyễn Văn A"
    s.add_session "Rails cơ bản", time: "15:30-17:30", room: "A1.03", teacher: "Lê Văn C"
end
  
  schedule.print_schedule