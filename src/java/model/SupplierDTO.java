package model;

public class SupplierDTO {

    private int supplierID;
    private String supplierName;
    private String phone;
    private String address;
    private int isActive; 

    public SupplierDTO() {
    }

    public SupplierDTO(int supplierID, String supplierName, String phone, String address, int isActive) {
        this.supplierID = supplierID;
        this.supplierName = supplierName;
        this.phone = phone;
        this.address = address;
        this.isActive = isActive;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
}
