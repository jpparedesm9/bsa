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

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import cobiscorp.ecobis.ucsp.request.dto.*;

public interface IAdminService {

	public ServiceResponse deleteParameter(
			DeleteParameterRequest deleteParameterParam);

	public ServiceResponse deleteProductFuncionality(
			DeleteProductFuncionalityRequest deleteProductFuncionalityParam);

	public ServiceResponse insertParameter(
			InsertParameterRequest insertParameterParam);

	public ServiceResponse insertParameterValue(
			InsertParameterValueRequest insertParameterValueParam);

	public ServiceResponse insertProductFuncionality(
			InsertProductFuncionalityRequest insertProductFuncionalityParam);

	public ServiceResponse queryFuncionalitiesAttached(
			QueryFuncionalitiesAttachedRequest queryFuncionalitiesAttachedParam);

	public ServiceResponse queryFuncionalitiesByProduct(
			QueryFuncionalitiesByProductRequest queryFuncionalitiesByProductParam);

	public ServiceResponse queryParametersAndValues(
			QueryParametersAndValuesRequest queryParametersAndValuesParam);

	public ServiceResponse queryProducts(QueryProductsRequest queryProductsParam);

	public ServiceResponse updateParameter(
			UpdateParameterRequest updateParameterParam);

	public ServiceResponse updateParameterValue(
			UpdateParameterValueRequest updateParameterValueParam);

}