class Student
    attr_accessor :ma_sv, :ten, :tuoi, :diem
    
    def initialize (ma_sv, ten, tuoi, diem)
        @ma_sv = ma_sv
        @ten = ten
        @tuoi = tuoi
        @diem = diem
    end
    def show
        puts "
        Mã SV: #{@ma_sv} 
        Tên: #{ten} 
        Tuổi: #{tuoi} 
        Điểm: #{diem}"
    end
end
class Management
    attr_accessor :list
    def initialize
        @list = []
    end
    def add_stu
        print "Nhập mã SV: "
        ma_sv = gets.chomp
        print "Nhập tên SV: "
        ten = gets.chomp
        print "Nhập tuổi: "
        tuoi = gets.chomp.to_i
        print "Nhập điểm: "
        diem = gets.chomp.to_f

        stu = Student.new(ma_sv, ten, tuoi, diem)
        @list << stu
        puts "Thêm sinh viên thành công"
    end
    def show_list
        if @list.empty?
            puts "Danh sách sinh viên rỗng"
        else
            puts "\n Danh sách sinh viên: "
            @list.each(&:show)
        end 
    end
    def find_stu_by_ID
        print "Nhập mã SV cần tìm: "
        ma_sv = gets.chomp
        stu = @list.find {|s| s.ma_sv == ma_sv}
        if stu
            stu.show
          else
            puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
          end
    end
    def average_core
        return puts "Danh sách rỗng" if @list.empty?

        avr_core = @list.sum(&:diem) / @list.length.to_f
        puts "\n Điểm trung bình của lớp: #{avr_core.round(2)}"
    end
    def find_stu_have_max_core
        return puts "Danh sách rỗng" if @list.empty?
        stu_max = @list.max_by(&:diem)
        puts "\n Sinh viên có điểm cao nhất:"
        stu_max.show
    end
    def list_stu_by_age
        print "Nhập độ tuổi cần lọc: "
        tuoi = gets.chomp.to_i
        stu_list_by_age = @list.select {|s| s.tuoi == tuoi}
        if stu_list_by_age.empty?
            puts "Không tìm thấy sinh viên có tuổi #{tuoi}"
        else
            puts "\n Danh sách sinh viên có tuổi #{tuoi}: "
            stu_list_by_age.each(&:show)
        end
    end
    def delete_stu_by_ID
        print "Nhập mã SV cần xóa: "
        ma_sv = gets.chomp
        stu = @list.find {|s| s.ma_sv == ma_sv}
        if stu
            @list.delete(stu)
            puts "Xóa thành công sinh viên có mã #{ma_sv}"
        else
            puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
        end
    end
end
qlsv = Management.new
qlsv.list = [
    Student.new("SV001", "Lê Trúc Phương Quỳnh", 21, 8.5),
    Student.new("SV002", "Nguyễn Văn Bá", 22, 7.5),
    Student.new("SV003", "Trần Thị Thanh", 20, 9.5),
    Student.new("SV004", "Trần Nguyễn Hồng Đăng", 21, 8.0)
]
chose = 0

while chose != 8
    puts "\n Chương trình quản lý sinh viên"
    puts "1. Hiển thị danh sách sinh viên"
    puts "2. Thêm sinh viên"
    puts "3. Tìm sinh viên theo mã sinh viên"
    puts "4. Tính điểm trung bình của lớp"
    puts "5. Sinh viên có điểm cao nhất"
    puts "6. Lọc sinh viên theo tuổi"
    puts "7. Xóa sinh viên theo mã sinh viên"
    puts "8. Thoát chương trình"
    print "Nhập lựa chọn: "
  
  chose = gets.chomp.to_i

  case chose
  when 1
    puts "Bạn đã chọn: Hiển thị danh sách sinh viên"
    qlsv.show_list
  when 2
    puts "Bạn đã chọn: Thêm sinh viên"
    qlsv.add_stu
  when 3
    puts "Bạn đã chọn: Xóa sinh viên"
    qlsv.delete_stu_by_ID
  when 4
    puts "Bạn đã chọn: Tính điểm trung bình của lớp"
    qlsv.average_core
  when 5
    puts "Bạn đã chọn: Sinh viên có điểm cao nhất"
    qlsv.find_stu_have_max_core
  when 6
    puts "Bạn đã chọn: Lọc sinh viên theo tuổi"
    qlsv.list_stu_by_age
  when 7
    puts "Bạn đã chọn: Xóa sinh viên theo mã sinh viên"
    qlsv.delete_stu_by_ID
  when 8
    puts "Thoát chương trình."
    exit
  else
    puts "Lựa chọn không hợp lệ. Vui lòng nhập lại!"
  end
  puts "\nNhấn Enter để tiếp tục..."
  gets
end



   
    