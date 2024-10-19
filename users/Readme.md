Đăng ký ở bên Keycloak xong, mỗi lần login với local DB:

1, Kiểm tra xem user đã tồn tại trong DB chưa, nếu chưa thì:

- 1.1: Kiểm tra xem user đã tồn tại trong Keycloak chưa, nếu chưa thì login failed
- 1.2: Nếu user đã tồn tại trong Keycloak thì lưu thông tin user vào DB

2, Nếu user đã tồn tại trong DB thì gọi API login với Keycloak để lấy token

Nếu đăng ký, sửa, cập nhật, xoá ở local DB thì sẽ gọi API tới Keycloak để đồng bộ dữ liệu 