/**
 * 
 */
package com.cobiscorp.ecobis.customer.bl;

import java.util.List;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;


/**
 * @author jmoreta
 *Interface Manager of Nationality 
 */
public interface NationalityManager {
	
	public List<NationalityResponse> getNationality(NationalityResponse request);
}
