/**
 * Archivo: public interface ISynchronizeService
 * Autor..: Team Evac
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

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl;

import java.util.List;

import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.SynchronizeData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetEntitiesDataRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.UpdateDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.AgendaSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CollectiveDocumentAndQuestionnaireSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CreditGroupApplicationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CreditIndividualApplicationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CustomerSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.GroupSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.SolidarityPaymentSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationGroupSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationSynchronizationDataLcr;

public interface ISynchronizeService {

    CustomerSynchronizationData getCustomerToSynchronize(Integer id);

    SolidarityPaymentSynchronizationData getSolidarityPaymentToSynchronize(Integer id);

    List<SynchronizeData> getDataToSynchronize(GetDataSynchronizeRequest request);

    GroupSynchronizationData getGroupToSynchronize(Integer id);

    CreditGroupApplicationSynchronizationData getCreditGroupApplicationSynchronizationData(Integer id);

    CreditIndividualApplicationSynchronizationData getCreditIndividualApplicationSynchronizationData(Integer id);

    VerificationSynchronizationData getVerificationSynchronizationData(Integer id);

    VerificationGroupSynchronizationData getVerificationGroupSynchronizationData(Integer id);

    VerificationSynchronizationDataLcr getVerificationSynchronizationDataLcr(Integer id);
    
    CollectiveDocumentAndQuestionnaireSynchronizationData getCollectiveSynchronizationData(Integer id);

    AgendaSynchronizationData getAgendaSynchronizationData(Integer id);

    Integer updateDataToSynchronize(UpdateDataSynchronizeRequest request);

    public String getXmlControlTableDetail(Integer id);

    public List<Object> getEntitiesData(GetEntitiesDataRequest request);


}
