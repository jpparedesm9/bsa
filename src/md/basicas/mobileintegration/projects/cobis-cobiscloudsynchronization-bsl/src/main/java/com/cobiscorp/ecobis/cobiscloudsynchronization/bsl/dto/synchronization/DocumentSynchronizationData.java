package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import java.util.List;

public class DocumentSynchronizationData {

    List<DocumentsSynchronization> document;

    public List<DocumentsSynchronization> getDocument() {
        return document;
    }

    public void setDocument(List<DocumentsSynchronization> document) {
        this.document = document;
    }
}
