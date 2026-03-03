package model;

public class PaymentMethodDTO {

    private int methodID;
    private String methodName;
    private int isActive;

    public PaymentMethodDTO() {
    }

    public PaymentMethodDTO(int methodID, String methodName, int isActive) {
        this.methodID = methodID;
        this.methodName = methodName;
        this.isActive = isActive;
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
}
