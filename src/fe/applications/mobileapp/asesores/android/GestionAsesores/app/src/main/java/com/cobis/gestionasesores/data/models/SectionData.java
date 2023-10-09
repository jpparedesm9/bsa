package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

public class SectionData<T extends SectionData> implements Serializable {
    public SectionData() {
    }

    public T merge(T data) {
        throw new RuntimeException("Operation Not implemented!!");
    }

    public boolean isComplete() {
        throw new RuntimeException("Operation Not implemented!!");
    }
}
