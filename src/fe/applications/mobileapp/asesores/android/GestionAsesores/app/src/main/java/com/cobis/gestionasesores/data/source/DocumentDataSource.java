package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.ResultData;

import java.io.IOException;

public interface DocumentDataSource {

    ResultData saveDocument(int personId, DocumentsData data, @DocumentType String type) throws IOException;

    Document getDocument(int localPersonId, Document oldDocument) throws IOException;
}
