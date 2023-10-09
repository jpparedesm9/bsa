package com.cobis.cloud.lcr.b2b.service.dto;

import com.cobis.cloud.lcr.b2b.service.utils.Constants;

public class RevolvingUpdateDocumentRequest {

	private String code; // Codigo de la imagen que se envio en la sincronizacion
	private String nameDocument; // Nombre de la imagen que se envio en la sincronización
	private String typeDocument; // Es la extencion del documento que se subio desde la movil
	private String nameOriginalDoc; // Nombre original del documento que se subio
	private String category; // La categoria que se envio en la trama de sincronizacion
	private String owner; // Donde se guarda el documento: Inbox/Customer

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getNameDocument() {
		return nameDocument;
	}

	public void setNameDocument(String nameDocument) {
		this.nameDocument = nameDocument;
	}

	public String getTypeDocument() {
		return typeDocument;
	}

	public void setTypeDocument(String typeDocument) {
		this.typeDocument = typeDocument;
	}

	public String getNameOriginalDoc() {
		return nameOriginalDoc;
	}

	public void setNameOriginalDoc(String nameOriginalDoc) {
		this.nameOriginalDoc = nameOriginalDoc;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getOwner() {
		if (owner == null || "".equals(owner)) {
			return Constants.OWNER_INBOX;
		}
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

}
