package com.cobiscorp.ecobis.cloud.service.dto.common;

import java.util.List;

import cobiscorp.ecobis.admin.catalog.dto.CatalogoReq;

public class CatalogRequestList {
	

	List<CatalogoReq> catalogRequestList;

	public List<CatalogoReq> getCatalogRequestList() {
		return catalogRequestList;
	}

	public void setCatalogRequestList(List<CatalogoReq> catalogRequestList) {
		this.catalogRequestList = catalogRequestList;
	}

}
