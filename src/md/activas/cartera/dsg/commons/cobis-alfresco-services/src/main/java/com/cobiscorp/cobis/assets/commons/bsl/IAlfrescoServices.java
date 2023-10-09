/**
 * Archivo: public interface IAlfrescoServices
 * Autor..: Team Santander
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.cobis.assets.commons.bsl;

import java.util.List;


public interface IAlfrescoServices {

    byte[] getFileHistorical(String libraryName, String fileName, String version, String user, String password);
    
    List<Version> getVersions(String libraryName, String fileName, String user, String password);

}
 