package com.cobis.gestionasesores.data.repositories;

import android.support.annotation.Nullable;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.CreditAppMapper;
import com.cobis.gestionasesores.data.mappers.IndividualCreditMapper;
import com.cobis.gestionasesores.data.mappers.MemberCreditAppMapper;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.requests.GroupCreditInfo;
import com.cobis.gestionasesores.data.models.responses.CreditResponse;
import com.cobis.gestionasesores.data.models.responses.Message;
import com.cobis.gestionasesores.data.models.responses.UpdateAmountResponse;
import com.cobis.gestionasesores.data.source.CreditAppDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceCreditApp;
import com.cobis.gestionasesores.data.source.remote.CreditAppService;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;

import io.reactivex.Observable;

/**
 * Credit Application repository
 * Created by mnaunay on 23/06/2017.
 */

public final class CreditAppRepository implements CreditAppDataSource {
    private static CreditAppRepository sInstance;

    public static CreditAppRepository getInstance() {
        if (sInstance == null) {
            sInstance = new CreditAppRepository();
        }
        return sInstance;
    }

    private CreditAppRepository() {
    }

    @Override
    public Observable<List<CreditApp>> getAll(@CreditAppType final String type, @SyncStatus final int status) {
        return Observable.fromCallable(new Callable<List<CreditApp>>() {
            @Override
            public List<CreditApp> call() throws Exception {
                return getAllApps(type, status);
            }
        });
    }

    @Override
    public List<CreditApp> getAllApps(@CreditAppType final String type, @SyncStatus final int status) {
        PersistenceCreditApp persistence = null;
        List<CreditApp> result;
        try {
            persistence = new PersistenceCreditApp();
            result = persistence.getAll(type, status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public CreditApp get(int appId) {
        CreditApp creditApp = getLocalByServerId(appId);
        if (creditApp == null) return null;

//        if (NetworkUtils.isOnline()) {
//            GroupCreditApp groupCreditApp = getRemoteGroupCredit(appId);
//            if (groupCreditApp != null) {
//                groupCreditApp.setId(creditApp.getId());
//                groupCreditApp.setApplicantId(creditApp.getApplicantId());
//                groupCreditApp.setInProcess(creditApp.isInProcess());
//                groupCreditApp.setAction(creditApp.getAction());
//                groupCreditApp.setErrorMsg(creditApp.getErrorMsg());
//                groupCreditApp.setStatus(creditApp.getStatus());
//                groupCreditApp.setWarningMessage(creditApp.getWarningMessage());
//                if (groupCreditApp.getServerId() > 0) {
//                    //TODO: Should this update members for group if there are changes
//                    saveCreditAppLocal(groupCreditApp);
//                }
//            }
//        }
        return getLocalByServerId(appId);
    }

    public Observable<List<CreditApp>> search(final String keyword, @CreditAppType final String type, @SyncStatus final int status) {
        return Observable.fromCallable(new Callable<List<CreditApp>>() {
            @Override
            public List<CreditApp> call() throws Exception {
                PersistenceCreditApp persistence = null;
                List<CreditApp> result;
                try {
                    persistence = new PersistenceCreditApp();
                    result = persistence.search(keyword, type, status);
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });
    }

    private int saveCreditAppLocal(CreditApp creditApp) {
        PersistenceCreditApp persistence = null;
        int result;
        try {
            persistence = new PersistenceCreditApp();
            int id = creditApp.getId();
            if (id == -1) {
                result = persistence.addCreditApp(creditApp);
            } else {
                persistence.updateCreditApp(id, creditApp);
                result = creditApp.getId();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public Observable<Boolean> delete(final CreditApp creditApp) {
        return Observable.fromCallable(new Callable<Boolean>() {
            @Override
            public Boolean call() throws Exception {
                PersistenceCreditApp persistence = null;
                boolean result;
                try {
                    persistence = new PersistenceCreditApp();
                    result = persistence.deleteCreditApp(creditApp.getId());
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });
    }

    @Override
    public ResultData saveGroupCreditApp(GroupCreditApp creditApp, boolean isConfirmation, boolean tryRemote, boolean isSync) throws Exception {
        ResultData resultData;
        if (NetworkUtils.isOnline() && tryRemote) {
            CreditAppService service = new CreditAppService();
            CreditResponse response;
            if (creditApp.getServerId() > 0) {
                response = service.updateGroupCreditApp(creditApp.getServerId(), CreditAppMapper.fromCreditApp(creditApp, isConfirmation));
            } else {
                response = service.saveGroupCreditApp(CreditAppMapper.fromCreditApp(creditApp, isConfirmation));
            }
            resultData = validateCreditWorkFlow(creditApp, response, isSync);
            if (resultData.getType() == ResultType.SUCCESS) {
                creditApp.setCanEdit(false);
                saveCreditAppLocal(creditApp);
            }
        } else {
            creditApp.setStatus(SyncStatus.PENDING);
            creditApp.setErrorMsg(null);
            int localId = saveCreditAppLocal(creditApp);
            creditApp.setId(localId);
            resultData = new ResultData(ResultType.SUCCESS, null);
        }

        //send back last credit app
        resultData.setData(creditApp);
        return resultData;
    }

    @Override
    public ResultData saveIndividualCreditApp(IndividualCreditApp creditApp, boolean isConfirmation, boolean tryRemote, boolean isSync) throws Exception {
        ResultData resultData;
        if (NetworkUtils.isOnline() && tryRemote) {
            CreditAppService service = new CreditAppService();
            CreditResponse response;
            if (creditApp.getServerId() > 0) {
                response = service.updateIndividualCreditApp(creditApp.getServerId(), IndividualCreditMapper.fromCreditApp(creditApp, isConfirmation));
            } else {
                response = service.saveIndividualCreditApp(IndividualCreditMapper.fromCreditApp(creditApp, isConfirmation));
            }
            resultData = validateCreditWorkFlow(creditApp, response, isSync);
        } else {
            creditApp.setStatus(SyncStatus.PENDING);
            creditApp.setErrorMsg(null);
            int localId = saveCreditAppLocal(creditApp);
            creditApp.setId(localId);
            resultData = new ResultData(ResultType.SUCCESS, null);
        }

        //send back last credit appp
        resultData.setData(creditApp);
        return resultData;
    }

    private ResultData validateCreditWorkFlow(CreditApp creditApp, CreditResponse response, boolean isSync) {
        ResultData resultData;
        creditApp.setWarningMessage(null); //clear last warning!
        boolean inProcess = false;
        if (response.getProcessInstance().isResult()) {
            creditApp.setServerId(response.getProcessInstance().getData().getProcessInstance());
            if (response.getCreditApplication().isResult()) {
                inProcess = true;
                UpdateAmountResponse amountsResponse = response.getUpdateAmounts();
                if (amountsResponse.isResult() && StringUtils.isEmpty(amountsResponse.getData())) {
                    if (response.getEvaluatePolitics() != null && response.getEvaluatePolitics().isResult()) {
                        if (response.getCompleteTask() != null && response.getCompleteTask().isResult()) {
                            creditApp.setStatus(SyncStatus.SYNCED);
                            creditApp.setWarningMessage(null);
                            creditApp.setErrorMsg(null);
                            creditApp.setAction(null);
                            resultData = new ResultData(ResultType.SUCCESS, response.getFirstMessage());
                        } else {
                            creditApp.setStatus(SyncStatus.ERROR);
                            Message msg = response.getCompleteTask() != null ? response.getCompleteTask().getFirstMessage() : null;
                            creditApp.setErrorMsg(msg);
                            resultData = new ResultData(ResultType.FAILURE, msg);
                        }
                    } else {
                        creditApp.setStatus(SyncStatus.ERROR);
                        Message msg = response.getEvaluatePolitics() != null ? response.getEvaluatePolitics().getFirstMessage() : null;
                        creditApp.setErrorMsg(msg);
                        resultData = new ResultData(ResultType.FAILURE, msg);
                    }
                } else {
                    if (StringUtils.isNotEmpty(amountsResponse.getData())) {
                        creditApp.setWarningMessage(amountsResponse.getData());
                        creditApp.setStatus(SyncStatus.PENDING);
                        resultData = new ResultData(ResultType.FAILURE, amountsResponse.getFirstMessage());
                    } else {
                        creditApp.setStatus(SyncStatus.ERROR);
                        creditApp.setErrorMsg(response.getUpdateAmounts().getFirstMessage());
                        resultData = new ResultData(ResultType.FAILURE, response.getUpdateAmounts().getFirstMessage());
                    }
                }
            } else {
                creditApp.setStatus(SyncStatus.ERROR);
                creditApp.setErrorMsg(response.getCreditApplication().getFirstMessage());
                resultData = new ResultData(ResultType.FAILURE, response.getCreditApplication().getFirstMessage());
            }
        } else {
            creditApp.setStatus(SyncStatus.ERROR);
            creditApp.setErrorMsg(response.getProcessInstance().getFirstMessage());
            resultData = new ResultData(ResultType.FAILURE, response.getProcessInstance().getFirstMessage());
        }
        creditApp.setInProcess(inProcess);

        if (creditApp.getStatus() == SyncStatus.SYNCED || isSync || inProcess) {
            int id = saveCreditAppLocal(creditApp);
            if (id > 0) {
                creditApp.setId(id);
                resultData.setData(creditApp);
            }
        }
        return resultData;
    }

    private List<CreditApp> findGroupCreditApp(int groupId) {
        List<CreditApp> result = new ArrayList<>();
        PersistenceCreditApp persistence = null;
        try {
            persistence = new PersistenceCreditApp();
            result = persistence.findGroupCreditApp(groupId, CreditAppType.GROUP,/*Not if synced*/ SyncStatus.SYNCED);
        } catch (Exception ex) {
            Log.e("CreditAppRepository::findGroupCreditApp: ");
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    /**
     * Allows to update members in application of the group input
     *
     * @param group Group identifier
     */
    @Override
    public void updateMembersGroup(Group group) {
        try {
            List<Member> groupMembers = group.getMembers();
            List<CreditApp> creditApps = findGroupCreditApp(group.getId());
            GroupCreditApp groupCredit;
            for (CreditApp creditApp : creditApps) {
                groupCredit = (GroupCreditApp) creditApp;
                List<MemberCreditApp> tmp = new ArrayList<>();

                //check credit members are part of the group
                for (MemberCreditApp creditMember : groupCredit.getMemberCreditApps()) {
                    for (Member groupMember : groupMembers) {
                        if (creditMember.getCustomerServerId() == groupMember.getServerId()) {
                            tmp.add(creditMember);
                            break;
                        }
                    }
                }

                //add new group member to credit app
                for (Member groupMember : groupMembers) {
                    boolean found = false;
                    for (MemberCreditApp creditMember : groupCredit.getMemberCreditApps()) {
                        if (groupMember.getServerId() == creditMember.getCustomerServerId()) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        tmp.add(MemberCreditAppMapper.fromMember(groupMember));
                    }
                }

                groupCredit = groupCredit.buildUpon().setMemberCreditApps(tmp).build();
                saveCreditAppLocal(groupCredit);
            }
        } catch (Exception ex) {
            Log.e("CreditAppRepository::updateMembersGroup: ", ex);
        }
    }

    @Override
    public int countApplications(@CreditAppType String type, @SyncStatus int status) {
        int count = 0;
        PersistenceCreditApp persistence = null;
        try {
            persistence = new PersistenceCreditApp();
            count = persistence.countByStatus(type, status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return count;
    }

    private GroupCreditApp getRemoteGroupCredit(int appId) {
        try {
            CreditAppService service = new CreditAppService();
            GroupCreditInfo groupCreditInfo = service.getGroupCreditApp(appId);
            return CreditAppMapper.toGroupCreditApp(groupCreditInfo);
        } catch (Exception ex) {
            Log.e("CreditAppRepository: Error getRemoteGroupCredit ", ex);
            return null;
        }
    }

    @Nullable
    private CreditApp getLocalByServerId(int serverId) {
        PersistenceCreditApp persistenceCreditApp = null;
        try {
            persistenceCreditApp = new PersistenceCreditApp();
            return persistenceCreditApp.getByServerId(serverId);
        } catch (Exception ex) {
            Log.e("CreditAppRepository: getLocalByServerId error!", ex);
            return null;
        } finally {
            if (persistenceCreditApp != null) {
                persistenceCreditApp.close();
            }
        }
    }
}
