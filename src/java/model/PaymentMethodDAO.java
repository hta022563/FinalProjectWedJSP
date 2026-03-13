package model;

import utils.DbUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentMethodDAO {

    public List<PaymentMethodDTO> getAllActive() {
        List<PaymentMethodDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM PaymentMethod WHERE IsActive = 1";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PaymentMethodDTO method = new PaymentMethodDTO();
                method.setMethodID(rs.getInt("MethodID"));
                method.setMethodName(rs.getString("MethodName"));
                method.setIsActive(rs.getInt("IsActive"));
                // --- Bổ sung các cột mới ---
                method.setMethodCode(rs.getString("MethodCode"));
                method.setIconClass(rs.getString("IconClass"));
                method.setDescription(rs.getString("Description"));
                method.setBankName(rs.getString("BankName"));
                method.setAccountNo(rs.getString("AccountNo"));
                method.setAccountName(rs.getString("AccountName"));
                method.setQrCodeURL(rs.getString("QRCodeURL"));
                list.add(method);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean insert(String name, String code, String icon, String desc, String bank, String accNo, String accName, String qr) {
        String sql = "INSERT INTO PaymentMethod (MethodName, IsActive, MethodCode, IconClass, Description, BankName, AccountNo, AccountName, QRCodeURL) VALUES (?, 1, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, code);
            ps.setString(3, icon);
            ps.setString(4, desc);
            ps.setString(5, bank);
            ps.setString(6, accNo);
            ps.setString(7, accName);
            ps.setString(8, qr);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(int id, String name, String code, String icon, String desc, String bank, String accNo, String accName, String qr) {
        String sql = "UPDATE PaymentMethod SET MethodName=?, MethodCode=?, IconClass=?, Description=?, BankName=?, AccountNo=?, AccountName=?, QRCodeURL=? WHERE MethodID=?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, code);
            ps.setString(3, icon);
            ps.setString(4, desc);
            ps.setString(5, bank);
            ps.setString(6, accNo);
            ps.setString(7, accName);
            ps.setString(8, qr);
            ps.setInt(9, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean softDelete(int id) {
        String sql = "UPDATE PaymentMethod SET IsActive = 0 WHERE MethodID = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<PaymentMethodDTO> getDeletedAll() {
        List<PaymentMethodDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM PaymentMethod WHERE IsActive = 0";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PaymentMethodDTO method = new PaymentMethodDTO();
                method.setMethodID(rs.getInt("MethodID"));
                method.setMethodName(rs.getString("MethodName"));
                method.setIsActive(rs.getInt("IsActive"));
                list.add(method);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean restore(int id) {
        String sql = "UPDATE PaymentMethod SET IsActive = 1 WHERE MethodID = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}