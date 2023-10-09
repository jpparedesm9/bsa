package com.cobiscorp.mobile.request;

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
	
	private String ipLocal;
	private String idSesionCliente;

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

	@Override
	public String toString() {
		return "FingerPrintRequest [customerId=" + customerId + ", ocr=" + ocr + ", cic=" + cic + ", name=" + name
				+ ", paterName=" + paterName + ", maternName=" + maternName + ", registryYear=" + registryYear
				+ ", expeditionYear=" + expeditionYear + ", numCredEmission=" + numCredEmission + ", electoralKey="
				+ electoralKey + ", latitude=" + latitude + ", longitude=" + longitude + ", ipLocal=" + ipLocal
				+ ", idSesionCliente=" + idSesionCliente + "]";
	}

}
