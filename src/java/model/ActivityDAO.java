package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils; // Nhớ check lại import này xem đúng thư mục của Hảo chưa nhé

public class ActivityDAO {

    // ==========================================================
    // [C] CREATE - TẠO MỚI LOG (GHI VẾT)
    // ==========================================================
    public void logActivity(String type, String title, String createdBy, String refCode, Double amount) {
        String sql = "INSERT INTO Activity_Logs (log_type, title, created_by, reference_code, amount) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection();  
             PreparedStatement ps = conn.prepareStatement(sql)) {
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

    // ==========================================================
    // [R] READ - ĐỌC DỮ LIỆU LOG
    // ==========================================================
    
    // 1. Đọc N dòng mới nhất cho Dashboard
    public List<ActivityDTO> getRecentActivities(int topNumber) {
        List<ActivityDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Activity_Logs ORDER BY created_at DESC";

        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, topNumber);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ActivityDTO act = new ActivityDTO();
                    act.setLogId(rs.getInt("log_id"));
                    act.setType(rs.getString("log_type"));
                    act.setTitle(rs.getString("title"));
                    act.setCreatedBy(rs.getString("created_by"));
                    act.setCreatedAt(rs.getTimestamp("created_at"));
                    act.setReferenceCode(rs.getString("reference_code"));
                    
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

    // 2. Đọc TOÀN BỘ Log (Dành cho trang Quản lý Nhật ký)
    public List<ActivityDTO> getAllActivities() {
        List<ActivityDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Activity_Logs ORDER BY created_at DESC";

        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ActivityDTO act = new ActivityDTO();
                act.setLogId(rs.getInt("log_id"));
                act.setType(rs.getString("log_type"));
                act.setTitle(rs.getString("title"));
                act.setCreatedBy(rs.getString("created_by"));
                act.setCreatedAt(rs.getTimestamp("created_at"));
                act.setReferenceCode(rs.getString("reference_code"));
                
                if (rs.getObject("amount") != null) {
                    act.setAmount(rs.getDouble("amount"));
                }
                list.add(act);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ==========================================================
    // [U] UPDATE - CẬP NHẬT LOG 
    // (Lưu ý: Chỉ dùng cho Admin gỡ lỗi/cập nhật trạng thái)
    // ==========================================================
    public boolean updateActivity(int logId, String type, String title, String refCode, Double amount) {
        String sql = "UPDATE Activity_Logs SET log_type=?, title=?, reference_code=?, amount=? WHERE log_id=?";
        boolean isUpdated = false;
        
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, type);
            ps.setString(2, title);
            ps.setString(3, refCode);
            
            if (amount != null) {
                ps.setDouble(4, amount);
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
            }
            ps.setInt(5, logId);
            
            isUpdated = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }

    // ==========================================================
    // [D] DELETE - XÓA LOG
    // ==========================================================
    
    // 1. Xóa 1 dòng Log cụ thể
    public boolean deleteActivity(int logId) {
        String sql = "DELETE FROM Activity_Logs WHERE log_id=?";
        boolean isDeleted = false;
        
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, logId);
            isDeleted = ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDeleted;
    }

    // 2. Dọn dẹp toàn bộ Log (Tính năng Admin Reset Hệ thống)
    public boolean clearAllLogs() {
        String sql = "TRUNCATE TABLE Activity_Logs"; // Chạy cực nhanh so với DELETE
        boolean isCleared = false;
        
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.executeUpdate();
            isCleared = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCleared;
    }
}