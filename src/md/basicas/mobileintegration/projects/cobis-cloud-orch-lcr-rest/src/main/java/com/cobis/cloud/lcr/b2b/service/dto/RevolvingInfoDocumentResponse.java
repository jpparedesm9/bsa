package com.cobis.cloud.lcr.b2b.service.dto;

import java.util.List;

public class RevolvingInfoDocumentResponse {

	private int instanceActivity; // Se recupera la instancia de actividad
	private String nameActivity; // Se recupera el nombre de la actividad que se encuentra
	private String continueActivity; // Se coloca el valor SI / NO si la actividad continua o no
	private String processSubject; // Nombre del tipo de solicitud
	private int processInstanceIdentifier; // Se obtiene la instancia de proceso
	private String rol; // Se obtiene el rol que hace el pedido
	private List<RevolvingDocumentResponse> documents; // Es una lista donde se encuentra la informacion de los documentos que estan
														// subidos

	public int getInstanceActivity() {
		return instanceActivity;
	}

	public void setInstanceActivity(int instanceActivity) {
		this.instanceActivity = instanceActivity;
	}

	public String getNameActivity() {
		return nameActivity;
	}

	public void setNameActivity(String nameActivity) {
		this.nameActivity = nameActivity;
	}

	public String getContinueActivity() {
		return continueActivity;
	}

	public void setContinueActivity(String continueActivity) {
		this.continueActivity = continueActivity;
	}

	public String getProcessSubject() {
		return processSubject;
	}

	public void setProcessSubject(String processSubject) {
		this.processSubject = processSubject;
	}

	public int getProcessInstanceIdentifier() {
		return processInstanceIdentifier;
	}

	public void setProcessInstanceIdentifier(int processInstanceIdentifier) {
		this.processInstanceIdentifier = processInstanceIdentifier;
	}

	public List<RevolvingDocumentResponse> getDocuments() {
		return documents;
	}

	public void setDocuments(List<RevolvingDocumentResponse> documents) {
		this.documents = documents;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	@Override
	public String toString() {
		return "RevolvingInfoDocumentResponse [instanceActivity=" + instanceActivity + ", nameActivity=" + nameActivity + ", continueActivity=" + continueActivity + ", processSubject=" + processSubject + ", processInstanceIdentifier=" + processInstanceIdentifier + ", rol=" + rol + ", documents=" + documents + "]";
	}

}
