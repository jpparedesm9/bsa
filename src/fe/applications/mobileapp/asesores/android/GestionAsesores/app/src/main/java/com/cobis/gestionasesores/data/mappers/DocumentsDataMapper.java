package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.requests.CustomerDocumentsRemote;
import com.cobis.gestionasesores.data.models.responses.CustomerEntity;
import com.cobis.gestionasesores.utils.Util;

import java.io.File;

/**
 * Created by Jose on 11/10/2017.
 */

public class DocumentsDataMapper {

    public static DocumentsData toDocumentsData(CustomerEntity entity){
        DocumentsData sectionData = DocumentsData.createInstance();
        for (CustomerDocumentsRemote.Document document : entity.getDocuments().getDocument()) {
            if (document.isDownloaded()) {
                String path = Util.getDocumentPath(document.getCode(), document.getType());
                sectionData.getDocumentByCode(document.getCode()).setImage(path);
                sectionData.getDocumentByCode(document.getCode()).setExtension(document.getType());
                sectionData.getDocumentByCode(document.getCode()).setStatus(SyncStatus.SYNCED);
                File file = new File(path);
                if (file.exists()) {
                    file.delete();
                }
            } else {
                sectionData.getDocumentByCode(document.getCode()).setStatus(SyncStatus.UNKNOWN);
            }
        }
        return sectionData;
    }
}
