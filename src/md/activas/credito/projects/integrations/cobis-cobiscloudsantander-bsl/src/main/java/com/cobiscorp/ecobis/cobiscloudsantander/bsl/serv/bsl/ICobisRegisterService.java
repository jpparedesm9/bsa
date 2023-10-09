/**
 * Archivo: public interface ICobisRegisterService 
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
public interface ICobisRegisterService {
	 Integer  registerCustomerInformation (
	com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo aCustomerCoreInfo
	);
}
