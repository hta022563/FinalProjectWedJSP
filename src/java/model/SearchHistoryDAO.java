package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

public class SearchHistoryDAO {

    public SearchHistoryDAO() {
    }

    // =========================================================================
    // 1. CREATE & UPDATE (Lưu từ khóa mới HOẶC cộng dồn số lần tìm kiếm)
    // =========================================================================
    public boolean saveOrUpdateSearch(String keyword) {
        String cleanKeyword = keyword.trim();
        if (cleanKeyword.isEmpty()) return false;

        String checkSql = "SELECT SearchID, SearchCount FROM SearchHistory WHERE Keyword = ?";
        String updateSql = "UPDATE SearchHistory SET SearchCount = SearchCount + 1 WHERE Keyword = ?";
        String insertSql = "INSERT INTO SearchHistory (Keyword, SearchCount) VALUES (?, 1)";

        try (Connection conn = DbUtils.getConnection()) {
            // Bước 1: Kiểm tra xem từ khóa đã tồn tại chưa
            try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
                checkPs.setString(1, cleanKeyword);
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        // NẾU ĐÃ CÓ: Chạy lệnh UPDATE (+1 số lần tìm)
                        try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                            updatePs.setString(1, cleanKeyword);
                            updatePs.executeUpdate();
                        }
                    } else {
                        // NẾU CHƯA CÓ: Chạy lệnh INSERT (Tạo mới)
                        try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                            insertPs.setString(1, cleanKeyword);
                            insertPs.executeUpdate();
                        }
                    }
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================================================================
    // 2. READ (Lấy Top các từ khóa hot nhất để làm gợi ý)
    // =========================================================================
    public List<SearchHistoryDTO> getTopSearches(int limit) {
        List<SearchHistoryDTO> list = new ArrayList<>();
        // Dùng lệnh TOP của SQL Server để lấy đúng số lượng cần thiết
        String sql = "SELECT TOP " + limit + " * FROM SearchHistory ORDER BY SearchCount DESC";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new SearchHistoryDTO(
                        rs.getInt("SearchID"),
                        rs.getString("Keyword"),
                        rs.getInt("SearchCount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // =========================================================================
    // 3. READ ALL (Dành cho Admin xem toàn bộ thống kê)
    // =========================================================================
    public List<SearchHistoryDTO> getAllSearches() {
        List<SearchHistoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM SearchHistory ORDER BY SearchCount DESC";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new SearchHistoryDTO(
                        rs.getInt("SearchID"),
                        rs.getString("Keyword"),
                        rs.getInt("SearchCount")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // =========================================================================
    // 4. DELETE (Xóa một từ khóa)
    // =========================================================================
    public boolean deleteSearch(int searchID) {
        String sql = "DELETE FROM SearchHistory WHERE SearchID = ?";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, searchID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}