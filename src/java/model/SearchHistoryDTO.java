package model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "SearchHistoryDTO")
@Table(name = "SearchHistory")
public class SearchHistoryDTO implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SearchID")
    private int searchID;

    @Column(name = "Keyword")
    private String keyword;

    @Column(name = "SearchCount")
    private int searchCount = 1; // Mặc định khi mới tạo là tìm kiếm 1 lần

    // ==========================================
    // 1. HÀM KHỞI TẠO (CONSTRUCTORS)
    // ==========================================
    public SearchHistoryDTO() {
    }

    public SearchHistoryDTO(int searchID, String keyword, int searchCount) {
        this.searchID = searchID;
        this.keyword = keyword;
        this.searchCount = searchCount;
    }
    
    // Hàm khởi tạo tiện lợi khi chỉ cần truyền Keyword (Lần đầu tìm kiếm)
    public SearchHistoryDTO(String keyword) {
        this.keyword = keyword;
        this.searchCount = 1;
    }

    // ==========================================
    // 2. GETTER & SETTER
    // ==========================================
    public int getSearchID() {
        return searchID;
    }

    public void setSearchID(int searchID) {
        this.searchID = searchID;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getSearchCount() {
        return searchCount;
    }

    public void setSearchCount(int searchCount) {
        this.searchCount = searchCount;
    }
    
    // Hàm tiện ích để tự động tăng số lần tìm kiếm lên 1
    public void incrementCount() {
        this.searchCount++;
    }
}