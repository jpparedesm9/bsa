/**
 * Archivo: public interface ICustomerService 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion....
 */

package com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerProduct;

import java.util.List;

public interface ICustomerService {
	com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerData findCustomerById(Integer aId, String validateLetterN);

	java.util.Map getCustomerDetailsById(Integer aId);

	Integer getDelayGroupDays(Integer aIdGroup);

	Integer updateCustomerInfo(com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.UpdateCustomerInfoRequest aCustomerInfo);

	String getBuroScore(Integer groupId, Integer customerId, String type);

	Integer saveCustomerProducts(List<CustomerProduct> customerProductList);

	Integer deleteCustomerProducts(Integer customerId);
}
