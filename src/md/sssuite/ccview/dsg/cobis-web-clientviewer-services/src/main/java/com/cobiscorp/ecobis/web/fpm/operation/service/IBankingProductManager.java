package com.cobiscorp.ecobis.web.fpm.operation.service;

import cobiscorp.ecobis.ucsp.request.dto.ProductsRulesFilteredRequest;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public interface IBankingProductManager {

	public ServiceResponse getBankinProductsStructure();
	
	public ServiceResponse getBankinProductsApprovedStructure();
	
	public ServiceResponse getBankinProductsRulesFiltered(ProductsRulesFilteredRequest request);
	
	public ServiceResponse getBankingProductBasicInformationById(String request);
	
	public ServiceResponse getBankingProductApprovedInformationById(String bankingProductId);

}
