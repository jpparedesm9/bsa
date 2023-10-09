package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerBase;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.isNullOrEmpty;

/**
 * @author Cesar Loachamin
 */
public class Prospect extends CustomerBase {
	private String expirationDate; // calendar
	private String emailAddress;
	private String rfc;

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public NaturalProspectRequest toProspectRequest() {
		NaturalProspectRequest request = new NaturalProspectRequest();
		request.setProspectId(getCustomerId());
		request.setFirstName(getFirstName());
		request.setSurname(getSurname());
		request.setSecondName(getSecondName());
		request.setSecondSurname(getSecondSurname());
		request.setDocumentNumber(getDocumentNumber());
		request.setDocumentType(getDocumentType());
		request.setGender(getGender().charAt(0));
		// request.setEmailAddress(emailAddress);
		request.setCityBirth(getCityBirth());
		request.setNumCycles(0);
		request.setMaritalStatus(getMaritalStatus());
		request.setBirthDate(CalendarUtil.fromISOTime(getBirthDate()));
		request.setExpirationDate(CalendarUtil.fromISOTime(expirationDate));
		// request.setFilial(SessionUtil.getFilial()); TODO:Check this
		request.setFilial(1);
		request.setOffice(SessionUtil.getOffice());
		request.setOfficial(SessionUtil.getUser());
		request.setBioIdentificationType(getBioIdentificationType());
		request.setBioCIC(getBioCIC());
		request.setBioOCR(getBioOCR());
		request.setBioEmissionNumber(getBioEmissionNumber());
		request.setBioReaderKey(getBioReaderKey());
		request.setBioHasFingerprinter(getBioHasFingerprint() != null ? getBioHasFingerprint().charAt(getBioHasFingerprint().length() - 1) : null);
		request.setCollective(getCollective());
		request.setCollectiveLevel(getCollectiveClientLevel());
		request.setRegisterYear(getRegisterYear());
		request.setEmissionYear(getEmissionYear());
		return request;
	}

	public static Prospect fromResponse(CustomerResponse prospect, int customerId) {
		if (prospect == null) {
			return null;
		}
		Prospect obj = new Prospect();
		obj.fillFromResponse(prospect, customerId);
		if (!isNullOrEmpty(prospect.getExpirationDate())) {
			obj.expirationDate = CalendarUtil.toISOTime(prospect.getExpirationDate());
		}
		obj.rfc = prospect.getCustomerRFC();
		return obj;
	}

	@Override
	public CustomerTotalRequest toRequest() {
		CustomerTotalRequest request = super.toRequest();
		request.setExpirationDate(CalendarUtil.fromISOTime(expirationDate));
		return request;
	}
}
