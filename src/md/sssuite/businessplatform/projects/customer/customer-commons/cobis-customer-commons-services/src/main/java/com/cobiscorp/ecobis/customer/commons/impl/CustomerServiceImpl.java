package com.cobiscorp.ecobis.customer.commons.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.commons.CustomerService;
import com.cobiscorp.ecobis.customer.commons.bl.CustomerManager;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;

public class CustomerServiceImpl implements CustomerService {

	public CustomerManager customerManager;

	private static ILogger logger = LogFactory.getLogger(CustomerServiceImpl.class);

	/* Getters y Setters */
	public CustomerManager getCustomerManager() {
		return customerManager;
	}

	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#getCustomerType
	 */
	public String getCustomerType(Integer customerCode) {
		try {
			logger.logDebug("Inicia getCustomerType");
			return customerManager.getCustomerType(customerCode);
		} finally {
			logger.logDebug("Inicia getCustomerType");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#getQueryClientAddress
	 * (java.lang.Integer)
	 */
	public List<CustomerAddressDTO> getQueryClientAddress(Integer customerCode) {
		try {
			logger.logDebug("Inicia getQueryClientAddress");
			return customerManager.getQueryCustomerAddress(customerCode);
		} finally {
			logger.logDebug("Inicia getQueryClientAddress");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#getQueryLegalClient
	 * (java.lang.Integer)
	 */
	public CustomerDTO getQueryLegalClient(Integer customerCode) {
		try {
			logger.logDebug("Inicia getQueryLegalClient");
			return customerManager.getQueryLegalClient(customerCode);
		} finally {
			logger.logDebug("Inicia getQueryLegalClient");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#queryGroup(com.
	 * cobiscorp .ecobis.clientviewer.dto.GroupInput)
	 */
	public List<EconomicGroupDTO> queryGroup(SearchGroupDTO searchGroup) {

		List<EconomicGroupDTO> groups = null;
		logger.logInfo("**********SEARCH GROUP" + searchGroup);

		if (searchGroup.getGroupName() != null) {

			if (searchGroup.getGroupName().trim() != "") {

				groups = getGroupByName(searchGroup.getGroupName());
			}
		} else {
			groups = getGroupById(searchGroup.getGroupCode(), searchGroup.getSearchValue());
		}

		return groups;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#queryGroup(com.
	 * cobiscorp .ecobis.clientviewer.dto.GroupInput)
	 */
	
	public List<EconomicGroupDTO> getGroupsByParameters(SearchGroupDTO searchGroup) {
		try {
			logger.logDebug("Inicia getGroupsByParameters");
			return customerManager.getGroupsByParameters(searchGroup);
		} finally {
			logger.logDebug("Fin getGroupsByParameters");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#getGroupByName(java
	 * .lang.String)
	 */
	private List<EconomicGroupDTO> getGroupByName(String groupName) {
		try {
			logger.logDebug("Inicia getGroupByName");
			return customerManager.getGroupByName(groupName);
		} finally {
			logger.logDebug("Inicia getGroupByName");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#getGroupByName(java
	 * .lang.Integer, java.lang.String)
	 */
	private List<EconomicGroupDTO> getGroupById(Integer groupId, String groupValue) {
		try {
			logger.logDebug("Inicia getGroupById");
			return customerManager.getGroupById(groupId, groupValue);
		} finally {
			logger.logDebug("Inicia getGroupById");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#getGroupMembers
	 */
	public List<CustomerDTO> getGroupMembers(Integer group) {
		try {
			logger.logDebug("Inicia getGroupMembers");
			return customerManager.getGroupMembers(group);
		} finally {
			logger.logDebug("Fin getGroupMembers");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#getGroupDetail
	 */
	public EconomicGroupDTO getGroupDetail(Integer groupCode, String type) {
		try {
			logger.logDebug("Inicia getGroupMembers");
			return customerManager.getGroupDetail(groupCode, type);
		} finally {
			logger.logDebug("Fin getGroupMembers");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#queryClientRate(java
	 * .lang.Integer)
	 */
	public List<CustomerScoreDTO> queryClientRate(Integer customerCode) {
		try {
			logger.logDebug("Inicia queryClientRate");
			return customerManager.getCustomerScoreHis(customerCode);
		} finally {
			logger.logDebug("Fin queryClientRate");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.CustomerService#queryClient(java.lang
	 * .Integer)
	 */
	public CustomerDTO queryClient(Integer customerCode) {
		try {
			logger.logDebug("Inicia queryClient");
			return customerManager.getCustomer(customerCode);
		} finally {
			logger.logDebug("Fin queryClient");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#
	 * getCustomersByParameters
	 * (com.cobiscorp.ecobis.clientviewer.dto.SearchCustomerDTO)
	 */
	public List<CustomerDTO> getCustomersByParameters(SearchCustomerDTO searchCustomer) {
		try {
			logger.logDebug("Inicia getCustomersByParameters");
			return customerManager.getCustomerByParameters(searchCustomer);
		} finally {
			logger.logDebug("Fin getCustomersByParameters");
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.CustomerService#
	 * getCustomersByParameters
	 * (com.cobiscorp.ecobis.clientviewer.dto.SearchCustomerDTO)
	 */
	public List<CustomerDTO> getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer) {
		try {
			logger.logDebug("Inicia getCustomersByAutoCompleteText");
			return customerManager.getCustomersByAutoCompleteText(searchCustomer);
		} finally {
			logger.logDebug("Fin getCustomersByAutoCompleteText");
		}
	}

	/**
	 * verifica si existe una columna
	 */

	@Override
	public TableDTO checkColumnExist(String database, String table, String column) {
		try {
			logger.logDebug("Inicia checkColumnExist");
			return customerManager.checkColumnExist(database, table, column);
		} finally {
			logger.logDebug("Fin checkColumnExist");
		}
	}
	

}
