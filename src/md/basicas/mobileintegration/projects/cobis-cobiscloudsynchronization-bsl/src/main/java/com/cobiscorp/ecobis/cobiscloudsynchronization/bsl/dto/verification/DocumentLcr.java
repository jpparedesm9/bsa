package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.verification;

public class DocumentLcr {

	private String code;
	private String name;
	private String classDoc;
	private String type;
	private String download;
	private String loaded;
	private String owner;

	public String getClassDoc() {
		return classDoc;
	}

	public void setClassDoc(String classDoc) {
		this.classDoc = classDoc;
	}

	public String getLoaded() {
		return loaded;
	}

	public void setLoaded(String loaded) {
		this.loaded = loaded;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDownload() {
		return download;
	}

	public void setDownload(String download) {
		this.download = download;
	}
	
	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

}
