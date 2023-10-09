package com.cobiscorp.ecobis.customer.commons.dal;

import java.util.List;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.commons.dal.entities.Instance;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerAddressDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerScoreDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicActivityDTO;
import com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO;
import com.cobiscorp.ecobis.customer.commons.dto.OfficialDTO;
import com.cobiscorp.ecobis.customer.commons.dto.TableDTO;

public interface CustomerDAO {
	/**
	 * Method used to get customer type by the Client code.
	 * 
	 * @param customerCode
	 *            = Integer, it's the Customer code.
	 * @return A CustomerDTO object with the type of customer.
	 */
	public abstract CustomerDTO getCustomerType(Integer customerCode);

	/**
	 * Method used to get all members of group
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A CustomerDTO object list , with information of members of group
	 */
	public abstract List<CustomerDTO> getGroupMembers(Integer groupCode);

	/**
	 * Method used to get all customer addresses by the Client code.
	 * 
	 * @param idClient
	 *            it's the Client/Customer code.
	 * @return A list of Address of the Customer consultation.
	 */
	public abstract List<CustomerAddressDTO> getAllAddress(Integer idClient);

	/**
	 * Method used to get a economic group by the name.
	 * 
	 * @param groupName
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public abstract List<EconomicGroupDTO> getGroupValue(String groupName);

	/**
	 * Method used to get a economic group by the code.
	 * 
	 * @param groupId
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public abstract List<EconomicGroupDTO> getGroupLike(String groupId);

	/**
	 * Method used to get the Customer score.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A list with the customer score.
	 * @throws BusinessException.
	 */
	public abstract List<CustomerScoreDTO> getCustomerScore(Integer customerId);

	/**
	 * Method used to get detail group by group code.
	 * 
	 * @param groupCode
	 *            = Integer, it's the group code.
	 * @return A EconomicGroupDTO object with detailed information of group
	 */
	public abstract EconomicGroupDTO getGroupDetail(Integer groupCode, String type);

	/**
	 * Method used to obtain the information officer.
	 * 
	 * @param officerCode
	 *            = Integer, it's the officer code.
	 * @return A OfficialDTO object with information of officer
	 */
	public abstract OfficialDTO getOfficer(Integer officerCode);

	/**
	 * Method used to get complete information of defined Customer.
	 * 
	 * @param customerId
	 *            it's the Client/Customer code.
	 * @return A information list of the specific Customer.
	 * @throws BusinessException.
	 */
	public abstract CustomerDTO getCustomer(Integer customerId);

	/**
	 * Method that obtains the description of an especific activity.
	 * 
	 * @param activityCode
	 *            , It's an activity code.
	 * @return The activity to find.
	 */
	public abstract String getDescriptionActivity(String activityCode);

	/**
	 * Method that obtains the description of a specific economic group.
	 * 
	 * @param groupId
	 *            , It's an economic group code.
	 * @return The name of an economic group.
	 */
	public abstract String getNameGroup(Integer groupId);

	/**
	 * Method that obtains the official name.
	 * 
	 * @param officialId
	 *            , It's an official code.
	 * @return The official name.
	 */
	public abstract Object[] getOfficial(Integer officialId);

	/**
	 * Method that obtains the Nationality.
	 * 
	 * @param idCountry
	 *            , It's the country code.
	 * @return The Nationality.
	 */
	public abstract String getNationality(Integer idCountry);

	/**
	 * Method that obtains the description Country.
	 * 
	 * @param idCountry
	 *            , It's the country code.
	 * @return The description Country.
	 */
	public abstract String getDescriptionCountry(Integer idCountry);

	/**
	 * Method that obtains the description City.
	 * 
	 * @param idCity
	 *            , It's the city code.
	 * @return The city name.
	 */
	public abstract String getDescriptionCity(Integer idCity);

	/**
	 * Method that obtains the document Type.
	 * 
	 * @param codeDocument
	 *            , It's the document code.
	 * @return The description of the document Type.
	 */
	public abstract String getDocumentType(String codeDocument);

	/**
	 * Method used to execute a Native query SQL to get Customers by Parameters.
	 * 
	 * @param query
	 *            it's a string with the query defined.
	 * @param customerType
	 *            it's the customer type ([P]erson or [C]ompany).
	 * @return The list of customers who meet the query conditions. The
	 *         information customer that returns is: clientNumber, firstSurname,
	 *         secondSurname, marriedLastName, name, secondName, documentId,
	 *         documentType, official, descriptionOfficial, blocked, status,
	 *         isClient, descriptionStatus, and commercialName for company's
	 *         only.
	 * @see CustomerDTO
	 * @author lcorrales
	 */
	public abstract List<CustomerDTO> getCustomerByParameters(String queryWithoutParams, List<Object> params,String customerType);

	/**
	 * Method used to execute a Native query SQL to get Customers by Parameters.
	 * 
	 * @param query
	 *            it's a string with the query defined.
	 * @param customerType
	 *            it's the customer type ([P]erson or [C]ompany).
	 * @return The list of customers who meet the query conditions. The
	 *         information customer that returns is: clientNumber, firstSurname,
	 *         secondSurname, marriedLastName, name, secondName, documentId,
	 *         documentType, official, descriptionOfficial, blocked, status,
	 *         isClient, descriptionStatus, and commercialName for company's
	 *         only.
	 * @see CustomerDTO
	 * @author gvillamagua
	 */
	public abstract List<CustomerDTO> getCustomerByAutoCompleteText(String queryWithoutParams, List<Object> params,String customerType);

	/**
	 * Method used to get complete information for companies
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return A information list of the specific company.
	 * @throws BusinessException
	 */
	public abstract CustomerDTO getAllLegalClient(Integer customerCode);

	/**
	 * Method that returns 1 if there is a customer according to the code.
	 * 
	 * @param customerCode
	 *            , It's the Client/Customer code.
	 * @return zero or one
	 */
	public abstract Long countCustomer(Integer customerCode);

	/**
	 * Method that returns 1 if there is a economic group according to the code.
	 * 
	 * @param groupCode
	 *            , It's the economic group code.
	 * @return zero or one.
	 */
	public abstract Long countEconomicGroup(Integer groupCode);

	/**
	 * Method that returns the member code of a economic group.
	 * 
	 * @param customerCode
	 *            , It's the Client/Customer code.
	 * @return Member code of a economic group.
	 */
	public abstract List<Integer> getCodeGroupMembersByCustomer(Integer customerCode);

	/**
	 * Method that returns 1 if there is a customer and economic group according
	 * to the code.
	 * 
	 * @param customerCode
	 *            , It's the Client/Customer code.
	 * @param groupCode
	 *            , It's the economic group code.
	 * @return zero or one.
	 */
	public abstract Long countCustomerGroup(Integer customerCode, Integer groupCode);

	/**
	 * Method used to get complete information for economic activities
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return A information list of the economic activities.
	 * @throws BusinessException
	 */
	public abstract List<EconomicActivityDTO> getEconomicActivitiesByCustomer(Integer customerCode);

	/**
	 * Method used to get complete information for Couple
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return Full Name Couple, Name Relation
	 * @throws BusinessException
	 */
	public abstract Instance getCustomerCouple(Integer customerCode);

	/**
	 * Method used to get complete information for Customer Groups
	 * 
	 * @param customerCode
	 *            it's the Client/Customer code.
	 * @return A information list of the Customer Groups.
	 * @throws BusinessException
	 */
	public abstract List<EconomicGroupDTO> getCustomerGroupsByCustomer(Integer customerCode);

	/**
	 * 
	 * @param string
	 * @return
	 */
	public abstract TableDTO getCheckColumnExist(String queryWithoutParams, List<Object> params);

	/**
	 * Method used to get a economic group by code.
	 * 
	 * @param groupName
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public abstract List<EconomicGroupDTO> getGroupByCode(int groupCode, String type);

	/**
	 * Method used to get a economic group by name.
	 * 
	 * @param groupName
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public abstract List<EconomicGroupDTO> getGroupByName(int size, String groupName, String type);

	/**
	 * Method used to get a economic group by the name and last value.
	 * 
	 * @param groupName
	 *            it's the group to find.
	 * @return A list of economic group.
	 * @throws BusinessException.
	 */
	public abstract List<EconomicGroupDTO> getNextGroupByName(int size, String groupName, String lastValue, String type);

}
