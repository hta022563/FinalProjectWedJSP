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
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PaymentMethodDTO method = new PaymentMethodDTO();
                method.setMethodID(rs.getInt("MethodID"));
                method.setMethodName(rs.getString("MethodName"));
                method.setIsActive(rs.getInt("IsActive"));
                list.add(method);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(String name) {
        String sql = "INSERT INTO PaymentMethod (MethodName, IsActive) VALUES (?, 1)";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(int id, String newName) {
        String sql = "UPDATE PaymentMethod SET MethodName = ? WHERE MethodID = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newName);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean softDelete(int id) {
        String sql = "UPDATE PaymentMethod SET IsActive = 0 WHERE MethodID = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<PaymentMethodDTO> getDeletedAll() {
        List<PaymentMethodDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM PaymentMethod WHERE IsActive = 0";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PaymentMethodDTO method = new PaymentMethodDTO();
                method.setMethodID(rs.getInt("MethodID"));
                method.setMethodName(rs.getString("MethodName"));
                method.setIsActive(rs.getInt("IsActive"));
                list.add(method);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean restore(int id) {
        String sql = "UPDATE PaymentMethod SET IsActive = 1 WHERE MethodID = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
