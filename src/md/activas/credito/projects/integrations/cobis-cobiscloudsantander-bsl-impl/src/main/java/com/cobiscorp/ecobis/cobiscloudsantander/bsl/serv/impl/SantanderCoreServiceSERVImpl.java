
/**
 * Archivo: SantanderCoreService.java
 * Fecha..: 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.IDisbursement;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.AccountForDisbursementInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.SearchAccountForDisbursementInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.CustomerInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.Product;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerProduct;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.SearchCustomerInfo;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.UpdateCustomerInfoRequest;
//include imports with key: SantanderCoreService.imports
import com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService;
import com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest;

//include imports with key: SantanderCoreService.imports

public class SantanderCoreServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ISantanderCoreService {
	private static ILogger logger = LogFactory.getLogger(SantanderCoreServiceSERVImpl.class);
	private static final ILogger LOGGER = LogFactory.getLogger(SantanderCoreServiceSERVImpl.class);

	// include body with key: SantanderCoreService.body
	private static final String BANK_ACCOUNT_COLUMN = "COLUMN91";
	private static final String BUC_COLUMN = "COLUMN94";
	private static final String STATUS_COLUMN = "COLUMN95";

	private ICustomerService customerService;
	private IDisbursement disbursement;

	public void setCustomerService(ICustomerService customerService) {
		this.customerService = customerService;
	}

	public ICustomerService getCustomerService() {
		return this.customerService;
	}

	public void setDisbursement(IDisbursement disbursement) {
		this.disbursement = disbursement;
	}

	public IDisbursement getDisbursement() {
		return this.disbursement;
	}

	private SearchAccountForDisbursementInfo fillSearchAccountForDisbursementInfo(SantanderRequest santanderRequest) {
		SearchAccountForDisbursementInfo searchAccountForDisbursementInfo = new SearchAccountForDisbursementInfo();
		SearchCustomerInfo searchCustomerInfo = santanderRequest.getSearchCustomerInfo();
		Name name = searchCustomerInfo.getName();

		searchAccountForDisbursementInfo.setRfc(name.getRfc());

		searchAccountForDisbursementInfo.setName(name.getFirstName());
		searchAccountForDisbursementInfo.setFirstLastName(name.getFatherLastName());
		searchAccountForDisbursementInfo.setSecondLastName(name.getMotherLastName());
		searchAccountForDisbursementInfo.setDateOfBirth(searchCustomerInfo.getDateOfBirth());

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("searchAccountForDisbursementInfo:" + searchAccountForDisbursementInfo);
		}
		return searchAccountForDisbursementInfo;

	}

	private ConnectionInfo fillConnectionInfo() {
		ConnectionInfo connectionInfo = new ConnectionInfo();
		String URLSAN = getCobisParameter().getParameter(null, "CRE", "URLSA1", String.class) + "" + getCobisParameter().getParameter(null, "CRE", "URLSA2", String.class) + ""
				+ getCobisParameter().getParameter(null, "CRE", "URLSA3", String.class);
		LOGGER.logDebug("URLSAN..." + URLSAN);

		String IDCSAN = getCobisParameter().getParameter(null, "CRE", "IDCSA1", String.class) + "" + getCobisParameter().getParameter(null, "CRE", "IDCSA2", String.class);
		LOGGER.logDebug("IDCSAN..." + IDCSAN);
		LOGGER.logDebug("SECSAN..." + getCobisParameter().getParameter(null, "CRE", "SECSAN", String.class));

		connectionInfo.setBaseUrl(URLSAN);
		connectionInfo.setClientId(IDCSAN);
		connectionInfo.setClientSecret(getCobisParameter().getParameter(null, "CRE", "SECSAN", String.class));
		return connectionInfo;
	}

	private boolean isSantanderSimulated() {
		Integer simulate = getCobisParameter().getParameter(null, "CRE", "SIMSAN", Long.class).intValue();
		LOGGER.logDebug("valor SIMSAN>>" + simulate);
		return (simulate == 1);
	}

	private CustomerCoreInfo fillCustomerCoreInfoSimulated() {
		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		customerCoreInfo.setBuc("12345678");
		customerCoreInfo.setCustomerStdCode("12345678");
		customerCoreInfo.setCustomerAccountId("12345678901");
		customerCoreInfo.setStatus("CLI");
		return customerCoreInfo;

	}

	private CustomerCoreInfo fillCustomerCoreInfoSimulated(Integer customerId) {
		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		customerCoreInfo.setBuc("12345678");
		customerCoreInfo.setCustomerStdCode("12345678");
		customerCoreInfo.setCustomerAccountId("12345678901");
		customerCoreInfo.setStatus("CLI");

		LOGGER.logDebug("size products list..." + fillCustomerProductListSimulated(customerId, customerCoreInfo.getCustomerAccountId()).size());
		customerCoreInfo.setProductList(fillCustomerProductListSimulated(customerId, customerCoreInfo.getCustomerAccountId()));
		return customerCoreInfo;

	}

	private List<CustomerProduct> fillCustomerProductListSimulated(Integer customerid, String contractNumber) {
		List<CustomerProduct> customerProductList = new ArrayList<CustomerProduct>();

		CustomerProduct customerProduct;
		for (int i = 1; i <= 5; i++) {

			customerProduct = new CustomerProduct();
			customerProduct.setCustomerId(customerid);
			customerProduct.setProductId("01");
			customerProduct.setSubproductId("0025");
			customerProduct.setCurrencyCode("MXP");
			if (i == 1) {
				customerProduct.setContractNumber(contractNumber);
			} else {
				customerProduct.setContractNumber("123456789" + i);
			}
			customerProduct.setBuc("987654321");
			customerProduct.setStatus("A");

			customerProductList.add(customerProduct);
		}

		return customerProductList;

	}

	private List<CustomerProduct> toCustomerProductList(Integer customerId, String buc, List<Product> productList) {
		LOGGER.logDebug("toCustomerProductList >> productList size >> " + (productList != null ? productList.size() : null));
		List<CustomerProduct> customerProducts = new ArrayList<CustomerProduct>();
		CustomerProduct customerProduct;
		for (Product p : productList) {
			customerProduct = new CustomerProduct();
			customerProduct.setCustomerId(customerId);
			customerProduct.setBuc(buc);
			customerProduct.setContractNumber(p.getContractNumber());
			customerProduct.setCurrencyCode(p.getCurrencyCode());
			customerProduct.setProductId(p.getProductCode());
			customerProduct.setSubproductId(p.getSubproductCode());
			customerProduct.setStatus(p.getStatus());
			customerProducts.add(customerProduct);
		}

		return customerProducts;
	}

	private CustomerCoreInfo fillCustomerCoreInfo(Integer customerId, AccountForDisbursementInfo accountForDisbursementInfo) {

		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		CustomerInfo customerInfo = accountForDisbursementInfo.getCustomerInfo();
		Product product = accountForDisbursementInfo.getProduct();

		customerCoreInfo.setBuc(customerInfo.getBuc());
		customerCoreInfo.setCustomerStdCode(customerInfo.getBuc());
		customerCoreInfo.setStatus(customerInfo.getStatus());
		customerCoreInfo.setCustomerAccountId(product.getContractNumber());

		customerCoreInfo.setProductList(toCustomerProductList(customerId, customerCoreInfo.getBuc(), accountForDisbursementInfo.getProductList()));

		return customerCoreInfo;

	}

	private CustomerCoreInfo callSantanderProvider(SantanderRequest santanderRequest) {
		LOGGER.logDebug("validating simulation");
		if (isSantanderSimulated()) {
			LOGGER.logWarning("warning using simulated data customerId: " + santanderRequest.getCustomerId());
			return fillCustomerCoreInfoSimulated(santanderRequest.getCustomerId());
		}

		SearchAccountForDisbursementInfo searchAccountForDisbursementInfo = fillSearchAccountForDisbursementInfo(santanderRequest);

		ConnectionInfo connectionInfo = fillConnectionInfo();
		AccountForDisbursementInfo accountForDisbursementInfo = getDisbursement().selectAccountForDisbursement(searchAccountForDisbursementInfo, connectionInfo);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("response when execute selectAccountForDisbursement:" + accountForDisbursementInfo);
		}

		if ((accountForDisbursementInfo.getCustomerInfo() == null) || (accountForDisbursementInfo.getProduct() == null)) {
			LOGGER.logDebug("Problemas when selectAccountForDisbursement, return was null, please verify connector log for more information");
			return null;
		}

		return fillCustomerCoreInfo(santanderRequest.getCustomerId(), accountForDisbursementInfo);
		// 91 cuenta banco
		// buc 94
		// status 95
		// buc
		// product id

	}

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo getCustomerInformation(
			com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest) {

		// to include in code order use key:
		// cobiscloudsantander.SantanderCoreServiceImpl.getCustomerInformation
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("aSantanderRequest:" + aSantanderRequest);
		}

		Map<String, Object> customerDetail = getCustomerService().getCustomerDetailsById(aSantanderRequest.getCustomerId());
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("customerDetail COLUMN91 bank account:" + customerDetail.get(BANK_ACCOUNT_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN94 buc, customerSantanderCode:" + customerDetail.get(BUC_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN95 status:" + customerDetail.get(STATUS_COLUMN));
		}

		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		if (customerDetail.get("COLUMN91") == null || customerDetail.get("COLUMN94") == null) {
			// call santander
			// update account and state in cobis
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("call santander");
			}

			customerCoreInfo = callSantanderProvider(aSantanderRequest);

			if (customerCoreInfo != null) {

				UpdateCustomerInfoRequest updateCustomerInfoRequest = new UpdateCustomerInfoRequest();
				updateCustomerInfoRequest.setCustomerId(aSantanderRequest.getCustomerId());
				updateCustomerInfoRequest.setBankAccount(customerCoreInfo.getCustomerAccountId());
				updateCustomerInfoRequest.setBank(customerCoreInfo.getBuc());
				updateCustomerInfoRequest.setStatus(customerCoreInfo.getStatus());

				this.getCustomerService().updateCustomerInfo(updateCustomerInfoRequest);
				this.getCustomerService().deleteCustomerProducts(aSantanderRequest.getCustomerId());
				this.getCustomerService().saveCustomerProducts(customerCoreInfo.getProductList());

			}

		} else {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("recover information from cobis core");
			}
			customerCoreInfo.setCustomerAccountId((String) customerDetail.get(BANK_ACCOUNT_COLUMN));
			customerCoreInfo.setBuc((String) customerDetail.get(BUC_COLUMN));
			customerCoreInfo.setCustomerStdCode((String) customerDetail.get(BUC_COLUMN));
			customerCoreInfo.setStatus((String) customerDetail.get(STATUS_COLUMN));

		}

		return customerCoreInfo;

	}

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo getCustomerInformationWithoutValidation(
			com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest) {
		LOGGER.logDebug("SantanderCoreServiceSERVImpl - getCustomerInformationWithoutValidation");
		// to include in code order use key:
		// cobiscloudsantander.SantanderCoreServiceImpl.getCustomerInformation
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("SantanderCoreServiceSERVImpl - getCustomerInformationWithoutValidation - aSantanderRequest:" + aSantanderRequest);
		}

		Map<String, Object> customerDetail = getCustomerService().getCustomerDetailsById(aSantanderRequest.getCustomerId());
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("customerDetail COLUMN91 bank account:" + customerDetail.get(BANK_ACCOUNT_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN94 buc, customerSantanderCode:" + customerDetail.get(BUC_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN95 status:" + customerDetail.get(STATUS_COLUMN));
		}
		// call santander
		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("SantanderCoreServiceSERVImpl - getCustomerInformationWithoutValidation - call santander");
		}
		customerCoreInfo = callSantanderProvider(aSantanderRequest);

		return customerCoreInfo;
	}

	public com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo getCustomerInformationWithOutUpdate(
			com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest) {

		// to include in code order use key:
		// cobiscloudsantander.SantanderCoreServiceImpl.getCustomerInformationWithOutUpdate
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("aSantanderRequest:" + aSantanderRequest);
		}

		Map<String, Object> customerDetail = getCustomerService().getCustomerDetailsById(aSantanderRequest.getCustomerId());
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("customerDetail COLUMN91 bank account:" + customerDetail.get(BANK_ACCOUNT_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN94 buc, customerSantanderCode:" + customerDetail.get(BUC_COLUMN));
			LOGGER.logDebug("customerDetail COLUMN95 status:" + customerDetail.get(STATUS_COLUMN));
		}

		CustomerCoreInfo customerCoreInfo = new CustomerCoreInfo();
		if (customerDetail.get("COLUMN91") == null) {
			// call santander
			// update account and state in cobis
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("call santander");
			}

			customerCoreInfo = callSantanderProvider(aSantanderRequest);

			if (customerCoreInfo != null) {

				UpdateCustomerInfoRequest updateCustomerInfoRequest = new UpdateCustomerInfoRequest();
				updateCustomerInfoRequest.setCustomerId(aSantanderRequest.getCustomerId());
				updateCustomerInfoRequest.setBankAccount(customerCoreInfo.getCustomerAccountId());
				updateCustomerInfoRequest.setBank(customerCoreInfo.getBuc());
				updateCustomerInfoRequest.setStatus(customerCoreInfo.getStatus());

				// this.getCustomerService().updateCustomerInfo(updateCustomerInfoRequest);
				this.getCustomerService().deleteCustomerProducts(aSantanderRequest.getCustomerId());
				this.getCustomerService().saveCustomerProducts(customerCoreInfo.getProductList());

			}

		} else {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("recover information from cobis core");
			}
			customerCoreInfo.setCustomerAccountId((String) customerDetail.get(BANK_ACCOUNT_COLUMN));
			customerCoreInfo.setBuc((String) customerDetail.get(BUC_COLUMN));
			customerCoreInfo.setCustomerStdCode((String) customerDetail.get(BUC_COLUMN));
			customerCoreInfo.setStatus((String) customerDetail.get(STATUS_COLUMN));

		}

		return customerCoreInfo;

	}

}
