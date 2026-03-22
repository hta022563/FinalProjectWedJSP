package utils;

import java.security.MessageDigest;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;

public class SecurityUtils {
    

    public static String hashPassword(String plainPassword) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(plainPassword.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(hashBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null; 
        }
    }


    private static final String SECRET_KEY = "FAUTO_SECRET_KEY";


    public static String encrypt(String data) {
        if (data == null) return null;
        try {
            Key key = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encVal = cipher.doFinal(data.getBytes("UTF-8"));
            return bytesToHex(encVal); // Dùng Hex để lưu Cookie không bị lỗi ký tự
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static String decrypt(String encryptedData) {
        if (encryptedData == null) return null;
        try {
            Key key = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] decordedValue = hexToBytes(encryptedData);
            byte[] decValue = cipher.doFinal(decordedValue);
            return new String(decValue, "UTF-8");
        } catch (Exception e) {
            return null;
        }
    }


    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) { sb.append(String.format("%02x", b)); }
        return sb.toString();
    }

    private static byte[] hexToBytes(String hex) {
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
        }
        return bytes;
    }
}