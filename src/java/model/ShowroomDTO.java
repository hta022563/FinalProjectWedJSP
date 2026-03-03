package model;

public class ShowroomDTO {

    private int showroomID;
    private String showroomName;
    private String address;
    private String hotline;
    private int isActive;

    public ShowroomDTO() {
    }

    public ShowroomDTO(int showroomID, String showroomName, String address, String hotline, int isActive) {
        this.showroomID = showroomID;
        this.showroomName = showroomName;
        this.address = address;
        this.hotline = hotline;
        this.isActive = isActive;
    }

    // Getters và Setters
    public int getShowroomID() {
        return showroomID;
    }

    public void setShowroomID(int showroomID) {
        this.showroomID = showroomID;
    }

    public String getShowroomName() {
        return showroomName;
    }

    public void setShowroomName(String showroomName) {
        this.showroomName = showroomName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
}
