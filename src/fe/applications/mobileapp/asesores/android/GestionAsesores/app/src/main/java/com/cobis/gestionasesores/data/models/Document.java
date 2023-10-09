package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.enums.SyncStatus;

import java.io.Serializable;

/**
 * Created by mnaunay on 14/06/2017.
 */

public final class Document implements Serializable {
    @DocumentType
    private String type;
    private String extension;
    private Long captureDate;
    private Long expirationDate;
    private String image;
    private int status;

    public Document(String type, Long expirationDate, String image) {
        this.type = type;
        this.expirationDate = expirationDate;
        this.image = image;
        this.status = SyncStatus.UNKNOWN;
    }

    @DocumentType
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Long expirationDate) {
        this.expirationDate = expirationDate;
    }

    public Long getCaptureDate() {
        return captureDate;
    }

    public void setCaptureDate(Long captureDate) {
        this.captureDate = captureDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Document document = (Document) o;

        return type != null ? type.equals(document.type) : document.type == null;
    }

    @Override
    public int hashCode() {
        return type != null ? type.hashCode() : 0;
    }

    public boolean isComplete() {
        boolean isComplete = true;

        if (isEditable() && StringUtils.isEmpty(image)) {
            isComplete = false;
        }

        return isComplete;
    }

    public static class Builder {
        private String mType;

        public Builder(String mType) {
            this.mType = mType;
        }

        public Document build() {
            Document document = new Document(mType, null, null);
            return document;
        }
    }

    public boolean isEditable() {
        switch (type) {
            case DocumentType.NOTICE_PRIVACY:
            case DocumentType.AUTHORIZATION:
                return false;
            default:
                return true;
        }
    }
}
