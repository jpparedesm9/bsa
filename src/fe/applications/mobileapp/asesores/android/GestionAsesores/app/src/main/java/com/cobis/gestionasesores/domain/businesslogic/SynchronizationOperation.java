package com.cobis.gestionasesores.domain.businesslogic;

import android.util.SparseIntArray;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.SyncStatusAction;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.SyncData;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.TaskRepository;
import com.cobis.gestionasesores.infrastructure.SyncManager;
import com.cobis.gestionasesores.utils.Util;

import java.util.List;

/**
 * Synchronization operation that uploads {@link SyncStatus}.PENDING elements using nominal Repositories
 */
public class SynchronizationOperation {

    private PersonRepository personRepository;
    private GroupRepository groupRepository;
    private CreditAppRepository creditAppRepository;
    private TaskRepository taskRepository;

    public SynchronizationOperation() {
        personRepository = PersonRepository.getInstance();
        groupRepository = GroupRepository.getInstance();
        creditAppRepository = CreditAppRepository.getInstance();
        taskRepository = TaskRepository.getInstance();
    }

    /**
     * Performs {@link com.cobis.gestionasesores.data.source.local.Database} queries to obtain {@link SyncStatus}.PENDING elements count per {@link SyncItemType}
     *
     * @param items a {@link SparseIntArray} containing a mapping to fill the items in PENDING status.
     * @return ResultData that indicates whether it was a SUCCESS count or FAILURE
     */
    public ResultData getPendingItemCount(SparseIntArray items) {
        ResultData result = null;
        if (items != null && items.size() > 0) {
            for (int i = 0; i < items.size(); i++) {
                try {
                    switch (items.keyAt(i)) {
                        case SyncItemType.CUSTOMER:
                            items.put(SyncItemType.CUSTOMER, personRepository.countPeople(PersonType.CUSTOMER, new int[]{SyncStatus.PENDING, SyncStatus.DRAFT}));
                            break;
                        case SyncItemType.PROSPECT:
                            items.put(SyncItemType.PROSPECT, personRepository.countPeople(PersonType.PROSPECT, new int[]{SyncStatus.PENDING, SyncStatus.DRAFT}));
                            break;
                        case SyncItemType.GROUP:
                            items.put(SyncItemType.GROUP, groupRepository.countGroups(SyncStatus.PENDING));
                            break;
                        case SyncItemType.INDIVIDUAL_APPLICATION:
                            items.put(SyncItemType.INDIVIDUAL_APPLICATION, creditAppRepository.countApplications(CreditAppType.INDIVIDUAL, SyncStatus.PENDING));
                            break;
                        case SyncItemType.GROUP_APPLICATION:
                            items.put(SyncItemType.GROUP_APPLICATION, creditAppRepository.countApplications(CreditAppType.GROUP, SyncStatus.PENDING));
                            break;
                        case SyncItemType.PAYMENT:
                            items.put(SyncItemType.PAYMENT, taskRepository.countTasks(TaskType.SOLIDARITY_PAYMENT, SyncStatus.PENDING));
                            break;
                        case SyncItemType.INDIVIDUAL_VERIFICATION:
                            items.put(SyncItemType.INDIVIDUAL_VERIFICATION, taskRepository.countTasks(TaskType.INDIVIDUAL_VERIFICATION, SyncStatus.PENDING));
                            break;
                        case SyncItemType.GROUP_VERIFICATION:
                            items.put(SyncItemType.GROUP_VERIFICATION, taskRepository.countTasks(TaskType.GROUP_VERIFICATION, SyncStatus.PENDING));
                            break;
                    }
                } catch (Exception e) {
                   Log.e("SynchronizationOperation:: getPendingItemCount: ", e);
                }
            }
            result = new ResultData(ResultType.SUCCESS, null, items);
        } else {
            result = new ResultData(ResultType.FAILURE, null);
        }
        return result;
    }

    /**
     * Uploads all PENDING items requested in the int array passed as argument
     *
     * @param items an array of {@link SyncItemType} to upload
     */
    public void uploadItems(int[] items) {
        // If there is any error uploading a component or any of its parts, the upload is interrupted and the loop continues to the next iteration or ends.
        for (int item : items) {
            switch (item) {
                case SyncItemType.CUSTOMER:
                    List<Person> customers = personRepository.getAllForSync(PersonType.CUSTOMER, new int[]{SyncStatus.PENDING, SyncStatus.DRAFT});
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, customers.size()));
                    uploadPeople(customers, item);
                    break;
                case SyncItemType.PROSPECT:
                    List<Person> prospects = personRepository.getAllForSync(PersonType.PROSPECT, new int[]{SyncStatus.PENDING, SyncStatus.DRAFT});
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, prospects.size()));
                    uploadPeople(prospects, item);
                    break;
                case SyncItemType.GROUP:
                    List<Group> groups = groupRepository.getAllGroups(SyncStatus.PENDING, null);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, groups.size()));
                    for (Group group : groups) {
                        SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, item, false, groups.indexOf(group) + 1, groups.size()));
                        boolean save = group.getServerId() <= 0; // 1. Check if the group exists in the server
                        if (save) { // if the groups doesn't exist, save it to have a reference in member upload,
                            try {
                                ResultData result = groupRepository.save(group, true);
                                if (result.getType() != ResultType.SUCCESS) {
                                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (groups.indexOf(group) + 1) < groups.size(), result.getErrorMessage()));
                                    continue;
                                }
                            } catch (Exception e) {
                                Log.e("SynchronizationOperation:: uploadItems: Groups: ", e);
                                handleError(e);
                                continue;
                            }
                        }

                        boolean exit = false;
                        // Upload all group's members
                        for (Member member : group.getMembers()) {
                            try {
                                ResultData result = new GroupOperation().saveMember(group, member, true);
                                if (result.getType() != ResultType.SUCCESS) {
                                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (groups.indexOf(group) + 1) < groups.size(), result.getErrorMessage()));
                                    // if there is an error, the group uploading is interrupted
                                    exit = true;
                                }
                            } catch (Exception e) {
                                Log.e("SynchronizationOperation:: uploadItems: Group Members : ", e);
                                handleError(e);
                                // if there is an error, the group uploading is interrupted
                                exit = true;
                            }
                        }
                        // If the group existed already, update the group (IME)
                        if (!exit) {
                            try {
                                ResultData result = groupRepository.save(group, true);
                                if (result.getType() != ResultType.SUCCESS) {
                                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (groups.indexOf(group) + 1) < groups.size(), result.getErrorMessage()));
                                }
                            } catch (Exception e) {
                                Log.e("SynchronizationOperation:: uploadItems: Update Group : ", e);
                                handleError(e);
                            }
                        }
                    }
                    break;
                case SyncItemType.INDIVIDUAL_APPLICATION:
                    List<CreditApp> indApps = creditAppRepository.getAllApps(CreditAppType.INDIVIDUAL, SyncStatus.PENDING);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, indApps.size()));
                    for (CreditApp app : indApps) {
                        SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, item, false, indApps.indexOf(app) + 1, indApps.size()));
                        try {
                            ResultData result = creditAppRepository.saveIndividualCreditApp((IndividualCreditApp) app,false, true, true);
                            if (result.getType() != ResultType.SUCCESS) {
                                SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (indApps.indexOf(app) + 1) < indApps.size(), result.getErrorMessage()));
                            }
                        } catch (Exception e) {
                            Log.e("SynchronizationOperation:: uploadItems: Individual Credit : ", e);
                            handleError(e);
                        }
                    }
                    break;
                case SyncItemType.GROUP_APPLICATION:
                    List<CreditApp> grpApps = creditAppRepository.getAllApps(CreditAppType.GROUP, SyncStatus.PENDING);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, grpApps.size()));
                    for (CreditApp app : grpApps) {
                        SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, item, false, grpApps.indexOf(app) + 1, grpApps.size()));
                        try {
                            ResultData result = creditAppRepository.saveGroupCreditApp((GroupCreditApp) app,false, true, true);
                            if (result.getType() != ResultType.SUCCESS) {
                                SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (grpApps.indexOf(app) + 1) < grpApps.size(), result.getErrorMessage()));
                            }
                        } catch (Exception e) {
                            Log.e("SynchronizationOperation:: uploadItems: Group Credit : ", e);
                            handleError(e);
                        }
                    }
                    break;
                case SyncItemType.PAYMENT:
                    List<Task> payments = taskRepository.getAll(null, TaskType.SOLIDARITY_PAYMENT, SyncStatus.PENDING);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, payments.size()));
                    for (Task payment : payments) {
                        SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, item, false, payments.indexOf(payment) + 1, payments.size()));
                        try {
                            ResultData result = taskRepository.saveSolidarityPayment((SolidarityPayment) payment, true);
                            if (result.getType() != ResultType.SUCCESS) {
                                SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, item, (payments.indexOf(payment) + 1) < payments.size(), result.getErrorMessage()));
                            }
                        } catch (Exception e) {
                            Log.e("SynchronizationOperation:: uploadItems: Payment : ", e);
                            handleError(e);
                        }
                    }
                    break;
                case SyncItemType.INDIVIDUAL_VERIFICATION:
                    List<Task> individual = taskRepository.getAll(null, TaskType.INDIVIDUAL_VERIFICATION, SyncStatus.PENDING);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, individual.size()));
                    uploadVerifications(individual, item);
                    break;
                case SyncItemType.GROUP_VERIFICATION:
                    List<Task> verifications = taskRepository.getAll(null, TaskType.GROUP_VERIFICATION, SyncStatus.PENDING);
                    SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.SUCCESS, item, false, 0, verifications.size()));
                    uploadVerifications(verifications, item);
                    break;
            }
        }
    }

    /**
     * Uploads all people in {@link SyncStatus}.PENDING
     */
    private void uploadPeople(List<Person> people, @SyncItemType int type) {
        for (Person person : people) {
            SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, type, false, people.indexOf(person) + 1, people.size()));
            List<Section> sections = person.getSections();
            for (Section sct : sections) {
                if (sct.getStatus() == SyncStatus.PENDING) {
                    try {
                        ResultData result = personRepository.saveSection(person, sct, true);
                        if (result.getType() != ResultType.SUCCESS) {
                            SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, type, (people.indexOf(person) + 1) < people.size(), result.getErrorMessage()));
                        }
                    } catch (Exception e) {
                        Log.e("SynchronizationOperation:: uploadPeople: ", e);
                        handleError(e);
                    }
                }
            }
        }
    }

    private void uploadVerifications(List<Task> verifications, @SyncItemType int type) {
        for (Task vrf : verifications) {
            SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.UPDATE, ResultType.SUCCESS, type, false, verifications.indexOf(vrf) + 1, verifications.size()));
            Verification vrfctn = (Verification) vrf;
            for (MemberVerification mv : vrfctn.getMemberVerifications()) {
                if (mv.getStatus() == SyncStatus.PENDING) {
                    try {
                        ResultData result = taskRepository.saveMemberVerification(vrfctn, mv, true, true);
                        if (result.getType() != ResultType.SUCCESS) {
                            SyncManager.sendStatus(SyncManager.SYNC_PROGRESS_UPDATE, new SyncData(SyncStatusAction.APPEND, ResultType.FAILURE, type, (verifications.indexOf(vrf) + 1) < verifications.size(), result.getErrorMessage()));
                        }
                    } catch (Exception e) {
                        Log.e("SynchronizationOperation:: uploadVerifications: ", e);
                        handleError(e);
                    }
                }
            }
            new VerificationOperation().validateVerification(vrfctn, true);
        }
    }

    private void handleError(Exception e){
        if(Util.isNetworkError(e)){
            SyncManager.sendStatus(SyncManager.SYNC_GENERIC_ERROR);
        }else {
            SyncManager.sendStatus(SyncManager.SYNC_CONNECTION_ERROR);
        }
    }
}
