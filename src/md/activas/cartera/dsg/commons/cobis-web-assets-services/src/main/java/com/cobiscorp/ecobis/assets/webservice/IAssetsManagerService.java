/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de COBISCORP.                                */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de COBISCORP.                              */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las y por las convenciones              */
/*   internacionales de  propiedad intelectual. Su uso no   */
/*   autorizado dara  derecho a  COBISCORP para obtener     */
/*   ordenes de  secuestro o retencion y  para perseguir    */
/*   penalmente a los autores de cualquier infraccion.      */
/************************************************************/
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/************************************************************/

package com.cobiscorp.ecobis.assets.webservice;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.assets.dto.LoanSimulationDTO;
import com.cobiscorp.ecobis.assets.dto.PaymentRequest;
import com.cobiscorp.ecobis.assets.dto.SolidarityPaymentCustomerData;

public interface IAssetsManagerService {

	public ServiceResponse getPaymentOperatorStructure(String operatorId);

	public ServiceResponse insertFileinTemp(PaymentRequest payment);

	public ServiceResponse uploadFile(Integer sequential);

	public ServiceResponse getCatalogs(String table);

	public ServiceResponse insertSolidarityPayment(SolidarityPaymentCustomerData solidarityPaymentCustomerData);

	public ServiceResponse loanSimulation(LoanSimulationDTO loanSmulation);

}