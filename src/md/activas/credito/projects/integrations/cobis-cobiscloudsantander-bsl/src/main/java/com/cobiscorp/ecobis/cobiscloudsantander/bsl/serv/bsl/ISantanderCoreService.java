/**
 * Archivo: public interface ISantanderCoreService 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl;
public interface ISantanderCoreService {
	 com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo  getCustomerInformation (
	com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest
	);
	 
	 com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo  getCustomerInformationWithoutValidation (
	com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest
	);
	 
	 com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo  getCustomerInformationWithOutUpdate (
	com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest aSantanderRequest
	);
}
