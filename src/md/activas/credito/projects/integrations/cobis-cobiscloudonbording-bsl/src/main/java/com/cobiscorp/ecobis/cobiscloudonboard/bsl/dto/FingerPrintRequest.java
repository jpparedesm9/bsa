package com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto;

public class FingerPrintRequest {
	private String customerId;
	private String ocr;
	private String cic;
	private String name;
	private String paterName;
	private String maternName;
	private String registryYear;
	private String expeditionYear;
	private String numCredEmission;
	private String electoralKey;
	private String latitude;
	private String longitude;	
	private String branch;
	private String transactionType;
	private String channel;
	private String transactionId;
	
	private String ipLocal;
	private String idSesionCliente;
	private String tokenToValid;
	private String urlWebView;

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getOcr() {
		return ocr;
	}

	public void setOcr(String ocr) {
		this.ocr = ocr;
	}

	public String getCic() {
		return cic;
	}

	public void setCic(String cic) {
		this.cic = cic;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPaterName() {
		return paterName;
	}

	public void setPaterName(String paterName) {
		this.paterName = paterName;
	}

	public String getMaternName() {
		return maternName;
	}

	public void setMaternName(String maternName) {
		this.maternName = maternName;
	}

	public String getRegistryYear() {
		return registryYear;
	}

	public void setRegistryYear(String registryYear) {
		this.registryYear = registryYear;
	}

	public String getExpeditionYear() {
		return expeditionYear;
	}

	public void setExpeditionYear(String expeditionYear) {
		this.expeditionYear = expeditionYear;
	}

	public String getNumCredEmission() {
		return numCredEmission;
	}

	public void setNumCredEmission(String numCredEmission) {
		this.numCredEmission = numCredEmission;
	}

	public String getElectoralKey() {
		return electoralKey;
	}

	public void setElectoralKey(String electoralKey) {
		this.electoralKey = electoralKey;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}
	
	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	

	public String getIpLocal() {
		return ipLocal;
	}

	public void setIpLocal(String ipLocal) {
		this.ipLocal = ipLocal;
	}

	public String getIdSesionCliente() {
		return idSesionCliente;
	}

	public void setIdSesionCliente(String idSesionCliente) {
		this.idSesionCliente = idSesionCliente;
	}

	public String getTokenToValid() {
		return tokenToValid;
	}

	public void setTokenToValid(String tokenToValid) {
		this.tokenToValid = tokenToValid;
	}

	public String getUrlWebView() {
		return urlWebView;
	}

	public void setUrlWebView(String urlWebView) {
		this.urlWebView = urlWebView;
	}

	public String toString2() {
		StringBuilder builder = new StringBuilder();
		builder.append("FingerPrintRequest [customerId=");
		builder.append(customerId);
		builder.append(", tokenToValid=");
		builder.append(tokenToValid);
		builder.append(", idSesionCliente=");
		builder.append(idSesionCliente);
		builder.append(", ipLocal=");
		builder.append(ipLocal);
		builder.append(", urlWebView=");
		builder.append(urlWebView);
		builder.append("]");
		return builder.toString();
	}
	
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("FingerPrintRequest [customerId=");
		builder.append(customerId);
		builder.append(", ocr=");
		builder.append(ocr);
		builder.append(", cic=");
		builder.append(cic);
		builder.append(", name=");
		builder.append(name);
		builder.append(", paterName=");
		builder.append(paterName);
		builder.append(", maternName=");
		builder.append(maternName);
		builder.append(", registryYear=");
		builder.append(registryYear);
		builder.append(", expeditionYear=");
		builder.append(expeditionYear);
		builder.append(", numCredEmission=");
		builder.append(numCredEmission);
		builder.append(", electoralKey=");
		builder.append(electoralKey);
		builder.append(", latitude=");
		builder.append(latitude);
		builder.append(", longitude=");
		builder.append(longitude);
		
		builder.append(", idSesionCliente=");
		builder.append(idSesionCliente);
		builder.append(", ipLocal=");
		builder.append(ipLocal);
		
		builder.append("]");
		return builder.toString();
	}

}
