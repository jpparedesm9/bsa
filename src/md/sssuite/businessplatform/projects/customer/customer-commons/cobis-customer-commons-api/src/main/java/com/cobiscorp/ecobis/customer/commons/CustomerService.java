package com.cobiscorp.ecobis.customer.commons;

import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;

import java.util.List;

/*
 * This interface is implemented in CustomerServiceImpl
 */
public interface CustomerService {
	/**
	 * Method used to get customer type by the Client code.
	 * 
	 * @param customerCode
	 *            = Integer, it's the Customer code.
	 * @return A string with the type of customer.
	 */
	String getCustomerType(Integer customerCode);

	/**
	 * Method used to get all members of group
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A CustomerDTO object list , with information of members of group
	 */
	List<CustomerDTO> getGroupMembers(Integer group);

	/**
	 * Method to get a list of Customer's addresses by customer code.
	 * 
	 * @param idClient
	 *            it's a customer code for the consultation.
	 * @return a list of customers addresses.
	 */
	List<CustomerAddressDTO> getQueryClientAddress(Integer customerCode);

	/**
	 * Method used to get a economic group by the code.
	 * 
	 * @param searchGroup
	 *            it's the group to find.
	 * @return A list of economic group.
	 */
	List<EconomicGroupDTO> queryGroup(SearchGroupDTO searchGroup);

	/**
	 * Method used to get detail group by group code.
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A EconomicGroupDTO object with detailed information of group
	 */
	EconomicGroupDTO getGroupDetail(Integer groupCode, String type);

	/**
	 * Method used to get the Customer score.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A list with the customer score.
	 */
	List<CustomerScoreDTO> queryClientRate(Integer customerCode);

	/**
	 * Method used to get complete information for companies
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return A information list of the specific company.
	 */
	CustomerDTO getQueryLegalClient(Integer customerCode);

	/**
	 * Method used to get complete information of defined Customer.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A information list of the specific Customer.
	 */
	CustomerDTO queryClient(Integer customerCode);

	/**
	 * Method to get a list of Customers by parameters.
	 * 
	 * @param searchCustomer
	 *            it's a DTO used to send attributes such as: ComercialName,
	 *            ClientName, ClientLastName, ClientSecondLastName,
	 *            ClientSecondName, Sub_type, Type, ClientNumber, CedRuc,
	 *            ComercialName
	 * @return a List of CustomerDTO whit this information:
	 * @see SearchCustomerDTO
	 * @see CustomerDTO
	 */
	List<CustomerDTO> getCustomersByParameters(SearchCustomerDTO searchCustomer);

	/**
	 * Method to get a list of Customers by parameters.
	 * 
	 * @param searchCustomer
	 *            it's a DTO used to send attributes such as: ComercialName,
	 *            ClientName, ClientLastName, ClientSecondLastName,
	 *            ClientSecondName, Sub_type, Type, ClientNumber, CedRuc,
	 *            ComercialName
	 * @return a List of CustomerDTO whit this information:
	 * @see SearchCustomerDTO
	 * @see CustomerDTO
	 */
	List<CustomerDTO> getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer);
	
	/**
	 * Verifica si existe una columna para realizar la búsqueda por esta columna
	 * o no
	 * 
	 */
	public TableDTO checkColumnExist(String database, String table, String column);
	
	/**
	 * Method to get a list of Groups by parameters.
	 * 
	 * @param searchGroup
	 *            it's a DTO used to send attributes such as: ComercialName,
	 *            ClientName, ClientLastName, ClientSecondLastName,
	 *            ClientSecondName, Sub_type, Type, ClientNumber, CedRuc,
	 *            ComercialName
	 * @return a List of GroupDTO whit this information:
	 * @see SearchGroupDTO
	 * @see GroupDTO
	 */
	List<EconomicGroupDTO> getGroupsByParameters(SearchGroupDTO searchGroup);
}
