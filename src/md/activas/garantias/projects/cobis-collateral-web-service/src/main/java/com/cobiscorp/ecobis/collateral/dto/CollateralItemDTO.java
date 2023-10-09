package com.cobiscorp.ecobis.collateral.dto;

import cobiscorp.ecobis.collateral.dto.CustodyInformation;
import cobiscorp.ecobis.collateral.dto.ItemsInformation;

public class CollateralItemDTO {

	private ItemsInformation itemsInformation;
	private CustodyInformation custodyInformation;
	private String mode;

	public CollateralItemDTO() {
	};

	public CollateralItemDTO(ItemsInformation itemsInformation, CustodyInformation custodyInformation, String mode) {
		super();
		this.itemsInformation = itemsInformation;
		this.custodyInformation = custodyInformation;
		this.mode = mode;
	}

	public ItemsInformation getItemsInformation() {
		return itemsInformation;
	}

	public void setItemsInformation(ItemsInformation itemsInformation) {
		this.itemsInformation = itemsInformation;
	}

	public CustodyInformation getCustodyInformation() {
		return custodyInformation;
	}

	public void setCustodyInformation(CustodyInformation custodyInformation) {
		this.custodyInformation = custodyInformation;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

}
