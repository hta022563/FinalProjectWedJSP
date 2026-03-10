package utils;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

    // Điền Email của bạn (Dùng làm email tổng đài F-Auto)
    private static final String EMAIL_FROM = "hta02256master@gmail.com"; 
    
    // ĐÂY LÀ MẬT KHẨU ỨNG DỤNG (Không phải mật khẩu đăng nhập Gmail nha)
    private static final String APP_PASSWORD = "cldw bxmf dowe wwbw"; 

    public static boolean sendEmail(String toEmail, String subject, String body) {
        boolean isSent = false;

        // 1. Cấu hình thông số máy chủ SMTP của Google
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // 2. Đăng nhập vào Gmail của bạn bằng App Password
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, APP_PASSWORD);
            }
        });

      try {
            // 1. Sửa chữ Message thành MimeMessage ở đầu
            MimeMessage message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(EMAIL_FROM)); 
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); 
            
            // 2. Ép kiểu UTF-8 mượt mà
            message.setSubject(subject, "UTF-8"); 
            message.setText(body, "UTF-8"); 

            // Bấm nút Gửi
            Transport.send(message);
            isSent = true;
            System.out.println("Đã gửi mail OTP thành công tới: " + toEmail);

        } catch (Exception e) {
            System.out.println("Lỗi gửi mail: " + e.getMessage());
            e.printStackTrace();
        }
        return isSent;
    }
}