package com.cobis.gestionasesores.data.models.requests;

import java.util.List;

public class CustomerDocumentsRemote {
    public List<Document> getDocument() {
        return document;
    }

    public void setDocument(List<Document> document) {
        this.document = document;
    }

    private List<Document> document;

    public static class Document {
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

        private String code;
        private boolean downloaded;
        private String type;
    }
}
