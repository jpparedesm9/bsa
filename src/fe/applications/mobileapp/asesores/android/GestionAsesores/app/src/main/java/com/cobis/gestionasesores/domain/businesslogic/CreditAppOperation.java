package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.source.CreditAppDataSource;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.List;

/**
 * Created by bqtdesa02 on 9/7/2017.
 */

public class CreditAppOperation {

    private PersonDataSource mPersonDataSource;
    private CreditAppDataSource mCreditAppDataSource;

    public CreditAppOperation() {
        mPersonDataSource = PersonRepository.getInstance();
        mCreditAppDataSource = CreditAppRepository.getInstance();
    }

    public ResultData saveIndividualCredit(IndividualCreditApp creditApp,boolean isConfirmation, boolean tryRemote) throws Exception {
        ResultData resultData;
        @SyncStatus int customerStatus = mPersonDataSource.getPersonStatus(creditApp.getCustomerServerId());
        @SyncStatus int guarantorStatus = mPersonDataSource.getPersonStatus(creditApp.getGuarantor().getServerId());

        boolean isCustomerValid = customerStatus == SyncStatus.SYNCED || customerStatus == SyncStatus.UNKNOWN;
        boolean isGuarantorValid = guarantorStatus == SyncStatus.SYNCED || guarantorStatus == SyncStatus.UNKNOWN;

        if (!NetworkUtils.isOnline() || (isCustomerValid && isGuarantorValid)) {
            resultData = mCreditAppDataSource.saveIndividualCreditApp(creditApp,isConfirmation,tryRemote, false);
        } else {
            resultData = new ResultData(ResultType.FAILURE_LOCAL, null);
        }
        return resultData;
    }

    public ResultData saveGroupCredit(GroupCreditApp creditApp,boolean isConfirmation, boolean tryRemote) throws Exception {
        ResultData resultData;

        List<MemberCreditApp> memberCreditApps = creditApp.getMemberCreditApps();

        boolean isValid = true;

        if (memberCreditApps != null) {
            for (MemberCreditApp memberCreditApp : memberCreditApps) {
                @SyncStatus int status = mPersonDataSource.getPersonStatus(memberCreditApp.getCustomerServerId());
                if (status != SyncStatus.SYNCED && status != SyncStatus.UNKNOWN) {
                    isValid = false;
                    break;
                }
            }
        }
        if (!NetworkUtils.isOnline() || isValid) {
            resultData = mCreditAppDataSource.saveGroupCreditApp(creditApp,isConfirmation,tryRemote, false);
        } else {
            resultData = new ResultData(ResultType.FAILURE_LOCAL, null);
        }

        return resultData;
    }
}
