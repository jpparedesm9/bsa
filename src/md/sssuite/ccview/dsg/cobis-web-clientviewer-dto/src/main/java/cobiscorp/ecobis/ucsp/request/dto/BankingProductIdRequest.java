package cobiscorp.ecobis.ucsp.request.dto;

import java.io.Serializable;

public class BankingProductIdRequest implements Serializable {
	
	private String bankingProductId;

	public BankingProductIdRequest(String bankingProductId) {
		this.bankingProductId = bankingProductId;
	}

	public String getBankingProductId() {
		return bankingProductId;
	}

	public void setBankingProductId(String bankingProductId) {
		this.bankingProductId = bankingProductId;
	}

}
