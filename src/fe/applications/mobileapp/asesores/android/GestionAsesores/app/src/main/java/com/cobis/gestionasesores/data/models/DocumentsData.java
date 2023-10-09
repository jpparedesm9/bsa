package com.cobis.gestionasesores.data.models;

import android.annotation.SuppressLint;

import com.cobis.gestionasesores.data.enums.DocumentType;

import java.util.ArrayList;
import java.util.List;

public class DocumentsData extends SectionData<DocumentsData> {
    private List<Document> documents;

    public DocumentsData() {
        documents = new ArrayList<>();
    }

    @Override
    public DocumentsData merge(DocumentsData data) {
        // this will add new doc type data to existing document list that does not have them, IF parameter data has document types that this instance does not
        for (Document newDoc : data.documents) {
            boolean hasIt = false;
            for (Document oldDoc : this.documents) {
                if (newDoc.getType().equalsIgnoreCase(oldDoc.getType())) {
                    hasIt = true;
                    break;
                }
            }
            if (!hasIt) {
                documents.add(newDoc);
            }
        }
        return this;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;
        if (documents == null || documents.isEmpty()) {
            isComplete = false;
        } else {
            for (Document document : documents) {
                if (!document.isComplete()) {
                    isComplete = false;
                }
            }
        }

        return isComplete;
    }

    public Document getDocumentByType(@DocumentType String type) {
        for (Document document : documents) {
            if (type.equals(document.getType())) {
                return document;
            }
        }
        return null;
    }

    public DocumentsData(List<Document> documents) {
        this.documents = documents;
    }

    public List<Document> getDocuments() {
        return documents;
    }

    public void setDocuments(List<Document> documents) {
        this.documents = documents;
    }

    @SuppressLint("WrongConstant")
    public void replaceDocument(Document document) {
        int index = documents.indexOf(document);
        if (index >= 0) {
            documents.set(index, document);
        } else {
            throw new RuntimeException("Document not exits: " + document.getType());
        }
    }

    public static DocumentsData createInstance() {
        List<Document> documents = new ArrayList<>();
        documents.add(new Document.Builder(DocumentType.FRONT_IDENTIFICATION).build());
        documents.add(new Document.Builder(DocumentType.BACK_IDENTIFICATION).build());
        documents.add(new Document.Builder(DocumentType.PROOF_ADDRESS).build());
        documents.add(new Document.Builder(DocumentType.SHORT_REQUEST).build());
        return new DocumentsData(documents);
    }

    public Document getDocumentByCode(String code) {
        Document _ret = null;
        for (Document d : documents) {
            if (d.getType().equals(code)) {
                _ret = d;
            }
        }
        // This will add a document with type existing in the server, but is not created automatically for all customers since the update
        if (_ret == null) {
            _ret = new Document.Builder(code).build();
            documents.add(_ret);
        }
        return _ret;
    }
}