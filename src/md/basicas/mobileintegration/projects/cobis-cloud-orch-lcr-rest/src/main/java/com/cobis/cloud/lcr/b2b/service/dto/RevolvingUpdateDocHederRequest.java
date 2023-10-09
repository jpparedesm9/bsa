package com.cobis.cloud.lcr.b2b.service.dto;

import java.util.List;

public class RevolvingUpdateDocHederRequest {

	private int instanceProcess; // Es al instancia de proceso que se envio en la sincronizacion
	private int instanceActivity; // Es la instancia de la actividada que se envio en la sincronizacion
	private List<RevolvingUpdateDocumentRequest> documents; // Es una lista del envio de documentos

	public int getInstanceProcess() {
		return instanceProcess;
	}

	public void setInstanceProcess(int instanceProcess) {
		this.instanceProcess = instanceProcess;
	}

	public int getInstanceActivity() {
		return instanceActivity;
	}

	public void setInstanceActivity(int instanceActivity) {
		this.instanceActivity = instanceActivity;
	}

	public List<RevolvingUpdateDocumentRequest> getDocuments() {
		return documents;
	}

	public void setDocuments(List<RevolvingUpdateDocumentRequest> updateDocument) {
		this.documents = updateDocument;
	}

	@Override
	public String toString() {
		return "RevolvingUpdateDocHederRequest [instanceProcess=" + instanceProcess + ", instanceActivity=" + instanceActivity + ", updateDocument=" + documents + "]";
	}

}
