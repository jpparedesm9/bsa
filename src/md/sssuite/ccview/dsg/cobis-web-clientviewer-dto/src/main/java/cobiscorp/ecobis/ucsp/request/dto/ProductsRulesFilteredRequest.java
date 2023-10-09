package cobiscorp.ecobis.ucsp.request.dto;

import java.io.Serializable;

public class ProductsRulesFilteredRequest implements Serializable {

	private Integer clientId;
	private String oficialId;

	
	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	public String getOficialId() {
		return oficialId;
	}

	public void setOficialId(String oficialId) {
		this.oficialId = oficialId;
	}

	
	
}
