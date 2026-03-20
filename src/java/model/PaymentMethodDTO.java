package model;

import javax.persistence.*;

@Entity
@Table(name = "PaymentMethod")
public class PaymentMethodDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MethodID")
    private int methodID;

    @Column(name = "MethodName")
    private String methodName;

    @Column(name = "IsActive")
    private int isActive;

    @Column(name = "MethodCode")
    private String methodCode;

    @Column(name = "IconClass")
    private String iconClass;

    @Column(name = "Description")
    private String description;

    @Column(name = "BankName")
    private String bankName;

    @Column(name = "AccountNo")
    private String accountNo;

    @Column(name = "AccountName")
    private String accountName;

    @Column(name = "QRCodeURL")
    private String qrCodeURL;

    public PaymentMethodDTO() {
    }

    public int getMethodID() {
        return methodID;
    }

    public void setMethodID(int methodID) {
        this.methodID = methodID;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public String getMethodCode() {
        return methodCode;
    }

    public void setMethodCode(String methodCode) {
        this.methodCode = methodCode;
    }

    public String getIconClass() {
        return iconClass;
    }

    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getQrCodeURL() {
        return qrCodeURL;
    }

    public void setQrCodeURL(String qrCodeURL) {
        this.qrCodeURL = qrCodeURL;
    }
}
