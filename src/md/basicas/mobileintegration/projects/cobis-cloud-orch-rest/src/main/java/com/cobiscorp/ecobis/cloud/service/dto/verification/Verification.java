package com.cobiscorp.ecobis.cloud.service.dto.verification;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.geolocation.GeoReference;

import java.util.List;

public class Verification extends VerificationBase<Question> {

    private GeoReference businessAddressGeoReference;
    private GeoReference homeAddressGeoReference;
    private GeoReference officialGeoReference;
    

    public GeoReference getOfficialGeoReference() {
		return officialGeoReference;
	}

	public void setOfficialGeoReference(GeoReference officialGeoReference) {
		this.officialGeoReference = officialGeoReference;
	}


    public GeoReference getBusinessAddressGeoReference() {
		return businessAddressGeoReference;
	}

	public void setBusinessAddressGeoReference(GeoReference businessAddressGeoReference) {
		this.businessAddressGeoReference = businessAddressGeoReference;
	}

	public void setHomeAddressGeoReference(GeoReference geoReference) {
	this.homeAddressGeoReference = geoReference;
    }

    public GeoReference getHomeAddressGeoReference() {
	return homeAddressGeoReference;
    }
    
    public DataVerificationRequest toRequest() {
        DataVerificationRequest request = new DataVerificationRequest();

        request.setApplicationCode(getApplicationId());
        request.setCustomerId(getCustomerId());
        request.setAnswer(toListString(getQuestions()));
        request.setMode(isGroup() ? GROUP_MODE : PERSONAL_MODE);
	if (businessAddressGeoReference != null) {
	    request.setBusinessLatitude(businessAddressGeoReference.getLatitude());
	    request.setBusinessLongitude(businessAddressGeoReference.getLongitude());
	}
	if(homeAddressGeoReference != null) {
	    request.setHomeLatitude(homeAddressGeoReference.getLatitude());
	    request.setHomeLongitude(homeAddressGeoReference.getLongitude());
	}
        return request;
    }

    private String toListString(List<Question> questionList) {
        StringBuilder answer = new StringBuilder();

        for (Question q : questionList) {
            if (q.getAnswer() != null) {
                answer.append(q.getAnswer().trim());
                answer.append(";");
            }
        }
        return answer.toString().substring(0, answer.length() - 1);
    }
}
