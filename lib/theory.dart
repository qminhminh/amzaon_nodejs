//GET: Phương thức GET được sử dụng để truy cập tài nguyên từ máy chủ. Nó thường được sử dụng để đọc thông tin từ máy chủ mà không thay đổi dữ liệu trên máy chủ. 
//POST: Phương thức POST được sử dụng để gửi dữ liệu lên máy chủ để tạo mới tài nguyên hoặc thực hiện các thay đổi dữ liệu. Nó thường được sử dụng trong các tình huống như đăng ký người dùng, thêm sản phẩm vào giỏ hàng, gửi biểu mẫu trang web.
//PUT: Phương thức PUT được sử dụng để cập nhật tài nguyên tồn tại hoặc tạo mới nếu nó không tồn tại. Nó gửi một bản sao hoàn chỉnh của tài nguyên để cập nhật. Ví dụ: cập nhật thông tin người dùng, cập nhật thông tin sản phẩm.
//DELETE: Phương thức DELETE được sử dụng để xóa tài nguyên khỏi máy chủ
//PATCH: Phương thức PATCH tương tự như PUT, nhưng nó được sử dụng để cập nhật một phần của tài nguyên thay vì cập nhật toàn bộ tài nguyên. Nó được sử dụng khi bạn muốn thay đổi một số trường cụ thể của một tài nguyên.
//OPTIONS: Phương thức OPTIONS được sử dụng để lấy thông tin về tài nguyên và các phương thức được hỗ trợ bởi máy chủ.
//HEAD: Phương thức HEAD giống như GET, nhưng máy chủ sẽ không gửi dữ liệu thực tế, chỉ gửi thông tin tiêu đề. Nó thường được sử dụng để kiểm tra thông tin tiêu đề của tài nguyên trước khi yêu cầu GET đầy đủ.


//Khi bạn gọi jsonEncode với một đối tượng hoặc mảng, nó sẽ trả về một chuỗi JSON biểu diễn của dữ liệu đó
//Khi bạn gọi jsonDecode với một chuỗi JSON, nó sẽ phân tích chuỗi đó và tạo ra một đối tượng hoặc mảng tương ứng với nội dung của chuỗi JSON đó.



//req: Thường là viết tắt của "request" và đại diện cho yêu cầu (request) mà máy khách gửi đến máy chủ web của bạn.
// Khi một máy khách (trình duyệt, ứng dụng di động, ...) gửi một yêu cầu HTTP đến máy chủ của bạn, 
//Express sẽ tự động lấy các thông tin từ yêu cầu này và đưa chúng vào biến req. Bạn có thể sử dụng req để truy cập thông tin như thông tin về phương thức HTTP (GET, POST, PUT, DELETE, vv.),
// tham số truy vấn, thông tin địa chỉ IP của máy khách, và nhiều thông tin khác.


//res: Viết tắt của "response" và đại diện cho cách máy chủ web của bạn sẽ phản hồi yêu cầu từ máy khách. 
//Bạn sử dụng res để xây dựng và trả về phản hồi HTTP cho máy khách.
// Thông thường, bạn sẽ sử dụng res để thiết lập mã trạng thái HTTP (như 200 OK hoặc 404 Not Found),
// gửi dữ liệu về máy khách (như HTML hoặc JSON), và xử lý các lỗi (như 500 Internal Server Error).