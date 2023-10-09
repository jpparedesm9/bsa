package com.cobis.cloud.sofom.operationsexecution.operationalservices;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.AccountForDisbursementInfo;
import com.cobis.cloud.sofom.operationsexecution.operationalservices.dto.SearchAccountForDisbursementInfo;

/**
 * Created by pclavijo on 10/07/2017.
 */
public interface IDisbursement {
    AccountForDisbursementInfo selectAccountForDisbursement(SearchAccountForDisbursementInfo searchAccountForDisbursementInfo, ConnectionInfo connectionInfo);
}
