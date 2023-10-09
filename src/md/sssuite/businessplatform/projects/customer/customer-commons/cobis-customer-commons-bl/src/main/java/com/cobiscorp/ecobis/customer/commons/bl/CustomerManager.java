package com.cobiscorp.ecobis.customer.commons.bl;

import java.util.List;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;

public interface CustomerManager {

	/**
	 * Method used to get customer type by the Client code.
	 * 
	 * @param customerCode
	 *            = Integer, it's the Customer code.
	 * @return A string with the type of customer.
	 */
	public String getCustomerType(Integer customerCode);

	/**
	 * Method used to get all members of group
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A CustomerDTO object list , with information of members of group
	 */
	public List<CustomerDTO> getGroupMembers(Integer groupCode);

	/**
	 * Method used to get a list of Customer Address by Customer ID.
	 * 
	 * @param customerCode
	 *            , it's a customer code for the consultation.
	 * @return a List of Customer Address
	 * @see getTypeAddress
	 */
	public List<CustomerAddressDTO> getQueryCustomerAddress(Integer customerCode);

	/**
	 * Method used to get a economic group by the name.
	 * 
	 * @param groupName
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public List<EconomicGroupDTO> getGroupByName(String groupName);

	/**
	 * Method used to get a economic group by the code.
	 * 
	 * @param groupId
	 *            it's the group to find.
	 * @param valueGroup
	 *            it's the value of economic group.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public List<EconomicGroupDTO> getGroupById(Integer groupId, String valueGroup);

	/**
	 * Method used to get detail group by group code.
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A EconomicGroupDTO object with detailed information of group
	 */
	public EconomicGroupDTO getGroupDetail(Integer groupCode, String type);

	/**
	 * Method used to get the Customer score.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A list with the customer score.
	 * @throws BusinessException.
	 */
	public List<CustomerScoreDTO> getCustomerScoreHis(Integer customerId);

	/**
	 * Method used to get complete information for companies
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return A information list of the specific company.
	 * @throws BusinessException
	 */
	public CustomerDTO getQueryLegalClient(Integer customerCode);

	/**
	 * Method used to get complete information of defined Customer.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A information list of the specific Customer.
	 */
	public CustomerDTO getNaturalClient(Integer customerId);

	/**
	 * Method used to get complete information of defined Customer.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A information list of the specific Customer.
	 */
	public CustomerDTO getCustomer(Integer customerId);

	/**
	 * Method used to define the query that it's going to be pass to get a
	 * customer by a parameter. It use the method execGetCustomersByParameters
	 * of the same class.
	 * 
	 * @param searchCustomer
	 *            It's a DTO used to get it's attributes: ComercialName,
	 *            ClientName, ClientLastName, ClientSecondLastName,
	 *            ClientSecondName, Sub_type, Type, ClientNumber, CedRuc,
	 *            ComercialName
	 * @return a list of CustomersDTO that meet the query conditions.
	 */

	public List<CustomerDTO> getCustomerByParameters(SearchCustomerDTO searchCustomer);

	/**
	 * Method used to define the query that it's going to be pass to get a
	 * customer by a parameter. It use the method execGetCustomersByParameters
	 * of the same class.
	 * 
	 * @param searchCustomer
	 *            It's a DTO used to get it's attributes: ComercialName,
	 *            ClientName, ClientLastName, ClientSecondLastName,
	 *            ClientSecondName, Sub_type, Type, ClientNumber, CedRuc,
	 *            ComercialName
	 * @return a list of CustomersDTO that meet the query conditions.
	 */

	public List<CustomerDTO> getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer);

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
