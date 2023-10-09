package com.cobis.gestionasesores.data.repositories;

import android.util.SparseArray;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.SyncItemStatus;
import com.cobis.gestionasesores.data.mappers.CustomerMapper;
import com.cobis.gestionasesores.data.mappers.GroupCreditAppMapper;
import com.cobis.gestionasesores.data.mappers.GroupMapper;
import com.cobis.gestionasesores.data.mappers.IndividualCreditMapper;
import com.cobis.gestionasesores.data.mappers.SyncItemMapper;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.models.IndividualCreditApp;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.SyncItem;
import com.cobis.gestionasesores.data.models.requests.SynItemStateRequest;
import com.cobis.gestionasesores.data.models.requests.SyncItemRequest;
import com.cobis.gestionasesores.data.models.responses.CustomerResponse;
import com.cobis.gestionasesores.data.models.responses.CustomerResponseItem;
import com.cobis.gestionasesores.data.models.responses.GenericResponse;
import com.cobis.gestionasesores.data.models.responses.GroupCreditResponse;
import com.cobis.gestionasesores.data.models.responses.GroupResponse;
import com.cobis.gestionasesores.data.models.responses.IndividualCreditResponse;
import com.cobis.gestionasesores.data.models.responses.ParameterResponse;
import com.cobis.gestionasesores.data.models.responses.SyncItemResponse;
import com.cobis.gestionasesores.data.source.SyncDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceCreditApp;
import com.cobis.gestionasesores.data.source.local.PersistenceGroup;
import com.cobis.gestionasesores.data.source.local.PersistencePerson;
import com.cobis.gestionasesores.data.source.local.PersistenceSyncItem;
import com.cobis.gestionasesores.data.source.remote.ParameterService;
import com.cobis.gestionasesores.data.source.remote.SyncItemService;
import com.cobis.gestionasesores.data.source.remote.SyncService;
import com.cobis.gestionasesores.domain.businesslogic.PersonValidator;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mnaunay on 15/08/2017.
 */

public class SyncRepository implements SyncDataSource {
    private static SyncRepository sInstance;

    private SyncRepository() {
    }

    public static SyncRepository getInstance() {
        if (sInstance == null) {
            sInstance = new SyncRepository();
        }
        return sInstance;
    }

    @Override
    public List<SyncItem> downloadSyncItems(String userName) throws Exception {
        SyncItemResponse response = new SyncItemService().getSyncItems(new SyncItemRequest(userName));
        List<SyncItem> syncItems = new ArrayList<>();
        if (response.isResult()) {
            syncItems = SyncItemMapper.fromRemote(response.getData());
        }
        for (SyncItem item : syncItems) {
            switch (item.getStatus()) {
                case SyncItemStatus.PENDING:
                    item.setStatus(SyncItemStatus.DOWNLOADED);
                    break;
                case SyncItemStatus.ERROR:
                    item.setStatus(SyncItemStatus.SYNCED_ERROR);
                    break;
                case SyncItemStatus.DOWNLOADED:
                case SyncItemStatus.SUCCESS:
                case SyncItemStatus.SYNCED_ERROR:
                default:
                    //No need to change status
            }
            saveSyncItem(item);
        }
        return syncItems;
    }

    public List<SyncItem> getSyncItemsByStatus(@SyncItemStatus String status) {
        List<SyncItem> items = new ArrayList<>();
        PersistenceSyncItem persistence = null;
        try {
            persistence = new PersistenceSyncItem();
            items = persistence.getByStatus(status);
        } catch (Exception ex) {
            Log.e("SyncRepository: getSyncItemsByStatus! ", ex);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return items;
    }


    /**
     * Allows save or update sync item in local and remote repository
     *
     * @param item Synchronization Item
     */
    @Override
    public boolean saveSyncItem(SyncItem item) {
        boolean result = false;
        PersistenceSyncItem persistence = null;
        try {
            persistence = new PersistenceSyncItem();
            persistence.beginTransaction();
            if (persistence.exists(item.getServerId())) {
                persistence.updateItem(item.getServerId(), item);
            } else {
                persistence.addItem(item);
            }
            GenericResponse response = new SyncItemService().updateStatus(new SynItemStateRequest(item.getServerId(), item.getStatus()));
            if (!response.isResult()) {
                throw new RuntimeException("Error updating sync item state!");
            }
            persistence.commitTransaction();
            result = true;
        } catch (Exception ex) {
            Log.e("SyncRepository::saveSyncItem: ", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public boolean doIndividualCreditAppSync(SyncItem item) {
        boolean resultDownload = false;
        PersistenceCreditApp persistence = null;
        int successCount = 0;
        try {
            IndividualCreditResponse response;
            persistence = new PersistenceCreditApp();
            persistence.beginTransaction();
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getIndividualCreditApp(item.getServerId(), page);
                if (response.isResult()) {
                    List<IndividualCreditApp> apps = IndividualCreditMapper.fromRemoteListItem(response.getData());

                    for (IndividualCreditApp app : apps) {
                        if (app.getServerId() > 0) {
                            CreditApp appExists = persistence.getByServerId(app.getServerId());
                            if (appExists != null) {
                                app.setId(appExists.getId());
                            }
                        }
                        persistence.saveOrUpdate(app);
                    }
                    successCount += apps.size();
                } else {
                    throw new RuntimeException("IndividualCreditAppSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("IndividualCreditAppSync: not downloaded correctly");
            }
            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception ex) {
            Log.d("SyncRepository::doIndividualCreditAppSync::", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        if (resultDownload) {
            item.setStatus(SyncItemStatus.SUCCESS);
            saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public boolean doGroupCreditSync(SyncItem item) {
        boolean resultDownload = false;
        PersistenceCreditApp persistence = null;
        int successCount = 0;
        List<GroupCreditApp> savedApps = new ArrayList<>();
        try {
            GroupCreditResponse response;
            persistence = new PersistenceCreditApp();
            persistence.beginTransaction();
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getGroupCredit(item.getServerId(), page);
                if (response.isResult()) {
                    List<GroupCreditApp> apps = GroupCreditAppMapper.fromRemoteListItem(response.getData());
                    for (GroupCreditApp app : apps) {
                        if (app.getServerId() > 0) {
                            CreditApp appExists = persistence.getByServerId(app.getServerId());
                            if (appExists != null) {
                                app.setId(appExists.getId());
                            }
                        }
                        int localId = persistence.saveOrUpdate(app);
                        app.setId(localId);
                        savedApps.add(app);
                    }
                    successCount += apps.size();
                } else {
                    throw new RuntimeException("GroupCreditSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("GroupCreditSync: not downloaded correctly");
            }
            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception ex) {
            Log.e("SyncRepository::doGroupCreditSync::", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        if (resultDownload) {
            //this was added to create relationship between group and credit app.
            //Doing this inside the transaction makes this really slow
            PersistenceGroup persistenceGroup = null;
            try {
                persistenceGroup = new PersistenceGroup();
                persistence = new PersistenceCreditApp();
                for (GroupCreditApp app : savedApps) {
                    int groupId = persistenceGroup.getIdByServerId(app.getGroupServerId());
                    if (groupId > 0) {
                        app.setApplicantId(groupId);
                    }
                    persistence.saveOrUpdate(app);
                }
            } catch (Exception ex) {
                Log.e("SyncRepository::doGroupCreditSync::", ex);
            } finally {
                if (persistenceGroup != null) {
                    persistenceGroup.close();
                }
                persistence.close();
            }

            item.setStatus(SyncItemStatus.SUCCESS);
            saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public boolean doGroupSync(SyncItem item) {
        boolean resultDownload = false;
        PersistenceGroup persistence = null;
        SparseArray<Group> groupArray = new SparseArray<>();
        int successCount = 0;
        try {
            GroupResponse response;
            persistence = new PersistenceGroup();
            persistence.beginTransaction();
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getGroup(item.getServerId(), page);
                if (response.isResult()) {
                    List<Group> groups = GroupMapper.fromRemoteListItem(response.getData());
                    for (Group group : groups) {
                        if (group.getServerId() > 0) {
                            Group groupExists = persistence.getByServerId(group.getServerId());
                            if (groupExists != null) {
                                group.setId(groupExists.getId());
                            }
                        }
                        int localId = persistence.saveOrUpdate(group);
                        group.setId(localId);
                        groupArray.put(localId, group);
                    }
                    successCount += groups.size();
                } else {
                    throw new RuntimeException("GroupSync: returned error");
                }
            }
            if (successCount != item.getItemCount()) {
                throw new RuntimeException("GroupSync: not downloaded correctly");
            }

            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception ex) {
            Log.e("SyncRepository::doGroup::", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        //This is done later since it causes conflict with transaction
        if (resultDownload) {
            for (int i = 0; i < groupArray.size(); i++) {
                Group group = groupArray.get(groupArray.keyAt(i));
                List<Member> members = group.getMembers();
                if (members != null) {
                    int[] serverIds = new int[members.size()];
                    for (int x = 0; x < members.size(); x++) {
                        serverIds[x] = members.get(x).getServerId();
                    }
                    PersonRepository.getInstance().updateRelationGroup(serverIds, group.getId());
                }
                PersonRepository.getInstance().cleanUpPersonRelationsGroup(group);
            }

            item.setStatus(SyncItemStatus.SUCCESS);
            saveSyncItem(item);
        }

        return resultDownload;
    }

    @Override
    public boolean doCustomerSync(SyncItem item) {
        boolean resultDownload = false;
        PersistencePerson persistence = null;
        int successCount = 0;
        try {
            CustomerResponse response;
            persistence = new PersistencePerson();
            persistence.beginTransaction();
            int pages = SyncService.getNumberOfPages(item.getItemCount());
            for (int page = 1; page <= pages; page++) {
                response = new SyncService().getCustomer(item.getServerId(), page);
                if (response.isResult()) {
                    List<CustomerResponseItem> customers = response.getData();
                    Person person;
                    for (CustomerResponseItem customer : customers) {
                        if (customer.getCustomerId() > 0) {
                            Person localPerson = persistence.getByServerId(customer.getCustomerId());
                            person = CustomerMapper.parseRemoteCustomer(customer, localPerson);
                            //refresh person sections
                            person = new Person.Builder().build(person);
                            person.setStatus(PersonValidator.checkPersonStatus(person));
                            persistence.saveOrUpdate(person);
                        }
                    }
                    successCount += customers.size();
                } else {
                    throw new RuntimeException("CustomerSync: returned error");
                }
            }

            if (successCount != item.getItemCount()) {
                throw new RuntimeException("CustomerSync: not downloaded correctly");
            }

            persistence.commitTransaction();
            resultDownload = true;
        } catch (Exception ex) {
            Log.e("SyncRepository::doCustomerSync::", ex);
            if (persistence != null && persistence.inTransaction()) {
                persistence.rollbackTransaction();
            }
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }

        if (resultDownload) {
            item.setStatus(SyncItemStatus.SUCCESS);
            saveSyncItem(item);
        }
        return resultDownload;
    }

    @Override
    public ParameterResponse getParametersApp() {
        try {
            return new ParameterService().getParameters();
        } catch (IOException e) {
            return null;
        }
    }
}
