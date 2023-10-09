package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;

import cobiscorp.ecobis.card.dto.ContextConsolidatePosition;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.admin.bl.impl.AdministratorManagerImpl;
import com.cobiscorp.ecobis.clientviewer.admin.dal.AdministratorDAO;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.Dtos;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.bl.QueryProductsManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.Constants;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.AffiliationsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.CurrencyDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryOthersDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.entities.Currency;
import com.cobiscorp.ecobis.clientviewer.dto.AffiliateDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.OwnWarrantyTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ProductsByClientDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RequestRejectedTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryProductDTO;
import com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO;
import com.cobiscorp.ecobis.commons.dal.CatalogDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Catalog;
import com.cobiscorp.ecobis.external.services.extractor.ExternalExtractor;

public class QueryProductsManagerImpl implements QueryProductsManager {
	private static ILogger logger = LogFactory.getLogger(QueryProductsManagerImpl.class);
	private ICacheManager cacheManager;
	private static final String CACHE_WEB_SERVICES_CREDIT_CARD = "CacheCreditCardListResult";

	private SummaryInvestmentsDAO summaryInvestmentsDAO;
	private SummaryDebtsDAO summaryDebtsDAO;
	private SummaryWarrantiesDAO summaryWarrantiesDAO;
	private SummaryCreditsDAO summaryCreditsDAO;
	private SummaryOthersDAO summaryOthersDAO;
	private AffiliationsDAO affiliationsDAO;
	private CurrencyDAO currencyDAO;

	// ProductsByClientDTO queryProducts = new ProductsByClientDTO();

	CatalogDAO catalogDAO;
	AdministratorManagerImpl productsAdministratorByRol = new AdministratorManagerImpl();
	AdministratorDAO administratorDAO;
	// CardManagerImpl cardManagerImpl = new CardManagerImpl();
	// List<SummaryDebtsDTO> debtsLoans = new ArrayList<SummaryDebtsDTO>();
	// List<SummaryCreditsDTO> credits = new ArrayList<SummaryCreditsDTO>();
	// List<WarrantyTmpDTO> warranties = new ArrayList<WarrantyTmpDTO>();
	// List<OwnWarrantyTmpDTO> promissoryNotes = new
	// ArrayList<OwnWarrantyTmpDTO>();
	private ICTSServiceIntegration serviceIntegration;

	public ICacheManager getCacheManager() {
		return cacheManager;
	}

	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.QueryProductsManager#
	 * getQueryProductsByClientId(java.lang.Integer, java.lang.Integer)
	 */
	public ProductsByClientDTO getQueryProductsByClientId(Integer customer, String documentId, Integer spid) {
		try {

			ContextConsolidatePosition contextConsolidatePosition = new ContextConsolidatePosition();

			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getQueryProductsByClientId"));
			new HashMap<String, Object>();
			new ObjectMapper();
			CobisContext context = (CobisContext) ContextManager.getContext();
			productsAdministratorByRol.setAdministratorDAO(administratorDAO);

			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();
			Integer rol = Integer.parseInt(context.getSession().getRole());
			SummaryIdDTO key = new SummaryIdDTO(customer, user, Integer.parseInt(sesn));

			if (logger.isDebugEnabled()) {
				logger.logDebug("key: " + Integer.parseInt(sesn));
				logger.logDebug("spid: " + spid);
				logger.logDebug("customer: " + customer);
			}

			ProductsByClientDTO queryProducts = new ProductsByClientDTO();
			List<ProductAdministratorDTO> productsAdministrator = productsAdministratorByRol.getProductAdministratorByRole(rol);

			// PASIVAS
			getLiabilities(productsAdministrator, key, spid, queryProducts);

			// GARA
			// 5. GAR
			getPendingWarranties(productsAdministrator, key, spid, customer, queryProducts, contextConsolidatePosition);

			// DEUDAS
			getDebts(productsAdministrator, key, spid, customer, false, queryProducts, contextConsolidatePosition);

			// CREDITO
			// 6. CRE
			getCredit(productsAdministrator, key, spid, customer, false, queryProducts);

			// INDI
			getIndirects(productsAdministrator, key, spid, queryProducts);
			logger.logDebug("documentId........" + documentId);
			// 10. giros
			getOthers(productsAdministrator, key, spid, customer, documentId, queryProducts, contextConsolidatePosition);

			return queryProducts;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300003, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getQueryProductsByClientId"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.QueryProductsManager#
	 * getQueryProductsByClientId(java.lang.Integer, java.lang.Integer)
	 */
	public ProductsByClientDTO getQueryHistoryProductsByClientId(Integer customer, Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getQueryProductsByClientId"));
			ProductsByClientDTO queryProducts = new ProductsByClientDTO();
			ContextConsolidatePosition contextConsolidatePosition = new ContextConsolidatePosition();
			CobisContext context = (CobisContext) ContextManager.getContext();
			productsAdministratorByRol.setAdministratorDAO(administratorDAO);

			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();
			Integer rol = Integer.parseInt(context.getSession().getRole());
			SummaryIdDTO key = new SummaryIdDTO(customer, user, Integer.parseInt(sesn));
			logger.logDebug("key: " + Integer.parseInt(sesn));
			List<ProductAdministratorDTO> productsAdministrator = productsAdministratorByRol.getProductAdministratorByRole(rol);

			// PASIVAS
			getLiabilitiesHis(productsAdministrator, key, spid, queryProducts);

			// GARA
			// 5. GAR
			getPendingWarrantiesHis(productsAdministrator, key, spid, customer, queryProducts, contextConsolidatePosition);

			// DEUDAS
			getDebtsHist(productsAdministrator, key, spid, customer, queryProducts, contextConsolidatePosition);

			// CREDITO
			// 6. CRE
			getCredit(productsAdministrator, key, spid, customer, true, queryProducts);

			// INDI
			getIndirectsHis(productsAdministrator, key, spid, queryProducts);

			// 10. giros
			getOthersHis(productsAdministrator, key, spid, customer, queryProducts);

			return queryProducts;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300004, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getQueryProductsByClientId"));
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.bl.QueryProductsManager#
	 * deleteQueryProductsByClientId(java.lang.Integer)
	 */
	public void deleteQueryProductsByClientId(Integer spid) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "deleteQueryProductsByClientId"));
			summaryDebtsDAO.deleteAllDebtsLoans(spid);
			summaryWarrantiesDAO.deleteAllWarranties(spid);
			summaryWarrantiesDAO.deleteAllPromissoryNotes(spid);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.004"), ex);
			throw new BusinessException(7300005, "An error occurred at deleting temporary tables.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "deleteQueryProductsByClientId"));
		}
	}

	/*
	 * Method that gets Catalog Affiliate
	 */
	private List<AffiliateDTO> getAllDataAffiliation(SummaryIdDTO key) {

		List<Catalog> loginStateCatalog = catalogDAO.getCatalogsByName("bv_tipo_login_estado");
		List<AffiliateDTO> affiliations = affiliationsDAO.getAllAffiliations(key);

		for (AffiliateDTO affiliate : affiliations) {
			affiliate.setState(getCatalogValue(loginStateCatalog, affiliate.getStateRegistry()));
		}

		return affiliations;
	}

	/*
	 * Method that gets the value of a catalog
	 */
	private String getCatalogValue(List<Catalog> catalog, String code) {

		for (Catalog catalogValue : catalog) {
			if (catalogValue.getCode().equals(code)) {
				return catalogValue.getValue();
			}
		}

		return null;
	}

	public void getDebtsHist(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid, Integer customer,
			ProductsByClientDTO queryProducts, ContextConsolidatePosition contextConsolidatePosition) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getDebtsHist"));
			CobisContext context = (CobisContext) ContextManager.getContext();
			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();
			// 4. SOB
			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			List<SummaryDebtsDTO> overdrafts = summaryDebtsDAO.getAllOverdrafts(key);
			overdrafts = checkProductByRolOverdrafts(overdrafts, productsAdministrator, "SOB");
			queryProducts.getProductsByClientDTO().put("overdrafts", overdrafts);
			// 13. CCA
			contextConsolidatePosition.setDebtsLoans(checkProductByRolDebtsLoans(
					summaryDebtsDAO.getAllDebtsLoans(spid, "D", user, sesn, customer), productsAdministrator, "CCA"));
			List<SummaryDebtsDTO> resultDebtsLoans = new ArrayList<SummaryDebtsDTO>();
			// resultDebtsLoans = debtsLoans;
			for (SummaryDebtsDTO debtTmp : contextConsolidatePosition.getDebtsLoans()) {
				logger.logDebug("Debt>>> State code: " + debtTmp.getState() + "--" + debtTmp.getAvailable());
				if (debtTmp.getNumberOperation() != null && !"".equals(debtTmp.getNumberOperation().trim())) {
					resultDebtsLoans.add(debtTmp);
				}
			}

			// Solicitudes rechazadas
			List<RequestRejectedTmpDTO> requestRejected = summaryDebtsDAO.getRequestRejected(spid);
			queryProducts.getProductsByClientDTO().put("requestRejected", requestRejected);

			queryProducts.getProductsByClientDTO().put("debtsLoansHist", resultDebtsLoans);
			queryProducts.getProductsByClientDTO().put("debtsSourceHist", summaryProductDTO);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300012, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getDebtsHist"));
		}
	}

	public void getDebts(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid, Integer customer,
			Boolean history, ProductsByClientDTO queryProducts, ContextConsolidatePosition contextConsolidatePosition) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getDebts"));
			int count = 0;
			double totalAmountProduct = 0;
			double totalDebtsCreditCard = 0;
			CobisContext context = (CobisContext) ContextManager.getContext();
			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();

			// 4. SOB

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			List<SummaryDebtsDTO> overdrafts = summaryDebtsDAO.getAllOverdrafts(key);
			overdrafts = checkProductByRolOverdrafts(overdrafts, productsAdministrator, "SOB");

			queryProducts.getProductsByClientDTO().put("overdrafts", overdrafts);

			for (SummaryDebtsDTO summaryDebtsDTO : overdrafts) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				logger.logDebug("summaryDebtsDTO.getAmount()" + summaryDebtsDTO.getAmount());
				consolidatePositionDTO.setAmount(summaryDebtsDTO.getAmount());
				consolidatePositionDTO.setProduct(summaryDebtsDTO.getProduct());
				consolidatePositionDTO.setType(summaryDebtsDTO.getOperationType());
				consolidatePositionDTO.setNumber(summaryDebtsDTO.getNumberOperation());
				if (summaryDebtsDTO.getAmounLocalMoney() != null) {
					totalAmountProduct += summaryDebtsDTO.getAmounLocalMoney();
				}
				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}
			count = overdrafts.size();

			// 13. CCA
			contextConsolidatePosition.setDebtsLoans(checkProductByRolDebtsLoans(
					summaryDebtsDAO.getAllDebtsLoans(spid, "D", user, sesn,customer), productsAdministrator, "CCA"));
			logger.logDebug("debtsLoans---------->" + contextConsolidatePosition.getDebtsLoans());
			logger.logDebug("debtsLoans.size()--->" + contextConsolidatePosition.getDebtsLoans() == null ? 0
					: contextConsolidatePosition.getDebtsLoans().size());

			List<SummaryDebtsDTO> resultDebtsLoans = new ArrayList<SummaryDebtsDTO>();
			for (SummaryDebtsDTO debtTmp : contextConsolidatePosition.getDebtsLoans()) {
				logger.logDebug("Debt>>> State code: " + debtTmp.getState());
				if (debtTmp.getNumberOperation() != null && !"".equals(debtTmp.getNumberOperation().trim())) {
					logger.logDebug("Total charges..." + debtTmp.getTotalCharges());
					resultDebtsLoans.add(debtTmp);
				}
			}
			if (history) {
				queryProducts.getProductsByClientDTO().put("debtsLoansHist", resultDebtsLoans);
			} else {
				queryProducts.getProductsByClientDTO().put("debtsLoans", resultDebtsLoans);
			}

			for (SummaryDebtsDTO resultDebt : resultDebtsLoans) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				logger.logDebug("resultDebt.getAmounLocalMoney(): " + resultDebt.getAmounLocalMoney());
				logger.logDebug("resultDebt.getAmount(): " + resultDebt.getAmount());
				logger.logDebug("resultDebt.getAvailable(): " + resultDebt.getAvailable());
				logger.logDebug("resultDebt.getAmountRisk(): " + resultDebt.getAmountRisk());
				logger.logDebug("resultDebt.getTotalCharges(): " + resultDebt.getTotalCharges());
				consolidatePositionDTO.setAmount(resultDebt.getTotalCharges());
				consolidatePositionDTO.setProduct(resultDebt.getProduct());
				consolidatePositionDTO.setType(resultDebt.getOperationType());
				consolidatePositionDTO.setNumber(resultDebt.getNumberOperation());
				if (resultDebt.getTotalCharges() != null) {
					totalAmountProduct += resultDebt.getTotalCharges();
				}
				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);

			}
			if (resultDebtsLoans != null) {
				count += resultDebtsLoans.size();
			}

			// Llamada Genérica a Servicios Externos
			List<Dtos> dtos = administratorDAO.getByDefaultProductAdministrator(Constants.DEUDAS);
			for (Dtos dto : dtos) {
				if (dto.getMnemonic() != null && !dto.getMnemonic().equals(Constants.DEUDAS)) {
					ExternalExtractor obj = new ExternalExtractor();
					logger.logDebug("DTO------> " + dto.getDtoName() + "-" + dto.getMnemonic() + "-" + dto.getDtoDescription());
					@SuppressWarnings("unchecked")
					List<SummaryDebtsDTO> otherSummaryDebts = (List<SummaryDebtsDTO>) obj
							.getObject("(extservice.type=" + dto.getDtoName() + ")", customer);
					if (otherSummaryDebts != null) {
						for (SummaryDebtsDTO otherSummaryDebt : otherSummaryDebts) {

							ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
							consolidatePositionDTO.setAmount(otherSummaryDebt.getAvailable());
							consolidatePositionDTO.setProduct(otherSummaryDebt.getProduct());
							consolidatePositionDTO.setType(otherSummaryDebt.getDescriptionType());
							consolidatePositionDTO.setNumber(otherSummaryDebt.getNumberOperation());
							summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);

							if (otherSummaryDebt.getAvailable() != null) {
								totalAmountProduct += otherSummaryDebt.getAvailable();
								logger.logInfo("DEBTS Monto Utilizado: " + otherSummaryDebt.getAvailable());
							}

							// se consulta descripcion de moneda
							if (otherSummaryDebt.getCurrencyId() >= 0) {
								logger.logDebug("MONEDA ID CONT   --> " + otherSummaryDebt.getCurrencyId());
								Currency currency = currencyDAO.getCurrencyById(otherSummaryDebt.getCurrencyId());

								if (currency != null) {
									logger.logDebug("MONEDA DESC CONT --> " + currency.toString());
									otherSummaryDebt.setCurrencyDescription(
											currency.getDescription() == null ? "" : currency.getDescription());
									otherSummaryDebt
											.setCurrencyMnemonic(currency.getMnemonic() == null ? "" : currency.getMnemonic());
								}
							}

						}
						if (otherSummaryDebts != null) {
							count += otherSummaryDebts.size();
						}

						queryProducts.getProductsByClientDTO().put(dto.getDtoName(), otherSummaryDebts);
					}
				}
			}

			// validar si existe data en cache sino cargarla
			logger.logInfo("Total Amount Porduct: " + totalAmountProduct);
			logger.logInfo("Total Credit Card: " + totalDebtsCreditCard);
			summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
			summaryProductDTO.setTotalProduct(count);
			if (history) {
				queryProducts.getProductsByClientDTO().put("debtsSourceHist", summaryProductDTO);
			} else {

				queryProducts.getProductsByClientDTO().put("debtsSource", summaryProductDTO);
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300006, "An error occurred at obtain products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getDebts"));
		}
	}

	public void getLiabilities(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getLiabilities"));
			int count = 0;
			double totalAmountProduct = 0;

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			List<SummaryInvestmentsDTO> currentAccounts = summaryInvestmentsDAO.getAllCurrentsAccount(key);
			currentAccounts = checkProductByRol(currentAccounts, productsAdministrator);
			queryProducts.getProductsByClientDTO().put("currentAccounts", currentAccounts);

			for (SummaryInvestmentsDTO currentAccount : currentAccounts) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(currentAccount.getBalance());
				consolidatePositionDTO.setProduct(currentAccount.getProduct());
				consolidatePositionDTO.setType(currentAccount.getTypeDescription());
				consolidatePositionDTO.setNumber(currentAccount.getOperationNumber());
				if (currentAccount.getBalanceLocalCurrency() != null) {
					totalAmountProduct += currentAccount.getBalanceLocalCurrency();
				}

				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}

			if (currentAccounts != null) {
				count += currentAccounts.size();
			}
			// 2. AHO
			List<SummaryInvestmentsDTO> savingAccounts = summaryInvestmentsDAO.getAllSavingsAccount(key);
			savingAccounts = checkProductByRol(savingAccounts, productsAdministrator);

			queryProducts.getProductsByClientDTO().put("savingAccounts", savingAccounts);

			for (SummaryInvestmentsDTO savingAccount : savingAccounts) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(savingAccount.getBalance());
				consolidatePositionDTO.setProduct(savingAccount.getProduct());
				consolidatePositionDTO.setType(savingAccount.getTypeDescription());
				consolidatePositionDTO.setNumber(savingAccount.getOperationNumber());
				if (savingAccount.getBalanceLocalCurrency() != null) {
					totalAmountProduct += savingAccount.getBalanceLocalCurrency();
				}

				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}
			if (savingAccounts != null) {
				count += savingAccounts.size();
			}

			// 3. PFI
			List<SummaryInvestmentsDTO> fixedTerms = summaryInvestmentsDAO.getAllFixedTerms(key);
			fixedTerms = checkProductByRol(fixedTerms, productsAdministrator);
			queryProducts.getProductsByClientDTO().put("fixedTerms", fixedTerms);

			for (SummaryInvestmentsDTO fixedTerm : fixedTerms) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(fixedTerm.getBalance());
				consolidatePositionDTO.setProduct(fixedTerm.getProduct());
				consolidatePositionDTO.setType(fixedTerm.getTypeDescription());
				consolidatePositionDTO.setNumber(fixedTerm.getOperationNumber());

				if (fixedTerm.getBalanceLocalCurrency() != null) {
					totalAmountProduct += fixedTerm.getBalanceLocalCurrency();
				}

				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);

			}

			summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
			if (fixedTerms != null) {
				count += fixedTerms.size();
			}
			summaryProductDTO.setTotalProduct(count);
			queryProducts.getProductsByClientDTO().put("liabilitiesSource", summaryProductDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300007, "An error occurred at obtain products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getLiabilities"));
		}
	}

	public void getLiabilitiesHis(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getLiabilitiesHis"));
			// 1. CCA
			List<SummaryInvestmentsDTO> currentAccounts = summaryInvestmentsDAO.getAllCurrentsAccount(key);
			currentAccounts = checkProductByRol(currentAccounts, productsAdministrator);
			queryProducts.getProductsByClientDTO().put("currentAccountsHis", currentAccounts);

			// 2. AHO
			List<SummaryInvestmentsDTO> savingAccounts = summaryInvestmentsDAO.getAllSavingsAccount(key);
			savingAccounts = checkProductByRol(savingAccounts, productsAdministrator);
			queryProducts.getProductsByClientDTO().put("savingAccountsHis", savingAccounts);

			// 3. PFI
			List<SummaryInvestmentsDTO> fixedTerms = summaryInvestmentsDAO.getAllFixedTerms(key);
			fixedTerms = checkProductByRol(fixedTerms, productsAdministrator);
			queryProducts.getProductsByClientDTO().put("fixedTermsHis", fixedTerms);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300007, "An error occurred at obtain history products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getLiabilitiesHis"));
		}
	}

	public void getPendingWarranties(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			Integer customer, ProductsByClientDTO queryProducts, ContextConsolidatePosition contextConsolidatePosition) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getPendingWarranties"));

			int count = 0;
			double totalAmountProduct = 0;

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			contextConsolidatePosition.setWarranties(
					checkProductByRolWarranties(summaryWarrantiesDAO.getAllWarranties(spid), productsAdministrator));

			List<WarrantyTmpDTO> resultWarranties = new ArrayList<WarrantyTmpDTO>();
			logger.logDebug("wrranties size: "+contextConsolidatePosition.getWarranties().size());
			for (WarrantyTmpDTO warranty : contextConsolidatePosition.getWarranties()) {
				logger.logDebug("warranty 1: "+ warranty.getCode() +  "stateCode:"+warranty.getStateCode());
				if (warranty.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_CURRENT_STATUS_ARRAY) {
						if (status.equals(warranty.getStateCode()) && warranty.getGuarantorId() != null
								&& !"".equals(warranty.getGuarantorId().trim())) {
							logger.logDebug("warranty 2: "+ warranty.getCode());
							resultWarranties.add(warranty);
						}
					}
				}
			}

			queryProducts.getProductsByClientDTO().put("warranties", resultWarranties);
			for (WarrantyTmpDTO resultWarranty : resultWarranties) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(resultWarranty.getActualValue());
				consolidatePositionDTO.setProduct(resultWarranty.getModule());
				consolidatePositionDTO.setType(resultWarranty.getWarrantyDescription());
				consolidatePositionDTO.setNumber(resultWarranty.getGuarantorId());

				if (resultWarranty.getActualMLValue() != null) {
					totalAmountProduct += resultWarranty.getActualMLValue();
				}
				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}

			if (resultWarranties != null) {
				count += resultWarranties.size();
			}

			// 11. PAGARES

			contextConsolidatePosition.setPromissoryNotes(
					checkProductWarrantiesOwn(summaryWarrantiesDAO.getAllPromissoryNotes(spid), productsAdministrator));

			List<OwnWarrantyTmpDTO> resultPromissoryNotes = new ArrayList<OwnWarrantyTmpDTO>();
			for (OwnWarrantyTmpDTO promisoryNote : contextConsolidatePosition.getPromissoryNotes()) {
				if (promisoryNote.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_CURRENT_STATUS_ARRAY) {
						if (status.equals(promisoryNote.getState()) && promisoryNote.getGuarantorId() != null
								&& !"".equals(promisoryNote.getGuarantorId().trim())) {
							resultPromissoryNotes.add(promisoryNote);
						}
					}
				}
			}
			queryProducts.getProductsByClientDTO().put("promissoryNotes", resultPromissoryNotes);

			for (OwnWarrantyTmpDTO resultPromissoryNote : resultPromissoryNotes) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(resultPromissoryNote.getActualValue());
				consolidatePositionDTO.setProduct(resultPromissoryNote.getModule());
				consolidatePositionDTO.setType(resultPromissoryNote.getWarrantyDescription());
				consolidatePositionDTO.setNumber(resultPromissoryNote.getGuarantorId());
				if (resultPromissoryNote.getActualValue() != null) {
					totalAmountProduct += resultPromissoryNote.getActualValue();
				}

				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}
			if (resultPromissoryNotes != null) {
				count += resultPromissoryNotes.size();
			}

			List<Object> insurancePolicy = new ArrayList<Object>();
			queryProducts.getProductsByClientDTO().put("insurancePolicy", insurancePolicy);
			if (insurancePolicy != null) {
				count += insurancePolicy.size();
			}

			// Llamada Genérica a Servicios Externos
			List<Dtos> dtos = administratorDAO.getByDefaultProductAdministrator("GARA");
			for (Dtos dto : dtos) {
				if (dto != null && dto.getMnemonic() != null && !dto.getMnemonic().equals("GARA")) {
					ExternalExtractor obj = new ExternalExtractor();
					List<WarrantyTmpDTO> otherWarranties = (List<WarrantyTmpDTO>) obj
							.getObject("(extservice.type=" + dto.getDtoName() + ")", customer);
					if (otherWarranties != null) {
						for (WarrantyTmpDTO warrantyTemp : otherWarranties) {
							if (warrantyTemp.getActualValue() != null) {
								totalAmountProduct += warrantyTemp.getActualValue();
							}

						}

						if (otherWarranties != null) {
							count += otherWarranties.size();
						}
						queryProducts.getProductsByClientDTO().put(dto.getDtoName(), otherWarranties);
					}
				}
			}

			summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
			summaryProductDTO.setTotalProduct(count);

			queryProducts.getProductsByClientDTO().put("guaranteesSource", summaryProductDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300008, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getPendingWarranties"));
		}

	}

	public void getPendingWarrantiesHis(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			Integer customer, ProductsByClientDTO queryProducts, ContextConsolidatePosition contextConsolidatePosition) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getPendingWarrantiesHis"));

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			contextConsolidatePosition.setWarranties(
					checkProductByRolWarranties(summaryWarrantiesDAO.getAllWarranties(spid), productsAdministrator));

			List<WarrantyTmpDTO> resultWarranties = new ArrayList<WarrantyTmpDTO>();
			for (WarrantyTmpDTO warranty : contextConsolidatePosition.getWarranties()) {
				if (warranty.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_CURRENT_STATUS_ARRAY_HIS) {
						if (status.equals(warranty.getStateCode().trim()) && warranty.getGuarantorId() != null
								&& !"".equals(warranty.getGuarantorId().trim())) {
							resultWarranties.add(warranty);
						}
					}
				}
			}

			queryProducts.getProductsByClientDTO().put("warrantiesHis", resultWarranties);

			// 11. PAGARES
			contextConsolidatePosition.setPromissoryNotes(
					checkProductWarrantiesOwn(summaryWarrantiesDAO.getAllPromissoryNotes(spid), productsAdministrator));

			List<OwnWarrantyTmpDTO> resultPromissoryNotes = new ArrayList<OwnWarrantyTmpDTO>();
			for (OwnWarrantyTmpDTO promisoryNote : contextConsolidatePosition.getPromissoryNotes()) {
				if (promisoryNote.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_CURRENT_STATUS_ARRAY_HIS) {
						if (status.equals(promisoryNote.getState().trim()) && promisoryNote.getGuarantorId() != null
								&& !"".equals(promisoryNote.getGuarantorId().trim())) {
							resultPromissoryNotes.add(promisoryNote);
						}
					}
				}
			}
			queryProducts.getProductsByClientDTO().put("promissoryNotesHis", resultPromissoryNotes);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300014, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getPendingWarranties"));
		}

	}

	public void getCredit(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid, Integer customer,
			Boolean history, ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getCredit"));

			int count = 0;
			double totalAmountProduct = 0;

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());

			List<SummaryCreditsDTO> credits = summaryCreditsDAO.getAllCreditLines(key);
			credits = checkProductCredits(credits, productsAdministrator);
			List<String> creditLinesNumber = new ArrayList<String>();

			List<SummaryCreditsDTO> resultCredits = new ArrayList<SummaryCreditsDTO>();
			for (SummaryCreditsDTO credit : credits) {
				if (credit.getLineNumber() != null && !"".equals(credit.getLineNumber().trim())) {

					if (!creditLinesNumber.contains(credit.getLineNumber())) {

						ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
						consolidatePositionDTO.setAmount(credit.getRiskAmount());
						consolidatePositionDTO.setProduct(credit.getProduct());
						consolidatePositionDTO.setType(credit.getOpTypeDescription());
						consolidatePositionDTO.setNumber(credit.getLineNumber());
						summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);

						if (credit.getRiskAmount() != null) {
							totalAmountProduct += credit.getRiskAmount();
						}
						creditLinesNumber.add(credit.getLineNumber());
					}
					resultCredits.add(credit);

				}
			}

			if (resultCredits != null) {
				count += resultCredits.size();
			}

			// CONT
			// 7. CEX

			List<SummaryDebtsDTO> contingencies = summaryDebtsDAO.getAllContingencies(key); // Esta
																							// Consulta
																							// no
																							// trae
																							// información
																							// de
																							// Montos
			contingencies = checkProductByRolOverdrafts(contingencies, productsAdministrator, "CEX");

			List<SummaryDebtsDTO> summaryDebtsResult = new ArrayList<SummaryDebtsDTO>();
			for (SummaryDebtsDTO contigency : contingencies) {
				if (contigency.getNumberOperation() != null && !"".equals(contigency.getNumberOperation().trim())) {
					ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
					consolidatePositionDTO.setAmount(contigency.getAvailable());
					consolidatePositionDTO.setProduct(contigency.getOperationType());
					consolidatePositionDTO.setType(contigency.getDescriptionType());
					consolidatePositionDTO.setNumber(contigency.getNumberOperation());
					summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
					summaryDebtsResult.add(contigency);

					if (contigency.getAvailable() != null) {
						totalAmountProduct += contigency.getAvailable();
					}

				}
			}
			if (summaryDebtsResult != null) {
				count += summaryDebtsResult.size();
			}

			List<SummaryOtherDTO> others = summaryOthersDAO.getAllOtherContingencies(key);
			others = checkProductByRolOthers(others, productsAdministrator, "CEX");

			List<SummaryOtherDTO> othersResult = new ArrayList<SummaryOtherDTO>();
			for (SummaryOtherDTO summaryOther : others) {

				if (summaryOther.getNumberOperation() != null && !"".equals(summaryOther.getNumberOperation().trim())) {

					othersResult.add(summaryOther);

					if (summaryOther.getAmountML() != null) {

						totalAmountProduct += summaryOther.getAmountML();

					}

				}
			}

			if (othersResult != null) {
				count += othersResult.size();
			}

			if (history) {
				queryProducts.getProductsByClientDTO().put("creditsHist", resultCredits);
				queryProducts.getProductsByClientDTO().put("contingenciesHist", summaryDebtsResult);
				queryProducts.getProductsByClientDTO().put("productsOtherComextHist", othersResult);
			} else {
				// Llamada Genérica a Servicios Externos
				List<Dtos> dtos = administratorDAO.getByDefaultProductAdministrator("CONT");
				for (Dtos dto : dtos) {
					if (dto != null && dto.getMnemonic() != null && !dto.getMnemonic().equals("CONT")) {
						ExternalExtractor obj = new ExternalExtractor();
						@SuppressWarnings("unchecked")
						List<SummaryDebtsDTO> externalDebts = (List<SummaryDebtsDTO>) obj
								.getObject("(extservice.type=" + dto.getDtoName() + ")", customer);
						if (externalDebts != null) {

							for (SummaryDebtsDTO externalDebt : externalDebts) {
								ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
								consolidatePositionDTO.setAmount(externalDebt.getAvailable());
								consolidatePositionDTO.setProduct(externalDebt.getOperationType());
								consolidatePositionDTO.setType(externalDebt.getDescriptionType());
								consolidatePositionDTO.setNumber(externalDebt.getNumberOperation());
								summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);

								if (externalDebt.getAmounLocalMoney() != null) {
									totalAmountProduct += externalDebt.getAmounLocalMoney();
								}

								// se consulta descripcion de moneda
								if (externalDebt.getCurrencyId() >= 0) {
									logger.logDebug("MONEDA ID CONT   --> " + externalDebt.getCurrencyId());
									Currency currency = currencyDAO.getCurrencyById(externalDebt.getCurrencyId());

									if (currency != null) {
										logger.logDebug("MONEDA DESC CONT --> " + currency.toString());
										externalDebt.setCurrencyDescription(
												currency.getDescription() == null ? "" : currency.getDescription());
										externalDebt.setCurrencyMnemonic(
												currency.getMnemonic() == null ? "" : currency.getMnemonic());
									}
								}

							}

							if (externalDebts != null) {
								count += externalDebts.size();
							}
							queryProducts.getProductsByClientDTO().put(dto.getDtoName(), externalDebts);
						}
					}
				}

				summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
				summaryProductDTO.setTotalProduct(count);
				queryProducts.getProductsByClientDTO().put("credits", resultCredits);
				queryProducts.getProductsByClientDTO().put("contingencies", summaryDebtsResult);
				queryProducts.getProductsByClientDTO().put("productsOtherComext", othersResult);
				queryProducts.getProductsByClientDTO().put("contingentsSource", summaryProductDTO);
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300009, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getCredit"));
		}

	}

	public void getIndirects(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getIndirects"));
			double totalAmountProduct = 0;
			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());
			// 14. Indirect
			List<DebtTmpDTO> indirectPortfolio = summaryDebtsDAO.getIndirects(spid, "I");
			indirectPortfolio = checkProductByRolIndirects(indirectPortfolio, productsAdministrator, "ICCA");
			// queryProducts.setIndirectPortfolio(indirectPortfolio);
			for (DebtTmpDTO resulDebTemp : indirectPortfolio) {
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO();
				consolidatePositionDTO.setAmount(resulDebTemp.getAmountOrigin());
				consolidatePositionDTO.setProduct(resulDebTemp.getProduct());
				consolidatePositionDTO.setType(resulDebTemp.getOperationType());
				consolidatePositionDTO.setNumber(resulDebTemp.getOperation());

				if (resulDebTemp.getContractValue() != null) {
					totalAmountProduct += resulDebTemp.getContractValue();
				}
				summaryProductDTO.getConsolidatePosition().add(consolidatePositionDTO);
			}
			summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
			summaryProductDTO.setTotalProduct(indirectPortfolio.size());
			queryProducts.getProductsByClientDTO().put("indirectPortfolio", indirectPortfolio);
			queryProducts.getProductsByClientDTO().put("IndirectPortfolioSource", summaryProductDTO);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300010, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getIndirects"));
		}

	}

	public void getIndirectsHis(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid,
			ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getIndirectsHis"));

			logger.logInfo("spid indirects ----------> " + spid);

			List<DebtTmpDTO> indirectPortfolio = summaryDebtsDAO.getIndirects(spid, "I");

			for (DebtTmpDTO debtTmpDTO : indirectPortfolio) {
				logger.logInfo("indirectPortfolio----------> " + debtTmpDTO.toString());
			}

			indirectPortfolio = checkProductByRolIndirects(indirectPortfolio, productsAdministrator, "ICCA");

			for (DebtTmpDTO debtTmpDTO : indirectPortfolio) {
				logger.logInfo("indirectPortfolio after check ----------> " + debtTmpDTO.toString());
			}

			queryProducts.getProductsByClientDTO().put("indirectPortfolioHis", indirectPortfolio);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300015, "An error occurred at obtaining products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getIndirectsHis"));
		}

	}

	public void getOthers(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid, int customer,
			String documentId, ProductsByClientDTO queryProducts, ContextConsolidatePosition contextConsolidatePosition) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getOthers"));

			// OPSE
			// 10. OTROS CONTINGENTES
			int count = 0;
			double totalAmountProduct = 0;

			SummaryProductDTO summaryProductDTO = new SummaryProductDTO();
			summaryProductDTO.setConsolidatePosition(new ArrayList<ConsolidatePositionDTO>());

			List<AffiliateDTO> affiliations = getAllDataAffiliation(key);
			affiliations = checkProductByRolAffiliations(affiliations, productsAdministrator, "GLOB");
			queryProducts.getProductsByClientDTO().put("affiliations", affiliations);

			if (affiliations != null) {
				count += affiliations.size();
			}

			List<SummaryDebtsDTO> productsApplicationLoans = new ArrayList<SummaryDebtsDTO>();
			for (SummaryDebtsDTO debtTmp : contextConsolidatePosition.getDebtsLoans()) {
				if (debtTmp.getState() != null) {

					for (String status : Constants.LOANS_PENDING_STATUS_ARRAY)
						if (status.equals(debtTmp.getState()) && debtTmp.getNumberOperation() != null) {
							if (debtTmp.getAmount() != null) {
								totalAmountProduct += debtTmp.getAmount();
							}
							productsApplicationLoans.add(debtTmp);
						}
				}
			}
			queryProducts.getProductsByClientDTO().put("productsApplicationLoans", productsApplicationLoans);
			if (productsApplicationLoans != null) {
				count += productsApplicationLoans.size();
			}

			List<SummaryCreditsDTO> productsCreditsPendings = new ArrayList<SummaryCreditsDTO>();
			for (SummaryCreditsDTO credit : contextConsolidatePosition.getCredits()) {
				if (credit.getLineNumber() == null) {
					if (credit.getAvailable() != null) {
						totalAmountProduct += credit.getAvailable();
					}
					productsCreditsPendings.add(credit);
				}
			}
			queryProducts.getProductsByClientDTO().put("productsCreditsPendings", productsCreditsPendings);
			if (productsCreditsPendings != null) {
				count += productsCreditsPendings.size();
			}

			List<WarrantyTmpDTO> productsPendingGuaranties = new ArrayList<WarrantyTmpDTO>();
			for (WarrantyTmpDTO warranty : contextConsolidatePosition.getWarranties()) {
				if (warranty.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_PENDING_STATUS_ARRAY) {
						if (status.equals(warranty.getStateCode()) && warranty.getGuarantorId() != null) {
							if (warranty.getActualValue() != null) {
								totalAmountProduct += warranty.getActualValue();
							}

							productsPendingGuaranties.add(warranty);
						}
					}
				}
			}
			queryProducts.getProductsByClientDTO().put("productsPendingGuaranties", productsPendingGuaranties);
			if (productsPendingGuaranties != null) {
				count += productsPendingGuaranties.size();
			}

			List<OwnWarrantyTmpDTO> productsPromissoryNotePending = new ArrayList<OwnWarrantyTmpDTO>();
			for (OwnWarrantyTmpDTO promisoryNote : contextConsolidatePosition.getPromissoryNotes()) {
				if (promisoryNote.getStateCode() != null) {
					for (String status : Constants.GUARANTEES_PENDING_STATUS_ARRAY) {
						if (status.equals(promisoryNote.getStateCode()) && promisoryNote.getGuarantorId() != null) {
							if (promisoryNote.getActualValue() != null) {
								totalAmountProduct += promisoryNote.getActualValue();
							}

							productsPromissoryNotePending.add(promisoryNote);
						}
					}
				}
			}
			queryProducts.getProductsByClientDTO().put("productsPromissoryNotePending", productsPromissoryNotePending);

			if (productsPromissoryNotePending != null) {
				count += productsPromissoryNotePending.size();
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(MessageManager.getString("Obtiene Solicitudes en curso"));
			}

			// Solicitudes en curso
			List<DebtTmpDTO> inProgresRequest = summaryDebtsDAO.getAllInProgresRequest(spid);
			queryProducts.getProductsByClientDTO().put("inProgresRequest", inProgresRequest);
			logger.logDebug("documentId---------->" + documentId);
			// Llamada Genérica a Servicios Externos
			List<Dtos> dtos = administratorDAO.getByDefaultProductAdministrator("OPSE");
			for (Dtos dto : dtos) {
				if (dto != null && dto.getMnemonic() != null && !dto.getMnemonic().equals("OPSE")) {
					ExternalExtractor obj = new ExternalExtractor();
					@SuppressWarnings("unchecked")
					List<SummaryOtherDTO> otherProducts = (List<SummaryOtherDTO>) obj
							.getObject("(extservice.type=" + dto.getDtoName() + ")", customer, documentId);
					queryProducts.getProductsByClientDTO().put(dto.getDtoName(), otherProducts);
				}
			}

			summaryProductDTO.setTotalAmountProduct(totalAmountProduct);
			summaryProductDTO.setTotalProduct(count);
			queryProducts.getProductsByClientDTO().put("otherProducts", summaryProductDTO);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300011, "An error occurred at getting products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getOthers"));
		}
	}

	public void getOthersHis(List<ProductAdministratorDTO> productsAdministrator, SummaryIdDTO key, int spid, int customer,
			ProductsByClientDTO queryProducts) {
		try {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.001", "getOthersHis"));

			// Llamada Genérica a Servicios Externos
			List<Dtos> dtos = administratorDAO.getByDefaultProductAdministrator("OPSEH");
			for (Dtos dto : dtos) {
				if (dto != null && dto.getMnemonic() != null && !dto.getMnemonic().equals("OPSEH")) {
					ExternalExtractor obj = new ExternalExtractor();
					@SuppressWarnings("unchecked")
					List<SummaryOtherDTO> otherProducts = (List<SummaryOtherDTO>) obj
							.getObject("(extservice.type=" + dto.getDtoName() + ")", customer);
					queryProducts.getProductsByClientDTO().put(dto.getDtoName(), otherProducts);
				}
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("QUERYPRODUCTSMANAGER.003"), ex);
			throw new BusinessException(7300016, "An error occurred at getting history products by client ID.");
		} finally {
			logger.logDebug(MessageManager.getString("QUERYPRODUCTSMANAGER.002", "getOthersHis"));
		}
	}

	public List<SummaryInvestmentsDTO> checkProductByRol(List<SummaryInvestmentsDTO> allCurrentAccount,
			List<ProductAdministratorDTO> productsAdministrator) {
		List<SummaryInvestmentsDTO> summaryInvestmentsCheck = new ArrayList<SummaryInvestmentsDTO>();
		SummaryInvestmentsDTO summaryInvestmentCheck;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {

			for (SummaryInvestmentsDTO summaryInvestmentsDTO : allCurrentAccount) {
				String productType = (summaryInvestmentsDTO.getProduct() == null) ? " "
						: summaryInvestmentsDTO.getProduct().trim();
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(productType)) {
					summaryInvestmentCheck = summaryInvestmentsDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							summaryInvestmentCheck.setOperationNumber("**********");
						}

					} else {
						summaryInvestmentCheck = null;
					}
					if (summaryInvestmentCheck != null) {
						summaryInvestmentsCheck.add(summaryInvestmentCheck);
					}

				}

			}

		}

		return summaryInvestmentsCheck;
	}

	public String getWarrantyType(String state, String mnemonic) {
		String product = " ";

		if (mnemonic == "GAR") {
			product = (state.trim().equalsIgnoreCase("P") || state.trim().equalsIgnoreCase("X")
					|| state.trim().equalsIgnoreCase("C")) ? "GAPP" : product;
		}
		if (mnemonic == "GARC") {
			product = (state.trim().equalsIgnoreCase("P") || state.trim().equalsIgnoreCase("X")
					|| state.trim().equalsIgnoreCase("C")) ? "GDCP" : product;
		}

		product = (state.trim().equalsIgnoreCase("V") || state.trim().equalsIgnoreCase("F") || state.trim().equalsIgnoreCase("C"))
				? mnemonic : product;

		return product;
	}

	public List<WarrantyTmpDTO> checkProductByRolWarranties(List<WarrantyTmpDTO> warranties,
			List<ProductAdministratorDTO> productsAdministrator) {
		logger.logDebug("checkProductByRolWarranties: "+warranties.size());
		List<WarrantyTmpDTO> warrantiesCheck = new ArrayList<WarrantyTmpDTO>();
		WarrantyTmpDTO warrantyCheck;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {
			for (WarrantyTmpDTO warrantyDTO : warranties) {
				String warrantyType = (warrantyDTO.getStateCode() == null) ? " " : warrantyDTO.getStateCode();
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(getWarrantyType(warrantyType, "GAR"))
						&& !warrantiesCheck.contains(warrantyDTO)) {
					warrantyCheck = warrantyDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							warrantyCheck.setCode("**********");
						}

					} else {
						warrantyCheck = null;
					}
					if (warrantyCheck != null) {
						warrantiesCheck.add(warrantyCheck);
					}

				}

			}

		}

		return warrantiesCheck;
	}

	public List<OwnWarrantyTmpDTO> checkProductWarrantiesOwn(List<OwnWarrantyTmpDTO> warranties,
			List<ProductAdministratorDTO> productsAdministrator) {
		List<OwnWarrantyTmpDTO> summaryDebtsCheck = new ArrayList<OwnWarrantyTmpDTO>();
		OwnWarrantyTmpDTO ownWarrantycheck;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {

			for (OwnWarrantyTmpDTO ownWarranty : warranties) {
				String warrantyType = (ownWarranty.getStateCode() == null) ? " " : ownWarranty.getStateCode().trim();
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(getWarrantyType(warrantyType, "GARC"))) {
					ownWarrantycheck = ownWarranty;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							ownWarrantycheck.setCode("**********");
						}

					} else {
						ownWarrantycheck = null;
					}
					if (ownWarrantycheck != null) {
						summaryDebtsCheck.add(ownWarrantycheck);
					}

				}

			}

		}

		return summaryDebtsCheck;
	}

	public String getOverdraftsType(String getNumberOperation, String mnemonic) {
		String productType;
		if (mnemonic.trim().equals("CEX")) {
			productType = (getNumberOperation.trim().length() == 0) ? "CEXA" : "CEX";
			return productType;
		} else {
			return mnemonic;
		}

	}

	public List<SummaryDebtsDTO> checkProductByRolOverdrafts(List<SummaryDebtsDTO> sumaryDebts,
			List<ProductAdministratorDTO> productsAdministrator, String productType) {
		List<SummaryDebtsDTO> summaryDebtsCheck = new ArrayList<SummaryDebtsDTO>();
		SummaryDebtsDTO summaryDebtCheck;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {
			for (SummaryDebtsDTO summaryDebtsDTO : sumaryDebts) {
				String wOverdraftsType = (summaryDebtsDTO.getNumberOperation() == null) ? " "
						: summaryDebtsDTO.getNumberOperation();
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim()
								.equalsIgnoreCase(getOverdraftsType(wOverdraftsType, productType))
						&& !summaryDebtsCheck.contains(summaryDebtsDTO)) {
					summaryDebtCheck = summaryDebtsDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							summaryDebtCheck.setNumberOperation("**********");
						}

					} else {
						summaryDebtCheck = null;
					}
					if (summaryDebtCheck != null) {
						summaryDebtsCheck.add(summaryDebtCheck);
					}

				}

			}

		}

		return summaryDebtsCheck;
	}

	private List<SummaryDebtsDTO> checkProductByRolDebtsLoans(List<SummaryDebtsDTO> debtsLoans,
			List<ProductAdministratorDTO> productsAdministrator, String typeP) {
		// TODO Auto-generated method stub
		logger.logDebug("checkProductByRolDebtsLoans" + debtsLoans == null ? 0 : debtsLoans.size());
		List<SummaryDebtsDTO> debtsLoansCheck = new ArrayList<SummaryDebtsDTO>();
		SummaryDebtsDTO debtLoansCheck;
		if (typeP != null) {
			for (ProductAdministratorDTO productAdministrator : productsAdministrator) {

				for (SummaryDebtsDTO debtsLoanDTO : debtsLoans) {

					if (productAdministrator.getMnemonic() != null
							&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(typeP)) {
						debtLoansCheck = debtsLoanDTO;
						Byte on = new Byte("1");

						if (productAdministrator.getVisible().equals(on)) {
							if (productAdministrator.getEncrypted().equals(on) && debtLoansCheck.getNumberOperation() != null
									&& !debtLoansCheck.getNumberOperation().trim().equals("")) {
								debtLoansCheck.setNumberOperation("**********");
							}

						} else {
							debtLoansCheck = null;
						}

						if (debtLoansCheck != null) {
							debtsLoansCheck.add(debtLoansCheck);
						}

					}

				}

			}
		}
		return debtsLoansCheck;
	}

	private List<DebtTmpDTO> checkProductByRolIndirects(List<DebtTmpDTO> debtsLoans,
			List<ProductAdministratorDTO> productsAdministrator, String typeP) {
		// TODO Auto-generated method stub
		List<DebtTmpDTO> debtsLoansCheck = new ArrayList<DebtTmpDTO>();
		DebtTmpDTO debtLoansCheck;
		if (typeP != null) {
			for (ProductAdministratorDTO productAdministrator : productsAdministrator) {

				for (DebtTmpDTO debtsLoanDTO : debtsLoans) {
					if (productAdministrator.getMnemonic() != null
							&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(typeP)) {
						debtLoansCheck = debtsLoanDTO;
						Byte on = new Byte("1");
						if (productAdministrator.getVisible().equals(on)) {
							if (productAdministrator.getEncrypted().equals(on)) {
								debtLoansCheck.setOperation("**********");
							}

						} else {
							debtLoansCheck = null;
						}
						if (debtLoansCheck != null) {
							debtsLoansCheck.add(debtLoansCheck);
						}

					}

				}

			}
		}
		return debtsLoansCheck;
	}

	private List<SummaryCreditsDTO> checkProductCredits(List<SummaryCreditsDTO> credits,
			List<ProductAdministratorDTO> productsAdministrator) {
		// TODO Auto-generated method stub
		List<SummaryCreditsDTO> creditLinesCheck = new ArrayList<SummaryCreditsDTO>();
		SummaryCreditsDTO creditLineCheck;
		String productType = null;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {

			for (SummaryCreditsDTO summaryInvestmentsDTO : credits) {
				productType = (summaryInvestmentsDTO.getLineNumber().equals(null)) ? " " : summaryInvestmentsDTO.getLineNumber();
				productType = (productType.trim().length() == 0) ? "LCAP" : "CRE";

				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(productType)) {
					creditLineCheck = summaryInvestmentsDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							creditLineCheck.setLineNumber("**********");
						}

					} else {
						creditLineCheck = null;
					}
					if (creditLineCheck != null) {
						creditLinesCheck.add(creditLineCheck);
					}

				}

			}

		}

		return creditLinesCheck;
	}

	private List<SummaryOtherDTO> checkProductByRolOthers(List<SummaryOtherDTO> others,
			List<ProductAdministratorDTO> productsAdministrator, String productT) {
		// TODO Auto-generated method stub
		List<SummaryOtherDTO> othersDTOCheck = new ArrayList<SummaryOtherDTO>();
		SummaryOtherDTO otherDTOCheck;

		// ECA: Obtener los catalogos de ce_tipo_garantia y ce_clase_grb
		List<Catalog> tipoGarantias = catalogDAO.getCatalogsByName("ce_tipo_garantia");

		List<Catalog> claseGrbs = catalogDAO.getCatalogsByName("ce_clase_grb");

		for (SummaryOtherDTO othersDTO : others) {
			if (othersDTO.getSubTypeId() != null && !othersDTO.getSubTypeId().isEmpty()) {
				for (Catalog tipoGarantia : tipoGarantias) {
					if (tipoGarantia.getCode().equals(othersDTO.getSubTypeId().trim()) && !claseGrbs.contains(othersDTO)) {
						othersDTO.setSubType(tipoGarantia.getValue());
					}
				}
			}
			if (othersDTO.getWarrantyClassId() != null && !othersDTO.getWarrantyClassId().isEmpty()) {
				for (Catalog claseGrb : claseGrbs) {
					if (claseGrb.getCode().equals(othersDTO.getWarrantyClassId().trim()) && !claseGrbs.contains(othersDTO)) {
						othersDTO.setWarrantyClass(claseGrb.getValue());
					}
				}
			}
		} // ECA

		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {
			for (SummaryOtherDTO othersDTO : others) {
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(productT)
						&& !claseGrbs.contains(othersDTO)) {
					otherDTOCheck = othersDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						if (productAdministrator.getEncrypted().equals(on)) {
							otherDTOCheck.setNumberOperation("**********");
						}

					} else {
						otherDTOCheck = null;
					}
					if (otherDTOCheck != null) {
						othersDTOCheck.add(otherDTOCheck);
					}

				}

			}

		}

		return othersDTOCheck;
	}

	private List<AffiliateDTO> checkProductByRolAffiliations(List<AffiliateDTO> affiliations,
			List<ProductAdministratorDTO> productsAdministrator, String productT) {
		// TODO Auto-generated method stub
		List<AffiliateDTO> affiliationsDTOCheck = new ArrayList<AffiliateDTO>();
		AffiliateDTO affiliationDTOCheck;
		for (ProductAdministratorDTO productAdministrator : productsAdministrator) {
			for (AffiliateDTO affiliationDTO : affiliations) {
				if (productAdministrator.getMnemonic() != null
						&& productAdministrator.getMnemonic().trim().equalsIgnoreCase(productT)
						&& !affiliationsDTOCheck.contains(affiliationDTO)) {
					affiliationDTOCheck = affiliationDTO;
					Byte on = new Byte("1");
					if (productAdministrator.getVisible().equals(on)) {
						affiliationsDTOCheck.add(affiliationDTOCheck);
					} else {
						affiliationDTOCheck = null;

					}

				}

			}
		}
		return affiliationsDTOCheck;
	}

	/*
	 * Getters & Setters
	 */

	public SummaryInvestmentsDAO getSummaryInvestmentsDAO() {
		return summaryInvestmentsDAO;
	}

	public void setSummaryInvestmentsDAO(SummaryInvestmentsDAO summaryInvestmentsDAO) {
		this.summaryInvestmentsDAO = summaryInvestmentsDAO;
	}

	public SummaryDebtsDAO getSummaryDebtsDAO() {
		return summaryDebtsDAO;
	}

	public void setSummaryDebtsDAO(SummaryDebtsDAO summaryDebtsDAO) {
		this.summaryDebtsDAO = summaryDebtsDAO;
	}

	public SummaryWarrantiesDAO getSummaryWarrantiesDAO() {
		return summaryWarrantiesDAO;
	}

	public void setSummaryWarrantiesDAO(SummaryWarrantiesDAO summaryWarrantiesDAO) {
		this.summaryWarrantiesDAO = summaryWarrantiesDAO;
	}

	public SummaryCreditsDAO getSummaryCreditsDAO() {
		return summaryCreditsDAO;
	}

	public void setSummaryCreditsDAO(SummaryCreditsDAO summaryCreditsDAO) {
		this.summaryCreditsDAO = summaryCreditsDAO;
	}

	public SummaryOthersDAO getSummaryOthersDAO() {
		return summaryOthersDAO;
	}

	public void setSummaryOthersDAO(SummaryOthersDAO summaryOthersDAO) {
		this.summaryOthersDAO = summaryOthersDAO;
	}

	public AffiliationsDAO getAffiliationsDAO() {
		return affiliationsDAO;
	}

	public void setAffiliationsDAO(AffiliationsDAO affiliationsDAO) {
		this.affiliationsDAO = affiliationsDAO;
	}

	public CatalogDAO getCatalogDAO() {
		return catalogDAO;
	}

	public void setCatalogDAO(CatalogDAO catalogDAO) {
		this.catalogDAO = catalogDAO;
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public CurrencyDAO getCurrencyDAO() {
		return currencyDAO;
	}

	public void setCurrencyDAO(CurrencyDAO currencyDAO) {
		this.currencyDAO = currencyDAO;
	}

}
