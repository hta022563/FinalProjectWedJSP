package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ProductCategoryDTO;
// Thay đổi theo package của bạn
import utils.DbUtils;

public class ProductCategoryDAO {

    // 1. Lấy tất cả danh mục
    public List<ProductCategoryDTO> getAll() {
        List<ProductCategoryDTO> list = new ArrayList<>();
        // Thêm điều kiện WHERE IsActive = 1 để chỉ lấy những danh mục chưa bị ẩn
        String sql = "SELECT * FROM Category WHERE IsActive = 1";

        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductCategoryDTO category = new ProductCategoryDTO();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm mới danh mục
    public boolean insert(String categoryName) {
        String sql = "INSERT INTO Category (CategoryName) VALUES (?)";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, categoryName);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        // Đổi câu lệnh từ DELETE sang UPDATE: Set IsActive = 0 để Ẩn
        String sql = "UPDATE Category SET IsActive = 0 WHERE CategoryID = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // Cập nhật tên danh mục
    public boolean update(int id, String newName) {
        String sql = "UPDATE Category SET CategoryName = ? WHERE CategoryID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newName);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // Lấy danh sách các danh mục ĐÃ BỊ XÓA (IsActive = 0)
    public List<ProductCategoryDTO> getDeletedAll() {
        List<ProductCategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE IsActive = 0";
        
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductCategoryDTO category = new ProductCategoryDTO();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Khôi phục danh mục (Set IsActive = 1)
    public boolean restore(int id) {
        String sql = "UPDATE Category SET IsActive = 1 WHERE CategoryID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
