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

package com.cobiscorp.ecobis.collateral.webservice;

import javax.ws.rs.PathParam;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.collateral.dto.CollateralItemDTO;

public interface ICollateralManagerService {

	public ServiceResponse searchCollateral(String guaranteeId);

	public ServiceResponse getCollateralItems(String collateralType);

	public ServiceResponse getSearchedCollateralItems(Integer collateralId, Integer branchOffice, String collateralType);

	public ServiceResponse getComposedCollateral(String externalCode);

	public ServiceResponse insertOrUpdateCollateralItems(CollateralItemDTO collateralItem);

	public ServiceResponse deleteCollateralItems(Integer collateralId, String collateralType, Integer sequential, Integer branchOffice);

}