require 'sqlite3'

$db = SQLite3::Database.new "students.db"
$db.results_as_hash = true
$db.execute <<-SQL
CREATE TABLE IF NOT EXISTS students (
    ma_sv TEXT PRIMARY KEY,
    ten TEXT,
    tuoi INTERGER,
    diem REAL
);
SQL
class Student
    attr_accessor :ma_sv, :ten, :tuoi, :diem
    
    def initialize (ma_sv, ten, tuoi, diem)
        @ma_sv = ma_sv
        @ten = ten
        @tuoi = tuoi
        @diem = diem
    end
    def save 
        $db.execute("INSERT OR REPLACE INTO students (ma_sv, ten, tuoi, diem) VALUES (?, ?, ?, ?)",
                        [@ma_sv, @ten, @tuoi, @diem])
    end
    def self.find_stu_by_ID(ma_sv)
        row = $db.execute("SELECT * FROM students WHERE ma_sv = ?", [ma_sv]).first
        row ? Student.new(row["ma_sv"], row["ten"], row["tuoi"], row["diem"]) :nil
    end
    def self.delete_stu_by_ID(ma_sv)
        $db.execute("DELETE FROM students WHERE ma_sv = ?", [ma_sv])
    end
    def show
        puts "
        Mã SV: #{@ma_sv} 
        Tên: #{@ten} 
        Tuổi: #{@tuoi} 
        Điểm: #{@diem}"
    end
end
class Management
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
        stu.save
        puts "Thêm sinh viên thành công"
    end
    def show_list
        rows = $db.execute("SELECT * FROM students")
        if rows.empty?
            puts "Danh sách sinh viên rỗng"
        else
            puts "\n Danh sách sinh viên: "
            rows.each{|row| Student.new(row["ma_sv"], row["ten"], row["tuoi"], row["diem"]).show}    
        end 
    end
    def find_stu_by_ID
        print "Nhập mã SV cần tìm: "
        ma_sv = gets.chomp
        stu = Student.find_stu_by_ID(ma_sv)
        if stu
            stu.show
          else
            puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
          end
    end
    def average_core
        return puts "Danh sách rỗng" if Student.count.zero?
        rows = $db.execute("SELECT AVG(diem) AS avg_score FROM students").first["avg_core"]
        avg_core = rows["avg_score"]
        puts "\n Điểm trung bình của lớp: #{avg_core.round(2)}" if avg_core
    end
    def find_stu_have_max_core
        return puts "Danh sách rỗng" if Student.count.zero?
        row = $db.execute("SELECT * FROM students ORDER BY diem DESC LIMIT 1").first
        if row
            puts "\nSinh viên có điểm cao nhất: "
            Student.new(row["ma_sv"], row["ten"], row["tuoi"], row["diem"]).show
        else
            puts "Danh sách rỗng"
        end
    end
    def list_stu_by_age
        print "Nhập độ tuổi cần lọc: "
        tuoi = gets.chomp.to_i
        row = $db.execute("SELECT * FROM students WHERE tuoi = ?", [tuoi])
        if row.empty?
            puts "Không tìm thấy sinh viên có tuổi #{tuoi}"
        else
            puts "\n Danh sách sinh viên có tuổi #{tuoi}: "
            rows.each{|row| Student.new(row["ma_sv"], row["ten"], row["tuoi"], row["diem"]).show}
        end
    end
    def delete_stu_by_ID
        print "Nhập mã SV cần xóa: "
        ma_sv = gets.chomp
        stu = Student.find_stu_by_ID(ma_sv)
        if stu
            Student.delete_stu_by_ID(ma_sv)
            puts "Xóa thành công sinh viên có mã #{ma_sv}"
        else
            puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
        end
    end
end
qlsv = Management.new
students = [
    Student.new("SV001", "Lê Trúc Phương Quỳnh", 21, 8.5),
    Student.new("SV002", "Nguyễn Văn Bá", 22, 7.5),
    Student.new("SV003", "Trần Thị Thanh", 20, 9.5),
    Student.new("SV004", "Trần Nguyễn Hồng Đăng", 21, 8.0)
]
students.each(&:save)
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



   
    