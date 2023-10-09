package com.cobiscorp.ecobis.cloud.service;

import javax.ws.rs.core.Response;

public interface CatalogService {

	public Response getTermByFrecuency(String frecuency);

	public Response getCatalogByName(String catalogName);

	public Response getCatalogByListName(String[] catalogNameList);

	public Response getSyncronyzedTable();

	public Response getPaymentFrequency();
}
