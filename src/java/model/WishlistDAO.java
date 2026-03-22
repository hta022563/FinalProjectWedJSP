/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author AngDeng
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

public class WishlistDAO {

    public boolean add(int userId, int productId) {
        if (check(userId, productId)) return true;
        String sql = "INSERT INTO Wishlist(UserID, ProductID) VALUES(?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean remove(int userId, int productId) {
        String sql = "DELETE FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean check(int userId, int productId) {
        String sql = "SELECT 1 FROM Wishlist WHERE UserID = ? AND ProductID = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<Integer> getWishlistByUser(int userId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT ProductID FROM Wishlist WHERE UserID = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while(rs.next()) list.add(rs.getInt("ProductID"));
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }
}