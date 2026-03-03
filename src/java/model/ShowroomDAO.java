package model;

import utils.DbUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ShowroomDAO {

    public List<ShowroomDTO> getAllActive() {
        List<ShowroomDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Showroom WHERE IsActive = 1";
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ShowroomDTO(
                    rs.getInt("ShowroomID"), rs.getString("ShowroomName"),
                    rs.getString("Address"), rs.getString("Hotline"), rs.getInt("IsActive")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean insert(String name, String address, String hotline) {
        String sql = "INSERT INTO Showroom (ShowroomName, Address, Hotline, IsActive) VALUES (?, ?, ?, 1)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, hotline);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(int id, String name, String address, String hotline) {
        String sql = "UPDATE Showroom SET ShowroomName = ?, Address = ?, Hotline = ? WHERE ShowroomID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, hotline);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean softDelete(int id) {
        String sql = "UPDATE Showroom SET IsActive = 0 WHERE ShowroomID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public List<ShowroomDTO> getDeletedAll() {
        List<ShowroomDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Showroom WHERE IsActive = 0";
        try (Connection conn = DbUtils.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ShowroomDTO(
                    rs.getInt("ShowroomID"), rs.getString("ShowroomName"),
                    rs.getString("Address"), rs.getString("Hotline"), rs.getInt("IsActive")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean restore(int id) {
        String sql = "UPDATE Showroom SET IsActive = 1 WHERE ShowroomID = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}