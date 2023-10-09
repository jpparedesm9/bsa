package com.cobiscorp.ecobis.cloud.service.dto.client;

/**
 * @author Cesar Loachamin
 */
public class CustomerResult {

    private Integer customerId;
    private String curp;
    private String rfc;
    private Integer emailAddressId;

    public CustomerResult() {
    }

    public CustomerResult(Integer customerId, String curp, String rfc, Integer emailAddressId) {
        this.customerId = customerId;
        this.curp = curp;
        this.rfc = rfc;
        this.emailAddressId = emailAddressId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

	public Integer getEmailAddressId() {
		return emailAddressId;
	}

	public void setEmailAddressId(Integer emailAddressId) {
		this.emailAddressId = emailAddressId;
	}
}
