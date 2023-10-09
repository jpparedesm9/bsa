package com.cobis.gestionasesores.data.source;

import android.annotation.SuppressLint;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;

import java.io.IOException;
import java.util.List;

public interface TaskDataSource {
    List<Task> getAll(String keyword, @TaskType String type, @SyncStatus int status);

    Task get(int id);

    ResultData saveSolidarityPayment(SolidarityPayment solidarityPayment, boolean isSync) throws Exception;

    ResultData saveMemberVerification(int verificationId, MemberVerification memberVerification, boolean tryOnline, boolean isSync) throws Exception;

    @SuppressLint("WrongConstant")
    ResultData saveMemberVerification(Verification verification, MemberVerification memberVerification, boolean tryOnline, boolean isSync) throws Exception;

    boolean doSolidarityDataSync(SyncItem item);

    boolean doIndividualVerificationSync(SyncItem item);

    boolean doGroupVerificationSync(SyncItem item);

    ResultData completeVerification(Verification groupVerification, boolean isSync) throws IOException;

    int countTasks(@TaskType String type, @SyncStatus int status);
}
