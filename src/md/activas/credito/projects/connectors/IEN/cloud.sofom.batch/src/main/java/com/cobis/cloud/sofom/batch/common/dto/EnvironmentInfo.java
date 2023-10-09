package com.cobis.cloud.sofom.batch.common.dto;

public class EnvironmentInfo {
    private String encryptionFolderPath;
    private String encryptionSoftwarePath;

    public EnvironmentInfo(String encryptionFolderPath, String encryptionSoftwarePath) {
        this.encryptionFolderPath = encryptionFolderPath;
        this.encryptionSoftwarePath = encryptionSoftwarePath;
    }

    public String getEncryptionFolderPath() {
        return encryptionFolderPath;
    }

    public void setEncryptionFolderPath(String encryptionFolderPath) {
        this.encryptionFolderPath = encryptionFolderPath;
    }

    public String getEncryptionSoftwarePath() {
        return encryptionSoftwarePath;
    }

    public void setEncryptionSoftwarePath(String encryptionSoftwarePath) {
        this.encryptionSoftwarePath = encryptionSoftwarePath;
    }
}
