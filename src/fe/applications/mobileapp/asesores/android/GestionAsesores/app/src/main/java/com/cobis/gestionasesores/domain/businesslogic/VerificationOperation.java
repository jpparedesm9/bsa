package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.data.repositories.TaskRepository;

import java.util.List;

public class VerificationOperation {
    private TaskRepository taskRepository;

    public VerificationOperation() {
        taskRepository = TaskRepository.getInstance();
    }

    public ResultData validateVerification(Verification groupVerification, boolean isSync) {

        ResultData resultData = null;

        if (groupVerification.getStatus() != SyncStatus.SYNCED) {
            //Try to complete verification group
            try {
                boolean isCompleted = true;
                for (MemberVerification member : groupVerification.getMemberVerifications()) {
                    if (member.getStatus() != SyncStatus.SYNCED) {
                        isCompleted = false;
                    }
                }
                if (isCompleted) {
                    resultData = taskRepository.completeVerification(groupVerification, isSync);
                    if (resultData.getType() == ResultType.SUCCESS) {
                        resultData.setData(taskRepository.get(groupVerification.getId()));
                    } else {
                        resultData.setData(groupVerification);
                    }
                }
            } catch (Exception ex) {
                Log.e("GetGroupVerificationUseCase: ",ex);
                resultData = new ResultData(ResultType.FAILURE, null, groupVerification);
            }
        }
        if (resultData != null) {
            return resultData;
        } else {
            return new ResultData(ResultType.SUCCESS, null, groupVerification);
        }
    }

    public ResultData validateVerification(int verificationId, boolean isSync) {
        return validateVerification((Verification) taskRepository.get(verificationId), isSync);
    }

    @SyncStatus
    public static int checkVerificationStatus(Verification verification) {
        List<MemberVerification> verificationList = verification.getMemberVerifications();
        int completed = 0, pending = 0, draft = 0, error = 0;
        for (MemberVerification verf : verificationList) {
            switch (verf.getStatus()) {
                case SyncStatus.SYNCED:
                    completed++;
                    break;
                case SyncStatus.PENDING:
                    pending++;
                    break;
                case SyncStatus.DRAFT:
                    draft++;
                    break;
                case SyncStatus.ERROR:
                    error++;
                    break;
            }
        }

        if (completed == verificationList.size()) {
            return SyncStatus.PENDING; //This is pending in order
        } else if ((pending + completed) == verificationList.size()) {
            return SyncStatus.PENDING;
        } else if (error > 0) {
            return SyncStatus.ERROR;
        } else if (draft > 0) {
            return SyncStatus.DRAFT;
        } else {
            return SyncStatus.UNKNOWN;
        }
    }
}
