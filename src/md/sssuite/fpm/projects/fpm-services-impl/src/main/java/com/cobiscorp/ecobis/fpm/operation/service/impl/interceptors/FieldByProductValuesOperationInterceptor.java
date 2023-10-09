package com.cobiscorp.ecobis.fpm.operation.service.impl.interceptors;

import java.util.ArrayList;
import java.util.HashMap;

import org.aspectj.lang.JoinPoint;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.springframework.osgi.context.BundleContextAware;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;
import com.cobiscorp.ecobis.fpm.administration.service.IDictionaryManager;
import com.cobiscorp.ecobis.fpm.administration.service.impl.DictionaryManager;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioItemWarranties;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;



public class FieldByProductValuesOperationInterceptor implements BundleContextAware {
		private final ILogger logger = LogFactory.getLogger(FieldByProductValuesOperationInterceptor.class);

		private BundleContext bundleContext;
		private IBankingProductManager bankingProductManager;
		private IDictionaryManager dictionaryManager;

		public void setDictionaryManager(IDictionaryManager dictionaryManager) {
			this.dictionaryManager = dictionaryManager;
		}

		public void setBundleContext(BundleContext bundleContext) {
			this.bundleContext = bundleContext;
		}		
		
		public void setBankingProductManager(
				IBankingProductManager bankingProductManager) {
			this.bankingProductManager = bankingProductManager;
		}

		public void insertListFieldByProductValues(JoinPoint jointPoint) throws BusinessException {
			logger.logDebug(MessageManager.getString(
					"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.001",
					"insertListFieldByProductValues"));
		try {

			// Check if the bundle context was inject successfully
			if (bundleContext != null) {
				// Always the first parameter is the productId
				Object[] args = jointPoint.getArgs();
				// Find the category that define a module
				NodeTypeCategory category = bankingProductManager
						.getCategoryKeepDictionaryFromParents((String) args[1]);
				// The identifier of the portfolio module is 1
				if (category.getModule().getModuleId() == Modules.WARRANTY.getModuleId()) {
					logger.logDebug(MessageManager.getString(
							"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.003",	"Garantias"));

					// Get a reference for the Integration Service 
					ServiceReference reference = bundleContext.getServiceReference(IPortfolioItemWarranties.class.getName());
					

					if(logger.isDebugEnabled()){
						logger.logDebug("IPortfolioItemWarranties.class.getName() --> " + IPortfolioItemWarranties.class.getName());
						logger.logDebug(reference);
					}

					
					if (reference != null) {

						logger.logDebug(MessageManager.getString(
								"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.004",
								reference,
								IPortfolioItemWarranties.class
										.getName()));

						// Get the implementation instance
						IPortfolioItemWarranties serviceIntegration = (IPortfolioItemWarranties) bundleContext.getService(reference);

						logger.logDebug(MessageManager.getString(
								"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.006",
								"saveGeneralParametersValues",
								serviceIntegration));

						// Call the method with the correct type
						ArrayList<FieldByProductValues>fieldByProductValues=(ArrayList<FieldByProductValues>)args[0];
						ArrayList<FieldByProductValues>fieldByProductValues2=new ArrayList<FieldByProductValues>();
						for (FieldByProductValues fieldByProductValuesItem : fieldByProductValues) {
							DictionaryField dictionaryField=new DictionaryField();
							if(logger.isDebugEnabled())
								logger.logDebug(":>:>fieldByProductValuesItem.getField():>:>"+fieldByProductValuesItem.getField());
							dictionaryField=dictionaryManager.getDicFunctionalityByFieldId(fieldByProductValuesItem.getField());
							fieldByProductValuesItem.setDictionaryField(dictionaryField);
							fieldByProductValues2.add(fieldByProductValuesItem);						
						}
						
						serviceIntegration.insertListFieldByProductValues(
								(ArrayList<FieldByProductValues>)fieldByProductValues2, 
								(String)args[1], //bankingProductId
								(String)args[2], //request
								(HashMap<String, String>)args[3]);//map 
								
								
					} else {
						logger.logDebug(MessageManager.getString(
								"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.005",
								IPortfolioGeneralParametersManager.class
										.getName()));
					}
				}
			}
		} catch (ValidationException ve) {
			throw ve;
		} catch (BusinessException be) {
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.007"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"FIELDBYPRODUCTVALUESOPERATIONINTERCEPTOR.002",
					"insertListFieldByProductValues"));
		}
		}
}
