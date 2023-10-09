package com.cobis.cloud.lcr.b2b.service.utils;

import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveCustomerRequest;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.service.dto.Coordenadas;
import com.cobiscorp.ecobis.cloud.service.dto.client.CollectiveCustomer;
import java.util.Calendar;
import java.util.Date;



public class Util
{
  
  private static final ILogger LOGGER = LogFactory.getLogger(Util.class);
  
  public static CollectiveCustomerRequest setValuesToCollectiveCustomer(CollectiveCustomer collectiveCustomer, Integer customerId,Coordenadas co) throws Exception {
    CollectiveCustomerRequest collectiveCustomerRequest = new CollectiveCustomerRequest();
    if (LOGGER.isDebugEnabled())
      LOGGER.logInfo("Start method setValuesToCollectiveCustomer"); 
    try {
      collectiveCustomerRequest.setCustomerId(customerId);
      collectiveCustomerRequest.setBirthCountry(collectiveCustomer.getBirthCountry());
      collectiveCustomerRequest.setNationality(collectiveCustomer.getNationality());
      collectiveCustomerRequest.setBirthEntity(collectiveCustomer.getBirthEntity());
      collectiveCustomerRequest.setCivilStatus(collectiveCustomer.getCivilStatus());
      collectiveCustomerRequest.setNumberOfChildren(collectiveCustomer.getNumberOfChildren());
      
      collectiveCustomerRequest.setSpouseFirstName(collectiveCustomer.getSpouseFirstName());
      collectiveCustomerRequest.setSpouseSecondName(collectiveCustomer.getSpouseSecondName());
      collectiveCustomerRequest.setSpouseSurname(collectiveCustomer.getSpouseSurname());
      collectiveCustomerRequest.setSpouseSecondSurname(collectiveCustomer.getSpouseSecondSurname());
      
      if (collectiveCustomer.getSpouseBirthdate() != null) {
        Calendar calendar = Calendar.getInstance();
        Date date = new Date();
        date.setTime(collectiveCustomer.getSpouseBirthdate().longValue());
        calendar.setTime(date);
        collectiveCustomerRequest.setSpouseBirthdate(calendar);
      } 
      collectiveCustomerRequest.setOcupation(collectiveCustomer.getOcupation());
      collectiveCustomerRequest.setElectronicSignatureSerieNumber(collectiveCustomer.getElectronicSignatureSerieNumber());
      collectiveCustomerRequest.setIsPEP(collectiveCustomer.getIsPEP());
      collectiveCustomerRequest.setSpouseOrRelativeofPEP(collectiveCustomer.getSpouseOrRelativeofPEP());
      collectiveCustomerRequest.setCreditDestination(collectiveCustomer.getCreditDestination());
      collectiveCustomerRequest.setPaymentResources(collectiveCustomer.getPaymentResources());
      
      collectiveCustomerRequest.setCityOfDomicile(collectiveCustomer.getCityOfDomicile());
      collectiveCustomerRequest.setDomicileReference(collectiveCustomer.getDomicileReference());
      collectiveCustomerRequest.setIncome(collectiveCustomer.getIncome());
      collectiveCustomerRequest.setOtherIncome(collectiveCustomer.getOtherIncome());
      collectiveCustomerRequest.setBusinessExpenses(collectiveCustomer.getBusinessExpenses());
      collectiveCustomerRequest.setFamiliarExpenses(collectiveCustomer.getFamiliarExpenses());
      collectiveCustomerRequest.setIdAddress(co.getIdAddress());
      collectiveCustomerRequest.setLatitudeGeo(co.getLatitude());
      LOGGER.logDebug(" co.getLatitude() >> " +co.getLatitude());
      collectiveCustomerRequest.setLongitudeGeo(co.getLogitude());
      LOGGER.logDebug(" co.getLogitude() >> " +co.getLogitude());
      
    } finally {
      if (LOGGER.isDebugEnabled()) {
        LOGGER.logInfo("Finish method setValuesToCollectiveCustomer");
      }
    } 
    return collectiveCustomerRequest;
  }

  
  public static int validateSpouse(String parameterMarried, String civilStatus, String firstName, String surname, Date birthdate) {
    int valid = 0;
    if (!parameterMarried.equals(civilStatus)) {
      return valid;
    }
    if (firstName == null || "".equals(firstName)) {
      valid++;
    }
    if (surname == null || "".equals(surname)) {
      valid++;
    }
    if (birthdate == null) {
      valid++;
    }
    return valid;
  }
  
  public static int validateQuestion(String required, String answer) {
    int valid = 0;
    if ("S".equals(required) && (answer != null || !"".equals(answer))) {
      valid++;
    } else if ("N".equals(required) && (answer == null || "".equals(answer))) {
      valid++;
    } 
    
    return valid;
  }
}
