package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils; 

public class ActivityDAO {

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

    public boolean clearAllLogs() {
        String sql = "TRUNCATE TABLE Activity_Logs"; 
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