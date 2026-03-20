package model;

import utils.DbUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {

    public List<SupplierDTO> getAllActive() {
        List<SupplierDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Supplier WHERE IsActive = 1";
        
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                SupplierDTO supplier = new SupplierDTO();
                supplier.setSupplierID(rs.getInt("SupplierID"));
                supplier.setSupplierName(rs.getString("SupplierName"));
                supplier.setPhone(rs.getString("Phone"));
                supplier.setAddress(rs.getString("Address"));
                supplier.setIsActive(rs.getInt("IsActive"));
                list.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(String name, String phone, String address) {
        String sql = "INSERT INTO Supplier (SupplierName, Phone, Address, IsActive) VALUES (?, ?, ?, 1)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(int id, String newName, String newPhone, String newAddress) {
        String sql = "UPDATE Supplier SET SupplierName = ?, Phone = ?, Address = ? WHERE SupplierID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newName);
            ps.setString(2, newPhone);
            ps.setString(3, newAddress);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean softDelete(int id) {
        String sql = "UPDATE Supplier SET IsActive = 0 WHERE SupplierID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<SupplierDTO> getDeletedAll() {
        List<SupplierDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Supplier WHERE IsActive = 0";
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                SupplierDTO supplier = new SupplierDTO();
                supplier.setSupplierID(rs.getInt("SupplierID"));
                supplier.setSupplierName(rs.getString("SupplierName"));
                supplier.setPhone(rs.getString("Phone"));
                supplier.setAddress(rs.getString("Address"));
                supplier.setIsActive(rs.getInt("IsActive"));
                list.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean restore(int id) {
        String sql = "UPDATE Supplier SET IsActive = 1 WHERE SupplierID = ?";
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