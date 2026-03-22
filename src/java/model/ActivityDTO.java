package model;

import java.sql.Timestamp;

public class ActivityDTO {

    private int logId;
    private String type;
    private String title;
    private String createdBy;
    private Timestamp createdAt;
    private String referenceCode;
    private Double amount;

    public ActivityDTO() {
    }

    public ActivityDTO(int logId, String type, String title, String createdBy, Timestamp createdAt, String referenceCode, Double amount) {
        this.logId = logId;
        this.type = type;
        this.title = title;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.referenceCode = referenceCode;
        this.amount = amount;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getReferenceCode() {
        return referenceCode;
    }

    public void setReferenceCode(String referenceCode) {
        this.referenceCode = referenceCode;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getTimeAgo() {
        if (this.createdAt == null) {
            return "";
        }

        long diffInMillis = System.currentTimeMillis() - this.createdAt.getTime();
        long diffInMinutes = diffInMillis / (60 * 1000);

        if (diffInMinutes < 1) {
            return "Vừa xong";
        } else if (diffInMinutes < 60) {
            return diffInMinutes + " phút trước";
        } else {
            long diffInHours = diffInMinutes / 60;
            if (diffInHours < 24) {
                return diffInHours + " giờ trước";
            } else {
                long diffInDays = diffInHours / 24;
                return diffInDays + " ngày trước";
            }
        }
    }
}
