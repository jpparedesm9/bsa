package com.cobiscorp.mobile.request;

import java.util.List;

public class LifeInsuranceResquest {

	private int tramiteId;
	private int clientId;
	private List<BeneficiaryLifeInsuranceRequest> listBeneficiary;
	private int accept;
	private int otorgo;
	private String biometricCode;

	public List<BeneficiaryLifeInsuranceRequest> getListBeneficiary() {
		return listBeneficiary;
	}

	public void setListBeneficiary(List<BeneficiaryLifeInsuranceRequest> listBeneficiary) {
		this.listBeneficiary = listBeneficiary;
	}

	public String getBiometricCode() {
		return biometricCode;
	}

	public void setBiometricCode(String biometricCode) {
		this.biometricCode = biometricCode;
	}
	


	public int getTramiteId() {
		return tramiteId;
	}

	public void setTramiteId(int tramiteId) {
		this.tramiteId = tramiteId;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}



	public int getAccept() {
		return accept;
	}

	public void setAccept(int accept) {
		this.accept = accept;
	}

	public int getOtorgo() {
		return otorgo;
	}

	public void setOtorgo(int otorgo) {
		this.otorgo = otorgo;
	}

	@Override
	public String toString() {
		return "LifeInsuranceResquest [tramiteId=" + tramiteId + ", clientId=" + clientId + ", listBeneficiary=" + listBeneficiary
				+ ",accept=" + accept +", otorgo=" + otorgo + ", biometricCode=" + biometricCode + "]";
	}
}
