package model;

import utils.DbUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO {

    public List<PromotionDTO> getAllActive() {
        List<PromotionDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotion WHERE IsActive = 1 ORDER BY EndDate DESC";
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new PromotionDTO(
                    rs.getInt("PromotionID"),
                    rs.getString("PromoCode"),
                    rs.getInt("DiscountPercent"),
                    rs.getDate("StartDate"),
                    rs.getDate("EndDate"),
                    rs.getInt("IsActive")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean insert(String code, int percent, Date startDate, Date endDate) {
        String sql = "INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndDate, IsActive) VALUES (?, ?, ?, ?, 1)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, percent);
            ps.setDate(3, startDate);
            ps.setDate(4, endDate);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(int id, String code, int percent, Date startDate, Date endDate) {
        String sql = "UPDATE Promotion SET PromoCode = ?, DiscountPercent = ?, StartDate = ?, EndDate = ? WHERE PromotionID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, percent);
            ps.setDate(3, startDate);
            ps.setDate(4, endDate);
            ps.setInt(5, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean softDelete(int id) {
        String sql = "UPDATE Promotion SET IsActive = 0 WHERE PromotionID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<PromotionDTO> getDeletedAll() {
        List<PromotionDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Promotion WHERE IsActive = 0";
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new PromotionDTO(
                    rs.getInt("PromotionID"),
                    rs.getString("PromoCode"),
                    rs.getInt("DiscountPercent"),
                    rs.getDate("StartDate"),
                    rs.getDate("EndDate"),
                    rs.getInt("IsActive")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean restore(int id) {
        String sql = "UPDATE Promotion SET IsActive = 1 WHERE PromotionID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    // Hàm này sẽ làm cái vạch đỏ trong CartController của sếp biến mất
    public PromotionDTO getPromotionByCode(String code) {
        String sql = "SELECT * FROM Promotion WHERE PromoCode = ? AND IsActive = 1";
        try (Connection conn = DbUtils.getConnection(); // <--- Đổi chỗ này nếu file kết nối DB của sếp tên khác
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PromotionDTO(
                        rs.getInt("PromotionID"),
                        rs.getString("PromoCode"),
                        rs.getInt("DiscountPercent"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getInt("IsActive")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
}