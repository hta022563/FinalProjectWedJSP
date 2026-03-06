package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ActivityDTO;
import utils.DbUtils;

public class ActivityDAO {

    // Hàm lấy N giao dịch/hoạt động mới nhất
    public List<ActivityDTO> getRecentActivities(int topNumber) {
        List<ActivityDTO> list = new ArrayList<>();
        // Lấy dữ liệu mới nhất đưa lên đầu (ORDER BY DESC)
        String sql = "SELECT TOP (?) * FROM Activity_Logs ORDER BY created_at DESC";

        try ( Connection conn = DbUtils.getConnection(); // Chỉnh lại hàm lấy connection theo project của Hảo
                  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, topNumber);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ActivityDTO act = new ActivityDTO();
                    act.setLogId(rs.getInt("log_id"));
                    act.setType(rs.getString("log_type"));
                    act.setTitle(rs.getString("title"));
                    act.setCreatedBy(rs.getString("created_by"));
                    act.setCreatedAt(rs.getTimestamp("created_at"));
                    act.setReferenceCode(rs.getString("reference_code"));

                    // Xử lý cột Decimal có thể bị NULL
                    if (rs.getObject("amount") != null) {
                        act.setAmount(rs.getDouble("amount"));
                    }

                    list.add(act);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm này để Admin ghi log mới vào hệ thống
    public void logActivity(String type, String title, String createdBy, String refCode, Double amount) {
        String sql = "INSERT INTO Activity_Logs (log_type, title, created_by, reference_code, amount) VALUES (?, ?, ?, ?, ?)";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, type);
            ps.setString(2, title);
            ps.setString(3, createdBy);
            ps.setString(4, refCode);
            if (amount != null) {
                ps.setDouble(5, amount);
            } else {
                ps.setNull(5, java.sql.Types.DECIMAL);
            }
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
