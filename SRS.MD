 # SRS — Đặc tả yêu cầu phần mềm / Software Requirements Specification

> **📚 Hệ thống hư cấu / Fictional System**: Dự án "NewsDaily" là hệ thống ứng dụng đọc tin tức và mạng xã hội thu nhỏ được thiết kế cho mục đích tham khảo. Các dữ liệu và tổ chức trong tài liệu là giả lập.

**Hệ thống**: Ứng dụng đọc tin tức và sáng tạo nội dung (NewsDaily)  
**Nền tảng**: Mobile App (Android & iOS)  
**Phiên bản**: 1.0  
**Ngôn ngữ giao diện**: Tiếng Việt (mặc định)  
**Công nghệ**: Flutter (Frontend), RESTful API / Firebase (Backend)

| Thông tin tài liệu | |
|---|---|
| **Tác giả** | Phan Thế Kỳ  |
| **Ngày tạo** | 20/04/2026 |
| **Dựa trên**  | Yêu cầu phát triển tính năng chia sẻ tin tức cộng đồng |
| **Trạng thái**  | Bản nháp (Draft) |

---

## 📖 Hướng dẫn đọc tài liệu

Tài liệu này đóng vai trò là "nguồn sự thật" (Source of Truth) cho đội ngũ Phát triển (Dev) và Kiểm thử (QA/Tester). 

* **Dev** sử dụng tài liệu này để thiết kế Database, API và xây dựng giao diện, luồng xử lý (logic).
* **Tester** dựa vào cột **Input/Điều kiện**, **Quy tắc** và **Kết quả/Thông báo lỗi** trong các bảng yêu cầu (REQ) để thiết kế các kịch bản kiểm thử (Test Cases). Mọi hành vi của hệ thống sai lệch so với tài liệu này đều được ghi nhận là Lỗi (Bug).

---

## 1. Tổng quan hệ thống / System Overview

Hệ thống cho phép người dùng đọc tin tức, tương tác với tác giả khác và tự tạo các bài viết của riêng mình. Có 3 vai trò chính:

| Vai trò | Quyền hạn |
|---------|----------|
| **Khách (Guest)** | Xem danh sách bài viết, đọc nội dung bài viết, tìm kiếm/lọc bài viết. Không thể tương tác hay đăng bài. |
| **Người dùng (User)** | Tất cả quyền của Guest + Đăng nhập/Đăng ký, thả cảm xúc (Like/Heart), bình luận, tạo bài viết mới, sửa/xóa bài viết **của chính mình**. |
| **Quản trị viên (Admin)**| Quản lý toàn bộ bài viết (có thể xóa bài viết vi phạm của bất kỳ ai), quản lý tài khoản người dùng, khóa bình luận. |

---

## 2. Danh sách yêu cầu / Requirements List

### REQ-01: Đăng ký & Đăng nhập (Authentication)

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Người dùng tạo tài khoản mới và đăng nhập để sử dụng các tính năng tương tác. |
| **Input** | Email, Mật khẩu, Tên hiển thị (chỉ dùng cho Đăng ký). |
| **Quy tắc Đăng ký** | Email phải đúng định dạng chuẩn. Mật khẩu ≥ 8 ký tự, chứa ít nhất 1 chữ số. Tên hiển thị không được để trống. |
| **Quy tắc Đăng nhập** | Trùng khớp Email và Mật khẩu đã lưu trong hệ thống. |
| **Thông báo lỗi** | "Email không đúng định dạng", "Mật khẩu quá ngắn", "Email đã tồn tại" (khi đăng ký), "Tài khoản hoặc mật khẩu không chính xác" (khi đăng nhập). |

### REQ-02: Nguồn cấp tin tức (News Feed)

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Hiển thị danh sách các bài viết mới nhất từ cộng đồng ở trang chủ. |
| **Hiển thị** | Ảnh bìa (Thumbnail), Tiêu đề, Tên tác giả, Ngày đăng, Số lượt cảm xúc, Số lượt bình luận. |
| **Quy tắc sắp xếp** | Mặc định sắp xếp theo thời gian: Bài đăng mới nhất hiển thị trên cùng (Reverse Chronological). |
| **Phân trang** | Cuộn vô tận (Infinite Scroll) hoặc nạp thêm 10 bài viết mỗi lần kéo xuống cuối trang. Vuốt từ trên xuống (Pull-to-refresh) để làm mới dữ liệu. |

### REQ-03: Tương tác bài viết (React & Comment)

| Mục | Nội dung |
|-----|---------|
| **Điều kiện** | Người dùng phải ở trạng thái **Đã đăng nhập**. |
| **Cảm xúc (React)** | Nhấn nút thả tim (Heart). Nhấn lần 1 để thả tim (+1), nhấn lần 2 để bỏ thả tim (-1). Một người dùng chỉ được tính 1 lượt tim trên 1 bài. |
| **Bình luận (Comment)**| Nhập nội dung text (tối đa 500 ký tự) vào khung bình luận và nhấn "Gửi". |
| **Quản lý Comment** | Người dùng có thể xóa bình luận **của chính mình**. Quản trị viên có thể xóa bất kỳ bình luận nào. |
| **Cập nhật real-time** | Lượt thả tim và bình luận hiển thị cập nhật ngay lập tức mà không cần tải lại trang. |

### REQ-04: Tạo bài viết mới (Create Article)

| Mục | Nội dung |
|-----|---------|
| **Mô tả** | Người dùng đăng tải bài viết tin tức/chia sẻ của riêng mình. |
| **Input** | Tiêu đề (bắt buộc), Ảnh bìa (tuỳ chọn), Nội dung (bắt buộc), Thể loại (bắt buộc - chọn từ danh sách). |
| **Ràng buộc** | Tiêu đề: 10 - 150 ký tự. Nội dung: Tối thiểu 50 ký tự. |
| **Xử lý** | Nhấn "Đăng bài" -> Hệ thống lưu dữ liệu -> Chuyển hướng người dùng về trang chi tiết của bài viết vừa tạo. |
| **Thông báo lỗi** | "Vui lòng nhập tiêu đề", "Nội dung bài viết quá ngắn", "Vui lòng chọn ít nhất 1 thể loại". |

### REQ-05: Quản lý bài viết cá nhân (Edit / Delete Article)

| Mục | Nội dung |
|-----|---------|
| **Điều kiện hiển thị** | Nút "Sửa" và "Xóa" chỉ xuất hiện trên bài viết nếu ID của người đang đăng nhập trùng khớp với `authorID` của bài viết đó. |
| **Chỉnh sửa (Edit)** | M mở lại form giống REQ-04 nhưng đã điền sẵn (pre-fill) dữ liệu cũ. Ngày đăng (Created_at) giữ nguyên, thêm cờ đánh dấu "Đã chỉnh sửa" (Edited). |
| **Xóa (Delete)** | Hiển thị Popup xác nhận: "Bạn có chắc chắn muốn xóa bài viết này không? Hành động này không thể hoàn tác." |
| **Kết quả xóa** | Xóa bài viết thành công -> Bài viết biến mất khỏi Feed và trang cá nhân -> Chuyển hướng về trang chủ. Toàn bộ bình luận và lượt tim của bài viết đó cũng bị xóa khỏi database. |

### REQ-06: Tìm kiếm và Lọc (Search & Filter)

| Mục | Nội dung |
|-----|---------|
| **Tìm kiếm** | Nhập từ khóa để tìm kiếm theo Tiêu đề bài viết hoặc Tên tác giả (Case-insensitive). |
| **Lọc (Filter)** | Lọc theo các danh mục thể loại (Ví dụ: Công nghệ, SEO & Marketing, Đời sống). |
| **Không có kết quả** | Hiển thị hình ảnh minh họa (Empty state) và dòng chữ: "Không tìm thấy bài viết nào phù hợp." |

---

## 3. Dữ liệu ban đầu / Seed Data

### 3.1. Tài khoản (Accounts)

| Email | Mật khẩu (Mã hóa) | Tên hiển thị | Vai trò | ID |
|-------|------------------|--------------|---------|-----|
| `admin@newsdaily.com`| `hash_123` | Admin System | Admin | UID001 |
| `dev.master@email.com`| `hash_456` | Flutter Dev | User | UID002 |
| `content.pro@email.com`| `hash_789` | Chuyên gia Content | User | UID003 |

### 3.2. Bài viết (Articles)

| Mã bài | Tiêu đề | Tác giả | Thể loại | Trạng thái | Lượt Tim |
|--------|---------|---------|----------|------------|----------|
| ART001 | Hướng dẫn tối ưu SEO Onpage 2026 | UID003 | SEO & Marketing | Công khai | 15 |
| ART002 | Quản lý State trong ứng dụng Mobile | UID002 | Công nghệ | Công khai | 32 |
| ART003 | Xu hướng Content Marketing đa nền tảng | UID003 | SEO & Marketing | Công khai | 8 |
| ART004 | Nhật ký 100 ngày code | UID002 | Đời sống | Công khai | 45 |

### 3.3. Bình luận ban đầu (Initial Comments)

| Mã Bình luận | Mã Bài (Article ID) | Người bình luận | Nội dung |
|--------------|---------------------|-----------------|----------|
| CMT001 | ART001 | UID002 | Bài viết rất chi tiết, cảm ơn tác giả! |
| CMT002 | ART002 | UID003 | Mình đang vướng mắc phần này, may quá đọc được. |

---

## 4. Giao diện hệ thống / System Interface

Cấu trúc thanh điều hướng dưới cùng (Bottom Navigation Bar):

| Tab | Chức năng chính | Trạng thái chưa đăng nhập |
|-----|----------------|---------------------------|
| **Trang chủ (Feed)**| Cuộn xem tin tức mới, tìm kiếm, lọc theo thể loại. | Hiển thị bình thường. |
| **Đăng bài (Create)**| Mở form tạo bài viết mới. | Chuyển hướng sang màn hình Đăng nhập. |
| **Cá nhân (Profile)**| Xem thông tin tài khoản, xem "Bài viết của tôi", Quản lý bài viết (Sửa/Xóa), Đăng xuất. | Chuyển hướng sang màn hình Đăng nhập. |

---

## 5. Ràng buộc kỹ thuật / Technical Constraints

1. **Kết nối mạng**: Ứng dụng yêu cầu kết nối Internet (Wi-Fi hoặc 4G/5G) để lấy dữ liệu. Nếu mất mạng, hiển thị thông báo "Vui lòng kiểm tra kết nối mạng". Cache cục bộ chỉ lưu bài viết đã tải để đọc offline, không hỗ trợ đăng bài offline.
2. **Kích thước ảnh**: Ảnh bìa bài viết upload lên hệ thống tự động nén (compress) và dung lượng không được vượt quá 5MB/ảnh. Định dạng hỗ trợ: JPG, PNG, WEBP.
3. **Bảo mật API**: Các API tạo, sửa, xóa bài viết và bình luận yêu cầu truyền kèm Token xác thực (Bearer Token) trong Header. Nếu Token hết hạn (Unauthorized 401), tự động đẩy người dùng về màn hình đăng nhập.
