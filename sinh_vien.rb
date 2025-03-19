#Tạo danh sách sinh viên
sinh_vien_list = [
    {ma_sv:"SV001", ten:"Lê Trúc Phương Quỳnh", tuoi: 21, diem: 8.5}, 
    {ma_sv:"SV002", ten:"Nguyễn Văn Bá", tuoi: 22, diem: 7.5},
    {ma_sv:"SV003", ten:"Trần Thị Thanh", tuoi: 20, diem: 9.5},
    {ma_sv:"SV004", ten:"Trần Nguyễn Hồng Đăng", tuoi: 21, diem:8.0}
]
#Thêm sinh viên
     def them_sinh_vien(danh_sach)
        print "Nhập mã sinh viên: "
        ma_sv = gets.chomp
        print "Nhập tên sinh viên: "
        ten = gets.chomp
        print "Nhập tuổi: " 
        tuoi = gets.chomp.to_i
        print "Nhập điểm: "
        diem = gets.chomp.to_f

        sinh_vien_moi = {ma_sv: ma_sv, ten: ten, tuoi: tuoi, diem: diem}
        danh_sach << sinh_vien_moi
        puts "Thêm sinh viên thành công: #{sinh_vien_moi}"
     end
#Hiển thị danh sách sinh viên
    def hien_thi_danh_sach (danh_sach)
        if danh_sach.empty?
            puts "Danh sách sinh viên rỗng"
        else
        puts "\n Danh sách sinh viên:"
        danh_sach.each do |sinh_vien|
            puts "Mã sinh viên: #{sinh_vien[:ma_sv]}"
            puts "Tên sinh viên: #{sinh_vien[:ten]}"
            puts "Tuổi: #{sinh_vien[:tuoi]}"
            puts "Điểm: #{sinh_vien[:diem]}"
        end
    end
end
#Tìm sinh viên theo mã sinh viên
    def tim_sinh_vien_theo_ma_sv(danh_sach)
        print "Nhập mã sinh viên cần tìm: "
        ma_sv = gets.chomp
        sinh_vien = danh_sach.find {|sv| sv[:ma_sv] == ma_sv}
        if sinh_vien
            puts "\n Tìm thấy sinh viên: "
            puts "Mã sinh viên: #{sinh_vien[:ma_sv]}"
            puts "Tên sinh viên: #{sinh_vien[:ten]}"
            puts "Tuổi: #{sinh_vien[:tuoi]}"
            puts "Điểm: #{sinh_vien[:diem]}"
        else
            puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
        end
    end
#Phương thức tính điểm trung bình của lớp
def tinh_diem_trung_binh(danh_sach)
    return puts "Danh sách rỗng" if danh_sach.empty?
    tong_diem = danh_sach.sum {|sinh_vien| sinh_vien[:diem]}
    
    diem_tb = tong_diem / danh_sach.length.to_f
puts "\n Điểm trung bình của lớp: #{diem_tb.round(2)}"
end

#Sinh viên có điểm cao nhất
def tim_sinh_vien_diem_cao_nhat(danh_sach)
    return puts "Danh sách rỗng" if danh_sach.empty?
    sinh_vien_diem_cao_nhat = danh_sach.max_by {|sinh_vien| sinh_vien[:diem]}
    puts "\n Sinh viên có điểm cao nhất: "
    puts "Mã sinh viên: #{sinh_vien_diem_cao_nhat[:ma_sv]}"
    puts "Tên sinh viên: #{sinh_vien_diem_cao_nhat[:ten]}"
    puts "Tuổi: #{sinh_vien_diem_cao_nhat[:tuoi]}"
    puts "Điểm: #{sinh_vien_diem_cao_nhat[:diem]}"
end
#Lọc danh sách sinh viên theo độ tuổi
def loc_sinh_vien_theo_tuoi(danh_sach)
print "Nhập độ tuổi cần lọc:"
tuoi = gets.chomp.to_i
danh_sach_loc = danh_sach.select {|sv| sv[:tuoi] == tuoi}
if danh_sach_loc.empty?
    puts "Không tìm thấy sinh viên nào có tuổi #{tuoi}"
else
    puts "\n Danh sách sinh viên có tuổi #{tuoi}:"
    danh_sach_loc.each do |sinh_vien|
        puts "Mã sinh viên: #{sinh_vien[:ma_sv]}"
        puts "Tên sinh viên: #{sinh_vien[:ten]}"
        puts "Tuổi: #{sinh_vien[:tuoi]}"
        puts "Điểm: #{sinh_vien[:diem]}"
    end
end
end
#Xóa sinh viên theo mã sinh viên
def xoa_sinh_vien_theo_ma_sv(danh_sach)
    print "Nhập mã sinh viên cần xóa:"
ma_sv = gets.chomp
    sinh_vien = danh_sach.find {|sv| sv[:ma_sv] == ma_sv}
    if sinh_vien
        danh_sach.delete(sinh_vien)
        puts "Xóa sinh viên #{sinh_vien[:ten]}(Ma SV: #{ma_sv})thành công"
    else
        puts "Không tìm thấy sinh viên có mã: #{ma_sv}"
    end
end
# sinh_vien_list.each do |sinh_vien|
#     puts "Mã sinh viên: #{sinh_vien[:ma_sv]}"
#     puts "Tên sinh viên: #{sinh_vien[:ten]}"
#     puts "Tuổi: #{sinh_vien[:tuoi]}"
#     puts "Điểm: #{sinh_vien[:diem]}"
# end
#menu
lua_chon = 0
while lua_chon != 8
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
    lua_chon = gets.chomp.to_i
    case lua_chon
        when 1
            hien_thi_danh_sach(sinh_vien_list)
        when 2
            them_sinh_vien(sinh_vien_list)
        when 3
            tim_sinh_vien_theo_ma_sv(sinh_vien_list)
        when 4
            tinh_diem_trung_binh(sinh_vien_list)
        when 5
            tim_sinh_vien_diem_cao_nhat(sinh_vien_list)
        when 6
            loc_sinh_vien_theo_tuoi(sinh_vien_list)
        when 7
            xoa_sinh_vien_theo_ma_sv(sinh_vien_list)
        when 8
            puts "Thoát chương trình"
            exit
        else
            puts "Lựa chọn không hợp lệ"
    end
    puts "\n Nhấn Enter để tiếp tục"
    gets
end



    
