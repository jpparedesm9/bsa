package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;

import java.util.List;

import io.reactivex.Observable;

/**
 * Credit Application Data source definition
 * Created by mnaunay on 23/06/2017.
 */

public interface CreditAppDataSource {
    Observable<List<CreditApp>> getAll(@CreditAppType String type, @SyncStatus int status);

    CreditApp get(int appId) throws Exception;

    List<CreditApp> getAllApps(@CreditAppType String type, @SyncStatus int status);

    Observable<List<CreditApp>> search(String keyword, @CreditAppType String type, @SyncStatus int status);

    Observable<Boolean> delete(CreditApp creditApp);

    ResultData saveGroupCreditApp(GroupCreditApp creditApp,boolean isConfirmation, boolean tryRemote, boolean isSync) throws Exception;

    ResultData saveIndividualCreditApp(IndividualCreditApp creditApp,boolean isConfirmation,boolean tryRemote, boolean isSync) throws Exception;

    void updateMembersGroup(Group group);

    int countApplications(@CreditAppType String type, @SyncStatus int status);
}
