package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

public class DocumentsSynchronization {
    private String code;
    private String type;
    private boolean downloaded;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public boolean isDownloaded() {
        return downloaded;
    }

    public void setDownloaded(boolean downloaded) {
        this.downloaded = downloaded;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
