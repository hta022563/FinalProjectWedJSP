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

    private static final String EMAIL_FROM = "hta02256app@gmail.com";

    private static final String APP_PASSWORD = "urln cmax ouff fmbw";

    public static boolean sendEmail(String toEmail, String subject, String body) {
        boolean isSent = false;

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, APP_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            message.setSubject(subject, "UTF-8");
            message.setContent(body, "text/html; charset=UTF-8");

            Transport.send(message);
            isSent = true;
            System.out.println("Đã gửi mail thành công tới: " + toEmail);

        } catch (Exception e) {
            System.out.println("Lỗi gửi mail: " + e.getMessage());
            e.printStackTrace();
        }
        return isSent;
    }

    public static String getOtpEmailTemplate(String customerName, String otp) {
        StringBuilder html = new StringBuilder();
        html.append("<div style=\"font-family: 'Segoe UI', Arial, sans-serif; background-color: #0a0a0a; color: #ffffff; padding: 40px 20px; max-width: 600px; margin: 0 auto; border: 1px solid #333; border-radius: 10px;\">");
        html.append("    <div style=\"text-align: center; margin-bottom: 30px;\">");
        html.append("        <h1 style=\"color: #D4AF37; letter-spacing: 4px; margin: 0; font-size: 32px;\">F-AUTO</h1>");
        html.append("        <p style=\"color: #888; font-size: 12px; letter-spacing: 2px; text-transform: uppercase; margin-top: 5px;\">Showroom Siêu Xe Đẳng Cấp</p>");
        html.append("    </div>");
        html.append("    <h3 style=\"color: #fff; border-bottom: 1px solid #D4AF37; padding-bottom: 10px; font-weight: 500;\">Yêu Cầu Khôi Phục Mật Khẩu</h3>");
        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 15px;\">Kính chào ").append(customerName).append(",</p>");
        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 15px;\">Hệ thống F-AUTO vừa nhận được yêu cầu khôi phục mật khẩu cho tài khoản liên kết với email này. Vui lòng sử dụng mã xác thực (OTP) dưới đây để tiếp tục quá trình:</p>");
        html.append("    <div style=\"text-align: center; margin: 40px 0;\">");
        html.append("        <span style=\"display: inline-block; padding: 15px 40px; background: linear-gradient(45deg, #B8860B, #FFD700); color: #000; font-size: 36px; font-weight: bold; border-radius: 8px; letter-spacing: 8px; box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);\">").append(otp).append("</span>");
        html.append("    </div>");
        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 14px;\"><b style=\"color: #D4AF37;\">CẢNH BÁO BẢO MẬT:</b> Tuyệt đối KHÔNG chia sẻ mã này cho bất kỳ ai. Mã OTP này sẽ tự động hết hạn sau thời gian ngắn.</p>");
        html.append("    <hr style=\"border-color: #333; margin: 30px 0;\">");
        html.append("    <p style=\"font-size: 12px; color: #666; text-align: center; line-height: 1.5;\">Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email này hoặc liên hệ ngay với CSKH: <b style=\"color: #D4AF37;\">0909.123.456</b></p>");
        html.append("    <p style=\"font-size: 12px; color: #555; text-align: center;\">&copy; 2026 F-AUTO Showroom. All rights reserved.</p>");
        html.append("</div>");
        return html.toString();
    }

    public static String getOrderConfirmationTemplate(String customerName, String orderId, String paymentMethod) {
        StringBuilder html = new StringBuilder();
        html.append("<div style=\"font-family: 'Segoe UI', Arial, sans-serif; background-color: #0a0a0a; color: #ffffff; padding: 40px 20px; max-width: 600px; margin: 0 auto; border: 1px solid #D4AF37; border-radius: 10px;\">");
        html.append("    <div style=\"text-align: center; margin-bottom: 30px;\">");
        html.append("        <h1 style=\"color: #D4AF37; letter-spacing: 4px; margin: 0; font-size: 32px;\">F-AUTO</h1>");
        html.append("        <p style=\"color: #888; font-size: 12px; letter-spacing: 2px; text-transform: uppercase; margin-top: 5px;\">Showroom Siêu Xe Đẳng Cấp</p>");
        html.append("    </div>");
        html.append("    <h3 style=\"color: #fff; border-bottom: 1px solid #333; padding-bottom: 10px; font-weight: 500;\">XÁC NHẬN THANH TOÁN THÀNH CÔNG</h3>");
        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 15px;\">Kính chào quý khách <b>").append(customerName).append("</b>,</p>");
        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 15px;\">Cảm ơn quý khách đã tin tưởng và lựa chọn F-AUTO. Chúng tôi xin xác nhận hệ thống đã ghi nhận yêu cầu thanh toán cho hợp đồng của quý khách với chi tiết như sau:</p>");

        html.append("    <div style=\"background: rgba(212, 175, 55, 0.05); border-left: 4px solid #D4AF37; padding: 20px; margin: 25px 0; border-radius: 0 8px 8px 0;\">");
        html.append("        <p style=\"margin: 8px 0; color: #ccc;\">Mã Hợp Đồng: <strong style=\"color: #D4AF37; font-size: 18px;\">#").append(orderId).append("</strong></p>");
        html.append("        <p style=\"margin: 8px 0; color: #ccc;\">Cổng Thanh Toán: <strong>").append(paymentMethod).append("</strong></p>");
        html.append("        <p style=\"margin: 8px 0; color: #ccc;\">Trạng Thái: <strong style=\"color: #38ef7d;\">Đang chờ xử lý</strong></p>");
        html.append("    </div>");

        html.append("    <p style=\"line-height: 1.6; color: #ccc; font-size: 14px;\">Chuyên viên tư vấn của F-AUTO sẽ liên hệ với quý khách trong thời gian sớm nhất để hướng dẫn các thủ tục tiếp theo.</p>");
        html.append("    <hr style=\"border-color: #333; margin: 30px 0;\">");
        html.append("    <p style=\"font-size: 12px; color: #666; text-align: center; line-height: 1.5;\">Mọi thắc mắc xin vui lòng liên hệ Tổng đài CSKH: <b style=\"color: #D4AF37;\">0909.123.456</b></p>");
        html.append("    <p style=\"font-size: 12px; color: #444; text-align: center;\">&copy; 2026 F-AUTO Showroom. Tự hào đồng hành cùng bạn.</p>");
        html.append("</div>");
        return html.toString();
    }
}
