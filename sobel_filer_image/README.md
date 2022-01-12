lý thuyết:
	- điểm ảnh 8bit là dạng mầu từ đen đến trắng , ở giữa là các mầu có độ xám khác nhau
	không có những mầu như xanh đỏ tím v.v. khi 
	- ảnh được chia thành các pixel ,mỗi pixel là 1 điểm ảnh có độ rộng 8 bit
 	có giá trị từ 0-> 255( đen-> trắng)
	- chia ảnh thành các matrix 3x3 pixel (9 pixel . 8bit=72 bit)
	mỗi matrix sẽ gồm 3 dòng(linebuffer) mỗi dòng 3 pixel
	dùng 4 linebuffer làm bộ dịch chuyển để duyệt hết bức ảnh
	- thuật toán sobel:
		-nhân ma trận 3x3 lần lượt với 2 ma trận Gx và Gy rồi cộng tổng 9 giá trị của 2 matrix thành sumDataint1 và sumDataint2
		tiếp theo tính convolved_data_int1=sumDataint1 .sumDataint1 ,convolved_data_int2=sumDataint2 .sumDataint2
		convolved_data_int=convolved_data_int1+convolved_data_int2
		- sử dụng 1 giá trị định mức , nếu convolved_data_int lớn hơn thì xuất ra điểm ảnh trắng là 255
		nếu nhỏ hơn thì xuất ra điểm ảnh đen là 0

mô tả code và kí hiệu:
[i*8 +: 8] -> [i*8 +7 : i*8]
 dòng thứ 31 của linebuffer khai báo 512 thanh ghi line là do kích thước ảnh có chiều rộng là 512px