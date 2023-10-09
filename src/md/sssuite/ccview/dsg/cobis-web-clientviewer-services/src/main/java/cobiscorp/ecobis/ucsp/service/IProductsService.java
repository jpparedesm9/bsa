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

package cobiscorp.ecobis.ucsp.service;

import javax.servlet.http.HttpServletRequest;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.loan.dto.OperationGuaranteesResponse;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public interface IProductsService {
	/**
	 * Method used to prepare all the information for a specific customer and
	 * insert into tables that will be shown later in the VCC.
	 * 
	 * @param customerCode
	 *            <code> Integer <code>
	 * @param groupCode
	 *            <code> Integer <code>
	 * @return ServiceResponse whit a PrepareDataDTO Object with the information
	 *         of a specific customer
	 */
	public ServiceResponse prepareProductsData(Integer customerCode,
			Integer groupCode);

	/**
	 * Method used to get product by customer code.
	 * 
	 * @param customerCode
	 *            <code> Integer <code>
	 * @param spid
	 *            <code> Integer <code>
	 * @return ServiceResponse
	 */
	public ServiceResponse queryProductsByClientId(Integer customerCode,
			String documentId, Integer spid);

	/**
	 * Method used to get dinamic param por guarranties
	 * 
	 * @param codeDtos
	 * @return
	 */
	public ServiceResponseTO getOperationGuarantees(String codeDtos);


	/**
	 * Method used to get childs operacion by operation group
	 * 
	 * @param codeDtos
	 * @return
	 */
	public ServiceResponseTO getDebtsChilds(String codeDtos);

	/**
	 * Method used to prepare all the information for a specific customer and
	 * insert into tables that will be shown later in the VCC.
	 * 
	 * @param customerCode
	 *            <code> Integer <code>
	 * @param groupCode
	 *            <code> Integer <code>
	 * @return ServiceResponse whit a PrepareDataDTO Object with the information
	 *         of a specific customer
	 */
	public ServiceResponse prepareHistoryProductsData(Integer customerCode,
			Integer groupCode);

	/**
	 * Method used to get product by customer code.
	 * 
	 * @param customerCode
	 *            <code> Integer <code>
	 * @param spid
	 *            <code> Integer <code>
	 * @return ServiceResponse
	 */
	public ServiceResponse queryHistoryProductsByClientId(Integer customerCode,
			Integer spid, HttpServletRequest httpRequest);
}