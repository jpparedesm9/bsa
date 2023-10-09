package com.cobis.cloud.sofom.operationsexecution.operationalservices.santander;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.IDisbursement;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.AccountForDisbursementInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.SearchAccountForDisbursementInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.CustomerInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.SearchCustomerInfo;
import com.cobis.cloud.sofom.referencedata.party.santander.CustomerProfile;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.Product;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.ProductsInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.SearchProductsInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.santander.CustomerAccessEntitlement;
import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.context.Target;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by pclavijo on 10/07/2017.
 */
public class Disbursement implements IDisbursement {
    private static ILogger logger = LogFactory.getLogger(Disbursement.class);
    private static final String className = "[Disbursement]";

    private ICacheManager cacheManager;

    public void setCacheManager(ICacheManager aCacheManager) {
        this.cacheManager = aCacheManager;
    }

    public ICacheManager getCacheManager() {
        return this.cacheManager;
    }

    private CobisStoredProcedureUtils cobisStoredProcedureUtils;


    /**
     * Sets the parameter cobisStoredProcedureUtils
     *
     * @param cobisStoredProcedureUtils
     */
    public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
        this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
    }


    public AccountForDisbursementInfo selectAccountForDisbursement(SearchAccountForDisbursementInfo searchAccountForDisbursementInfo, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[selectAccountForDisbursement]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("searchAccountForDisbursementInfo: " + searchAccountForDisbursementInfo.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }

        CustomerInfo customerInfo = null;
        Product selectedAccount = null;

        CustomerProfile customerProfile = new CustomerProfile();

        SearchCustomerInfo searchCustomerInfo = new SearchCustomerInfo(null, searchAccountForDisbursementInfo.getRfc(), searchAccountForDisbursementInfo.getName(), searchAccountForDisbursementInfo.getFirstLastName(), searchAccountForDisbursementInfo.getSecondLastName(), searchAccountForDisbursementInfo.getDateOfBirth());
        try {
            customerInfo = customerProfile.getCustomerByRfc(searchCustomerInfo, connectionInfo);
        } catch (Exception e) {
            logger.logError("ERROR customerProfile.getCustomerByRfc: ", e);
        }

        if (customerInfo != null && customerInfo.getBuc() != null && !("".equals(customerInfo.getBuc()))) {
            searchCustomerInfo.setBuc(customerInfo.getBuc());
            try {
                customerInfo = customerProfile.getCustomerByBuc(searchCustomerInfo, connectionInfo);
            } catch (Exception e) {
                logger.logError("ERROR customerProfile.getCustomerByBuc: ", e);
            }
        } else {
            try {
                customerInfo = customerProfile.getCustomerByNameAndDateOfBirth(searchCustomerInfo, connectionInfo);
            } catch (Exception e) {
                logger.logError("ERROR customerProfile.getCustomerByNameAndDateOfBirth: ", e);
            }
        }

        ProductsInfo productsInfo = null;
        List<Product> products = new ArrayList<Product>();

        if (customerInfo != null && customerInfo.getBuc() != null && !("".equals(customerInfo.getBuc()))) {
            if (customerInfo.getStatus().contentEquals("CLI")) { // Cliente Activo
                logger.logDebug("Active customer identified. It begins the search of products");
                SearchProductsInfo searchProductsByBucInfo = new SearchProductsInfo(customerInfo.getBuc());
                try {
                    CustomerAccessEntitlement customerAccessEntitlement = new CustomerAccessEntitlement();
                    productsInfo = customerAccessEntitlement.getProductsByBuc(searchProductsByBucInfo, connectionInfo);
                } catch (Exception e) {
                    logger.logError("ERROR customerAccessEntitlement.getProductsByBuc: ", e);
                }

                if (productsInfo != null && productsInfo.getProductList() != null) {
                    products = productsInfo.getProductList();
                    selectedAccount = searchDisbursementAccount(productsInfo);

                }
            }
        }

        /*if (customerInfo == null) {
            customerInfo = new CustomerInfo("12345678", "CLI");
        }
        if (selectedAccount == null) {
            selectedAccount = new Product("01", "0025", "A", "12345678901");
        }*/

        AccountForDisbursementInfo accountForDisbursementInfo = new AccountForDisbursementInfo(customerInfo, selectedAccount, products);
        if (logger.isTraceEnabled()) {
            logger.logTrace("accountForDisbursementInfo: " + accountForDisbursementInfo.toString());
        }

        return accountForDisbursementInfo;
    }

    private Product searchDisbursementAccount(ProductsInfo productsInfo) {
        for (Map<String, String> nivelPrelacion : getNivelesPrelacionCuenta()) {
            for (Product product : productsInfo.getProductList()) {
                if (belongsToNivelPrelacion(product, nivelPrelacion) && isProductActive(product)) {
                    return new Product(product.getProductCode(), product.getSubproductCode(), product.getStatus(), product.getContractNumber());
                }
            }
        }
        if (logger.isDebugEnabled()) {
            logger.logDebug("disbursementAccount not found");
        }
        return null;
    }

    private boolean isProductActive(Product product) {
        return product.getStatus().contentEquals("A");
    }

    private boolean belongsToNivelPrelacion(Product product, Map<String, String> nivelPrelacion) {
        return product.getProductCode().contentEquals(nivelPrelacion.get("producto")) && product.getSubproductCode().contentEquals(nivelPrelacion.get("subproducto"));
    }


    private List<Map<String, String>> getNivelesPrelacionCuenta() {

        if (logger.isDebugEnabled()) {
            logger.logDebug("Start getNivelesPrelacion");

        }
        ICache wCache = cacheManager.getCache("PrelacionNivelCuenta");
        if (wCache == null) {
            throw new IllegalStateException("Cache with PrelacionNivelCuenta should be configured in $COBIS_HOME/CTS_MF/services-as/cache/cts-cache.xml");
        }

        if (logger.isDebugEnabled()) {
            logger.logDebug("Cache niveles prelacion " + wCache.get("niveles"));
        }

        if (!wCache.isKeyInCache("niveles")) {
            if (logger.isDebugEnabled()) {
                logger.logDebug("Start retrieving niveles from data base");
            }
            CobisStoredProcedure wSp = cobisStoredProcedureUtils.getStoredProcedureInstance();
            Map<String, Object> wResultMap = null;

            wSp.setDatabase("cob_credito");
            wSp.setName("sp_prelacion_cuenta");
            wSp.setSkipResultsProcessing(false);
            wSp.setSkipUndeclaredResults(false);

            cobisStoredProcedureUtils.setContextParameters(ContextManager.getContext(), Target.TARGET_CENTRAL, wSp);

            if (logger.isDebugEnabled()) {
                logger.logDebug("wSp: " + wSp);
                logger.logDebug("Entra a setear parametros sp");
            }

            wSp.addInParam("@i_operacion", Types.VARCHAR, "Q");

            wResultMap = wSp.execute();

            if (logger.isDebugEnabled()) {
                logger.logDebug("wResultMap");
                logger.logDebug(wResultMap);
                logger.logDebug("Setting cache niveles prelacion cuenta" + wResultMap.get("#result-set-1"));
            }
            wCache.put("niveles", (ArrayList<Map<String, String>>) wResultMap.get("#result-set-1"));
        }


        return (List<Map<String, String>>) wCache.get("niveles");
    }


	public String researchAccountForDisbursement(String customerBuc, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[researchAccountForDisbursement]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("customerBuc: " + customerBuc.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }
        
        Product selectedAccount = null;

        if (customerBuc != null && !("".equals(customerBuc))) {
                logger.logDebug("Active customer identified. It begins the search of products");
                SearchProductsInfo searchProductsByBucInfo = new SearchProductsInfo(customerBuc);

                ProductsInfo productsInfo = null;
                try {
                    CustomerAccessEntitlement customerAccessEntitlement = new CustomerAccessEntitlement();
                    productsInfo = customerAccessEntitlement.getProductsByBuc(searchProductsByBucInfo, connectionInfo);
                } catch (Exception e) {
                    logger.logError("ERROR customerAccessEntitlement.getProductsByBuc: ", e);
                }

                if (productsInfo != null) {

                    selectedAccount = searchDisbursementAccount(productsInfo);
                }
        }
        
        /*if (selectedAccount == null) {
            selectedAccount = new Product("01", "0025", "A", "12345678901");
        }*/
        
        return selectedAccount.getContractNumber();
    }
}
