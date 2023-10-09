package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.CatalogConstraintLog;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductHistory;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class BankingProductInformationByProduct extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(BankingProductInformationByProduct.class);

	public BankingProductInformationByProduct(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<CatalogConstraintLog> getEconomicDestination(ICommonEventArgs args, String idBankingProduct) throws Exception {
		BankingProductHistory bankingProductHistory = getBankingProductHistory(args, idBankingProduct);
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEECONOMICDESTINATION, bankingProductHistory.getId());
		return (List<CatalogConstraintLog>) serviceResponse.getData();
	}

	public List<CatalogConstraintLog> getActivityDestination(ICommonEventArgs args, String idBankingProduct) throws Exception {
		BankingProductHistory bankingProductHistory = getBankingProductHistory(args, idBankingProduct);
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEACTIVITYDESTINATION, bankingProductHistory.getId());
		return (List<CatalogConstraintLog>) serviceResponse.getData();
	}

	public Sector getBankingProductSector(ICommonEventArgs args, String idBankingProduct) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICBANKINGPRODUCTSECTOR, idBankingProduct);
		return (Sector) serviceResponse.getData();
	}

	public List<BankingProduct> getBankingProductsHistoricalbyModule(ICommonEventArgs args, Long module) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEGETBANKINGPRODUCTSBYMODULE, module);
		return (List<BankingProduct>) serviceResponse.getData();
	}

	public List<Catalog> getCatalogByName(ICommonEventArgs args, String name) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEGETCATALOGBYNAME, name);
		return (List<Catalog>) serviceResponse.getData();
	}

	public List<GeneralParametersValuesHistory> getCatalogGeneralParameter(ICommonEventArgs args, String productId, String parameterName)
			throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEGETGENERALPARAMETERCATALOG, productId, parameterName);
		return (List<GeneralParametersValuesHistory>) serviceResponse.getData();
	}

	public List<CurrencyProductHistory> getCurrencybyProduct(ICommonEventArgs args, String idBankingProduct) throws Exception {
		List<CurrencyProductHistory> bankingProducthistoryCurrencies = new ArrayList<CurrencyProductHistory>();
		BankingProductHistory bankingProductHistory = getBankingProductHistory(args, idBankingProduct);
		bankingProductHistory.getCurrencyProductsHistory();
		return bankingProducthistoryCurrencies = bankingProductHistory.getCurrencyProductsHistory();
	}

	public String getProductName(ICommonEventArgs args, String idBankingProduct) throws Exception {
		BankingProductHistory bankingProductHistory = getBankingProductHistory(args, idBankingProduct);
		return bankingProductHistory.getName();
	}

	private BankingProductHistory getBankingProductHistory(ICommonEventArgs args, String productBankingId) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICELATESHISTORICAL, productBankingId);
		return (BankingProductHistory) serviceResponse.getData();
	}

	public List<BankingProduct> getBankingProductByModule(ICommonEventArgs args, String module) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEGETBANKINGPRODUCTBYMODULE, module);
		return (List<BankingProduct>) serviceResponse.getData();
	}

	public BankingProduct getBankingProductBasicInformationById(ICommonEventArgs args, String productBankingId) throws Exception {
		ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEGETBANKINGPRODUCTBASICINFORMATIONBYID, productBankingId);
		return (BankingProduct) serviceResponse.getData();
	}
	
	public Boolean insertListFieldByProduct(ICommonEventArgs args, String productBankingId, String request, ArrayList fieldByProductList) throws Exception {
		if(logger.isDebugEnabled())
			logger.logDebug("Inicio insertListFieldByProduct");

		try
		{
			HashMap<String , String> map=new HashMap<String, String>();
			ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEINSERTLISTFIELDBYPRODUCT,fieldByProductList, productBankingId, request,map);
			if(serviceResponse.isResult()){
				return true;
			}else
				return false;
		}catch(Exception ex){
			logger.logError("Error", ex);
			throw ex;
		}finally{
			if(logger.isDebugEnabled())
				logger.logDebug("Fin insertListFieldByProduct");
		}

	}
	
	public Boolean insertListFieldByProductWarranties(ICommonEventArgs args, String productBankingId, String request, ArrayList fieldByProductList, HashMap map) throws Exception {
		
		if(logger.isDebugEnabled())
			logger.logDebug("Inicio insertListFieldByProductWarranties");

		try
		{
			ServiceResponse serviceResponse = manageExecutionService(args, ServiceId.SERVICEINSERTLISTFIELDBYPRODUCT,fieldByProductList, productBankingId, request, map);
			if(serviceResponse.isResult()){
				return true;
			}else
				return false;
		}catch(Exception ex){
			logger.logError("Error", ex);
			throw ex;
		}finally{
			if(logger.isDebugEnabled())
				logger.logDebug("Fin insertListFieldByProductWarranties");
		}

	}

	private ServiceResponse manageExecutionService(ICommonEventArgs arg1, String nameService, Object... obj) throws Exception {
		ServiceResponse serviceResponse = new ServiceResponse();
		try {
			logger.logDebug("Star execute manageExecutionService(" + nameService + ") method in BankingProductInformationByProduct class");
			if (obj == null) {
				logger.logError("Error en los parámetros del servicio " + nameService);
			} else {
				serviceResponse = this.execute(getServiceIntegration(), logger, nameService, obj);
				if (!serviceResponse.isResult()) {
					for (Message msg : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(msg.getMessage());
					}
					arg1.setSuccess(false);
				}
			}
			return serviceResponse;
		} catch (Exception ex) {
			logger.logError(ex);
			throw ex;
		} finally {
			logger.logDebug("End execute manageExecutionService(" + nameService + ") method in BankingProductInformationByProduct class");
		}
	}
}
