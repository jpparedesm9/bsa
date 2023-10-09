package com.cobis.gestionasesores.data.repositories;

import android.annotation.SuppressLint;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncItemStatus;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.mappers.SolidaryPaymentMapper;
import com.cobis.gestionasesores.data.mappers.TaskMapper;
import com.cobis.gestionasesores.data.mappers.VerificationMapper;
import com.cobis.gestionasesores.data.models.GroupVerification;
import com.cobis.gestionasesores.data.models.IndividualVerification;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.data.models.requests.VerificationRequest;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.SolidarityPaymentResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationGroupResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationIndividualResponse;
import com.cobis.gestionasesores.data.models.responses.VerificationResponse;
import com.cobis.gestionasesores.data.source.TaskDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceTask;
import com.cobis.gestionasesores.data.source.remote.PaymentService;
import com.cobis.gestionasesores.data.source.remote.SyncService;
import com.cobis.gestionasesores.data.source.remote.VerificationService;
import com.cobis.gestionasesores.domain.businesslogic.VerificationOperation;

import java.io.IOException;
import java.util.List;

public class TaskRepository implements TaskDataSource {

    private static TaskRepository INSTANCE;

    private TaskRepository() {
    }

    public static TaskRepository getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new TaskRepository();
        }
        return INSTANCE;
    }

    @Override
    public List<Task> getAll(String keyword, @TaskType String type, @SyncStatus int status) {
        PersistenceTask persistence = null;
        try {
            persistence = new PersistenceTask();
            return persistence.getAll(keyword, type, status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
    }

    @Override
    public Task get(int id) {
        PersistenceTask persistence = null;
        try {
            persistence = new PersistenceTask();
            return persistence.get(id);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
    }

    private int saveLocal(Task task) {
        int taskId;
        PersistenceTask persistence = null;
        try {
            persistence = new PersistenceTask();
            taskId = persistence.saveOrUpdate(task);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return taskId;
    }

    @Override
    public ResultData saveSolidarityPayment(SolidarityPayment solidarityPayment, boolean isSync) throws Exception {
        ResultData resultData;
        if (NetworkUtils.isOnline()) {
            GenericResponse response = new PaymentService().payment(SolidaryPaymentMapper.paymentToRequest(solidarityPayment, isSync));
            if (response.isResult()) {
                solidarityPayment.setStatus(SyncStatus.SYNCED);
                solidarityPayment.setErrorMsg(null);
                solidarityPayment.setAction(null);
                resultData = new ResultData(ResultType.SUCCESS, response.getFirstMessage(), null);
            } else {
                solidarityPayment.setStatus(SyncStatus.ERROR);
                solidarityPayment.setErrorMsg(response.getFirstMessage());
                resultData = new ResultData(ResultType.FAILURE, response.getFirstMessage(), null);
            }
            if (solidarityPayment.getStatus() == SyncStatus.SYNCED || isSync) {
                saveLocal(solidarityPayment);
            }
        } else {
            solidarityPayment.setStatus(SyncStatus.PENDING);
            solidarityPayment.setErrorMsg(null);
            saveLocal(solidarityPayment);
            resultData = new ResultData(ResultType.SUCCESS, null);
        }
        return resultData;
    }

    @Override
    public ResultData saveMemberVerification(int verificationId, MemberVerification memberVerification, boolean tryOnline, boolean isSync) throws Exception {
        return saveMemberVerification((Verification) get(verificationId), memberVerification, tryOnline, isSync);
    }

    @SuppressLint("WrongConstant")
    @Override
    public ResultData saveMemberVerification(Verification verification, MemberVerification memberVerification, boolean tryOnline, boolean isSync) throws Exception {
        ResultData result;
        if (NetworkUtils.isOnline() && tryOnline) {
            boolean isGroup = verification.getType().equals(TaskType.GROUP_VERIFICATION);
            VerificationRequest request = VerificationMapper.memberToVerificationRequest(isGroup, memberVerification);
            VerificationResponse response = new VerificationService().saveVerification(verification.getServerId(), request);
            if (response.isResult()) {
                memberVerification.setScore(response.getData().getResult());
                memberVerification.setEnabled(false);
                memberVerification.setStatus(SyncStatus.SYNCED);
                memberVerification.setErrorMsg(null);
                memberVerification.setAction(null);
                verification.replaceMember(memberVerification);
                result = new ResultData(ResultType.SUCCESS, response.getFirstMessage());
            } else {
                memberVerification.setStatus(SyncStatus.ERROR);
                memberVerification.setErrorMsg(response.getFirstMessage());
                verification.replaceMember(memberVerification);
                result = new ResultData(ResultType.FAILURE, response.getFirstMessage());
            }
        } else {
            memberVerification.setErrorMsg(null);
            verification.replaceMember(memberVerification);
            result = new ResultData(ResultType.SUCCESS, null);
        }

        verification.setStatus(VerificationOperation.checkVerificationStatus(verification));

        if (result.getType() == ResultType.SUCCESS || isSync) {
            saveLocal(verification);
        }

        return result;
    }

    @Override
    public boolean doSolidarityDataSync(SyncItem item) {
        PersistenceTask persistence = null;
        boolean resultDownload = false;
        int successCount = 0;
        try {
            persistence = new PersistenceTask();
            persistence.beginTransaction();
            SolidarityPaymentResponse response;
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            List<SolidarityPayment> data;
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getSolidarityPayment(item.getServerId(), page);
                if (response.isResult()) {
                    data = SolidaryPaymentMapper.responseToSolidarityPayment(response.getData());
                    for (SolidarityPayment solidarity : data) {
                        if (solidarity.getServerId() > 0) {
                            Task taskExist = persistence.getByServerId(solidarity.getServerId());
                            if (taskExist != null) {
                                solidarity.setId(taskExist.getId());
                            }
                        }
                        persistence.saveOrUpdate(solidarity);
                    }
                    successCount += data.size();
                }else{
                    throw new RuntimeException("SolidarityDataSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("SolidarityDataSync: not downloaded correctly");
            }
            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception e) {
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //---------------------
        //MNA: this operation will be into sql transaction, but because of SQlite limitation the next operation is out!
        //----------------------
        if (resultDownload) {
            item.setStatus(SyncItemStatus.SUCCESS);
            SyncRepository.getInstance().saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public boolean doIndividualVerificationSync(SyncItem item) {
        PersistenceTask persistence = null;
        boolean resultDownload = false;
        int successCount = 0;
        try {
            persistence = new PersistenceTask();
            persistence.beginTransaction();
            VerificationIndividualResponse response;
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            List<IndividualVerification> data;
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getIndividualVerification(item.getServerId(), page);
                if (response.isResult()) {
                    data = TaskMapper.fromIndividualRemoteList(response.getData());
                    for (IndividualVerification individual : data) {
                        if (individual.getServerId() > 0) {
                            Task taskExist = persistence.getByServerId(individual.getServerId());
                            if (taskExist != null) {
                                individual.setId(taskExist.getId());
                            }
                        }
                        persistence.saveOrUpdate(individual);
                    }
                    successCount += data.size();
                }else{
                    throw new RuntimeException("IndividualVerificationSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("IndividualVerificationSync: not downloaded correctly");
            }
            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception e) {
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //---------------------
        //MNA: this operation will be into sql transaction, but because of SQlite limitation the next operation is out!
        //----------------------
        if (resultDownload) {
            item.setStatus(SyncItemStatus.SUCCESS);
            SyncRepository.getInstance().saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public boolean doGroupVerificationSync(SyncItem item) {
        PersistenceTask persistence = null;
        boolean resultDownload = false;
        int successCount = 0;
        try {
            VerificationGroupResponse response;
            persistence = new PersistenceTask();
            persistence.beginTransaction();
            int pages = SyncService.getNumberOfPages(item.getItemCount());

            List<GroupVerification> data;
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getGroupVerification(item.getServerId(), page);
                if (response.isResult()) {
                    data = TaskMapper.fromRemoteList(response.getData());
                    for (GroupVerification group : data) {
                        if (group.getServerId() > 0) {
                            Task taskExist = persistence.getByServerId(group.getServerId());
                            if (taskExist != null) {
                                group.setId(taskExist.getId());
                            }
                        }
                        persistence.saveOrUpdate(group);
                    }
                    successCount += data.size();
                }else{
                    throw new RuntimeException("GroupVerificationSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("GroupVerificationSync: not downloaded correctly");
            }
            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception e) {
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //---------------------
        //MNA: this operation will be into sql transaction, but because of SQlite limitation the next operation is out!
        //----------------------
        if (resultDownload) {
            item.setStatus(SyncItemStatus.SUCCESS);
            SyncRepository.getInstance().saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public ResultData completeVerification(Verification verification, boolean isSync) throws IOException {
        ResultData result;
        if (NetworkUtils.isOnline()) {
            GenericResponse response = new VerificationService().complete(verification.getServerId());
            if (response.isResult()) {
                verification.setStatus(SyncStatus.SYNCED);
                verification.setErrorMsg(null);
                verification.setAction(null);
                result = new ResultData(ResultType.SUCCESS, response.getFirstMessage());
            } else {
                verification.setStatus(SyncStatus.ERROR);
                verification.setErrorMsg(response.getFirstMessage());
                result = new ResultData(ResultType.FAILURE, response.getFirstMessage());
            }

            if (result.getType() == ResultType.SUCCESS || isSync) {
                saveLocal(verification);
            }
        } else {
            result = new ResultData(ResultType.FAILURE, null);
        }
        return result;
    }

    @Override
    public int countTasks(@TaskType String type, @SyncStatus int status) {
        int count = 0;
        PersistenceTask persistence = null;
        try {
            persistence = new PersistenceTask();
            count = persistence.countByStatus(type, status);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return count;
    }
}