package utils;

import java.security.MessageDigest;
import java.util.Base64;

public class SecurityUtils {
    
    // Hàm băm mật khẩu bằng thuật toán SHA-256 siêu bảo mật
    public static String hashPassword(String plainPassword) {
        try {
            // Khởi tạo bộ băm SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // Xay mật khẩu ra thành mảng byte
            byte[] hashBytes = md.digest(plainPassword.getBytes("UTF-8"));
            
            // Đóng gói mảng byte thành chuỗi String an toàn để lưu Database
            return Base64.getEncoder().encodeToString(hashBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Báo lỗi nếu máy xay gặp trục trặc
        }
    }
}