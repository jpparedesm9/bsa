package com.cobis.cloud.lcr.b2b.service.dto;

public class RevolvingDocumentRequest {

	private int instanceProcess;
	private int instanceActivity;
	private String logginAsesor;
	private String statusInterested;
	private String catalogue;
	private String description;

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

	public String getLogginAsesor() {
		return logginAsesor;
	}

	public void setLogginAsesor(String logginAsesor) {
		this.logginAsesor = logginAsesor;
	}

	public String getStatusInterested() {
		return statusInterested;
	}

	public void setStatusInterested(String statusInterested) {
		this.statusInterested = statusInterested;
	}

	public String getCatalogue() {
		return catalogue;
	}

	public void setCatalogue(String catalogue) {
		this.catalogue = catalogue;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "RevolvingDocumentRequest [instanceProcess=" + instanceProcess + ", instanceActivity=" + instanceActivity + ", logginAsesor=" + logginAsesor + ", statusInterested=" + statusInterested + ", catalogue=" + catalogue + ", description=" + description + "]";
	}
	
	

}
