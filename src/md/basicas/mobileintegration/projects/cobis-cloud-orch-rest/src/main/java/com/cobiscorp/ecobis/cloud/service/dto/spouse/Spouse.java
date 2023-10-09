package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectResponse;

import com.cobiscorp.ecobis.cloud.service.dto.prospect.Prospect;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;

public class Spouse {

    private int spouseId;
    private String firstName;
    private String secondName;
    private String surname;
    private String secondSurname;
    private String birthDate;
    private String gender;
    private int cityBirth;
    private String rfc;
    private String phone;
    

    public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getSpouseId() {
        return spouseId;
    }

    public void setSpouseId(int spouseId) {
        this.spouseId = spouseId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getSecondSurname() {
        return secondSurname;
    }

    public void setSecondSurname(String secondSurname) {
        this.secondSurname = secondSurname;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getCityBirth() {
        return cityBirth;
    }

    public void setCityBirth(int cityBirth) {
        this.cityBirth = cityBirth;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public static Spouse fromResponse(CustomerResponse response) {
        if (response == null) {
            return null;
        }
        Spouse spouse = new Spouse();
        spouse.setSpouseId(response.getCustomerId());
        spouse.setFirstName(response.getCustomerName());
        spouse.setSecondName(response.getCustomerSecondName());
        spouse.setSurname(response.getCustomerLastName());
        spouse.setSecondSurname(response.getCustomerSecondLastName());
        spouse.setBirthDate(CalendarUtil.toISOTime(response.getCustomerBirthdate()));
        spouse.setGender(response.getGender() == null ? null : response.getGender().charAt(0) + "");
        spouse.setCityBirth(response.getCountyOfBirth());
        spouse.setRfc(response.getCustomerRFC());
        return spouse;
    }
    
    public static Spouse fromResponse(SpouseProspectResponse response) {
        if (response == null) {
            return null;
        }
        Spouse spouse = new Spouse();
        spouse.setSpouseId(response.getProspectId());
        spouse.setFirstName(response.getFirstName());
        spouse.setSecondName(response.getSecondName());
        spouse.setSurname(response.getSurname());
        spouse.setSecondSurname(response.getSecondSurname());
        spouse.setBirthDate(CalendarUtil.toISOTime(response.getBirthDate()));
        spouse.setGender(response.getGender() == null ? null : response.getGender().toString());
        spouse.setRfc(response.getDocumentNumber());
        spouse.setPhone(response.getPhone());
        return spouse;
    }
    
    public SpouseProspectRequest toRequest(int customerCode) {
    	SpouseProspectRequest spouseProspectRequest = new SpouseProspectRequest();
    	
    	spouseProspectRequest.setPersonSecuencial(customerCode);
		spouseProspectRequest.setProspectId(this.getSpouseId());
		spouseProspectRequest.setFirstName(this.getFirstName());
		spouseProspectRequest.setSecondName(this.getSecondName());
		spouseProspectRequest.setSurname(this.getSurname());
		spouseProspectRequest.setSecondSurname(this.getSecondSurname());
		spouseProspectRequest.setPhone(this.getPhone());
		spouseProspectRequest.setBirthDate(CalendarUtil.from(this.getBirthDate()));
    	
    	return spouseProspectRequest;
    }
    

    public Prospect toProspect() {
        return toProspect(null);
    }

    public Prospect toProspect(String maritalStatus) {
        Prospect obj = new Prospect();
        obj.setCustomerId(getSpouseId());
        obj.setFirstName(getFirstName());
        obj.setSecondName(getSecondName());
        obj.setSurname(getSurname());
        obj.setSecondSurname(getSecondSurname());
        obj.setBirthDate(getBirthDate());
        obj.setGender(getGender());
        if (maritalStatus != null) {
            obj.setMaritalStatus(maritalStatus);
        }
        obj.setDocumentNumber(getRfc());
        obj.setDocumentType("CURP");
        obj.setCityBirth(cityBirth);
        return obj;
    }

}
