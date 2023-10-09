package com.cobis.gestionasesores.presentation.group;

import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.PositionGroup;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.DeleteGroupUseCase;
import com.cobis.gestionasesores.domain.usecases.GetCustomerAddressNameUseCase;
import com.cobis.gestionasesores.domain.usecases.GetGroupUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveGroupUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class GroupPresenter extends ErrorPresenter implements GroupContract.Presenter {
    @NonNull
    private GroupContract.View mGroupView;
    private int mGroupId;
    private Group mGroup;
    private SaveGroupUseCase mSaveGroupUseCase;
    private GetCustomerAddressNameUseCase mAddressNameUseCase;
    private GetGroupUseCase mGetGroupUseCase;
    private DeleteGroupUseCase mDeleteGroupUseCase;
    private int mMinMembers, mMaxMembers;

    public GroupPresenter(@NonNull GroupContract.View groupView, int groupId, SaveGroupUseCase saveGroupUseCase, GetCustomerAddressNameUseCase getAddressNameUseCase, GetGroupUseCase getGroupUseCase, DeleteGroupUseCase deleteGroupUseCase) {
        super(groupView);
        mGroupView = groupView;
        mDeleteGroupUseCase = deleteGroupUseCase;
        mGroupId = groupId;
        mSaveGroupUseCase = saveGroupUseCase;
        mAddressNameUseCase = getAddressNameUseCase;
        mGetGroupUseCase = getGroupUseCase;

        mGroupView.setPresenter(this);

        mMaxMembers = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MAX_MEMBER);
        mMinMembers = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.MIN_MEMBER);
    }

    @Override
    public void start() {
        loadGroup(mGroupId, true, false);
    }

    @Override
    public void onClickTimeToMeeting(Long currentTime) {
        mGroupView.showTimePicker(currentTime);
    }

    @Override
    public void setTimeToMeetingSet(int hourOfDay, int minute) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, hourOfDay);
        calendar.set(Calendar.MINUTE, minute);
        mGroupView.showTimeToMeeting(calendar.getTime().getTime());
    }

    @Override
    public void onClickSave(final Group group) {
        if(mGroup != null && !mGroup.canEditMembers()){
            mGroupView.showCantEditGroup();
            return;
        }

        mGroupView.clearErrors();
        boolean isValidMembers = true;
        if (group.getMembers() != null && group.getMembers().size() >= mMinMembers) {
            isValidMembers = isValidMembers(group.getMembers());
        }
        if (isValidMembers && isValidGroup(group)) {
            if (mGroup != null) {
                group.setServerId(mGroup.getServerId());
                group.setId(mGroup.getId());
                group.setAction(mGroup.getAction());
                group.setCanEditMembers(mGroup.canEditMembers());
            }
            mGroupView.showSaveProgress();
            mSaveGroupUseCase.execute(group, new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData saveResult) {
                    if (saveResult.getType() == ResultType.SUCCESS) {
                        mGroupView.showMessageSaveSuccess(saveResult.getErrorMessage());
                        mGroup = (Group) saveResult.getData();
                        mGroupId = mGroup.getId();
                        initGroupData(mGroup);
                    } else {
                        mGroupView.showSaveError(saveResult.getErrorMessage());
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    Log.e("GroupPresenter: Error in saveGroup! ", e);
                    mGroupView.hideProgress();
                    if (Util.isNetworkError(e)) {
                        mGroupView.showNetworkError();
                    } else {
                        mGroupView.showSaveError(null);
                    }
                }

                @Override
                public void onComplete() {
                    mGroupView.hideProgress();
                }
            });
        }
    }

    @Override
    public void onClickDelete() {
        mGroupView.showConfirmDelete();
    }

    @Override
    public void onConfirmDelete() {
        mDeleteGroupUseCase.execute(mGroup.getId(), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(ResultData resultData) {
                mGroupView.showMessageDeleteSuccess(resultData.getErrorMessage());

                if (resultData.getErrorMessage() == null) {
                    mGroupView.closeAndExit();
                }
            }

            @Override
            public void onError(Throwable e) {
                mGroupView.showDeleteError();
                mGroupView.closeAndExit();
            }

            @Override
            public void onComplete() {

            }
        });
    }

    @Override
    public void onClickAddMember(List<Member> members) {
        if(mGroup != null && !mGroup.canEditMembers()){
            mGroupView.showCantEditGroup();
            return;
        }

        List<Integer> identifiers = new ArrayList<>();
        if (members.size() > 0) {
            for (Member member : members) {
                identifiers.add(member.getServerId());
                if (member.getLocalSpouseId() > 0) {
                    identifiers.add(member.getLocalSpouseId());
                }
            }
        }
        mGroupView.startSelectCustomer(Util.convertIntegers(identifiers));
    }

    @Override
    public void onCustomerResult(Person customer, List<Member> currentMembers) {
        Member member = new Member.Builder()
                .addLocalSpouseId(customer.getSpouseId())
                .addServerId(customer.getServerId())
                .addRfc(customer.getDocument())
                .addName(customer.getName())
                .addRiskLevel(customer.getRiskLevel())
                .build();
        mGroupView.startMember(mGroupId, member, currentMembers);
    }

    @Override
    public void onClickMember(Member member, List<Member> currentMembers) {
        if(mGroup != null && !mGroup.canEditMembers()){
            mGroupView.showCantEditGroup();
            return;
        }
        mGroupView.startMember(mGroupId, member, currentMembers);
    }

    @Override
    public void onMemberResult(int membersCount) {
        loadGroup(mGroupId, false, membersCount >= mMinMembers);
    }

    @Override
    public void onDeleteLocationMeeting(List<Member> members) {
        if(mGroup != null && !mGroup.canEditMembers()){
            mGroupView.showCantEditGroup();
            return;
        }

        Member member = getMeetingLocation(members);
        if (member != null) {
            member.setMeetingLocation(null);
            for (int i = 0; i < members.size(); i++) {
                if (members.get(i).getServerId() == member.getServerId()) {
                    members.set(i, member);
                    break;
                }
            }
        }
        loadMembers(members);
    }

    private void loadGroup(int id, final boolean firstTime, boolean enableValidate) {
        if (id > 0) {
            mGroupView.showLoadProgress(enableValidate);
            mGetGroupUseCase.execute(new GetGroupUseCase.Params(id, enableValidate), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultData) {
                    mGroup = (Group) resultData.getData();
                    if (firstTime) {
                        loadCatalogs();
                    } else {
                        if (resultData.getType() == ResultType.FAILURE && resultData.getErrorMessage() != null) {
                            mGroupView.showSaveError(resultData.getErrorMessage());
                        }
                        initGroupData(mGroup);
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    Log.e("GroupPresenter: Error in loadGroup! ", e);
                    mGroupView.hideProgress();
                }

                @Override
                public void onComplete() {
                    mGroupView.hideProgress();
                }
            });
        } else {
            loadCatalogs();
        }
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_DAY_OF_WEEK};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
            @Override
            public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                    handleCatalogItems(entry.getKey(), entry.getValue());
                }
                initGroupData(mGroup);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("CustomerDataPresenter: Error getCatalogItemsByCodes! ", e);
            }

            @Override
            public void onComplete() {
            }
        });
    }

    private void initGroupData(Group group) {
        if (group != null) {
            mGroupView.showUpdateButton();
            mGroupView.toggleMemberSection(true);
            mGroupView.setGroupData(group);
            mGroupView.enableName(group.getServerId() <= 0);
            mGroupView.showLocationDeleteOption(group.getServerId() <= 0 && !mGroupView.isMeetingLocationEmpty());
            mGroupView.showDeleteOption(group.getServerId() <= 0);
            loadMembers(group.getMembers());
        } else {
            mGroupView.showCreateButton();
            mGroupView.toggleMemberSection(false);
            loadMembers(null);
        }
        checkError(group);
    }

    private void loadMembers(List<Member> members) {
        int membersCount = 0;
        if (members != null) {
            //Meeting location
            Member member = getMeetingLocation(members);
            if (member != null) {
                loadMeetingLocation(member);
            } else {
                mGroupView.showMeetingLocation("");
            }

            //members list
            List<Member> positionsMembers = filterMemberByPosition(members, true);
            if (positionsMembers.size() > 0) {
                Collections.sort(positionsMembers, new Comparator<Member>() {
                    @Override
                    public int compare(Member member, Member t1) {
                        int order = Util.getPositionGroupOrder(member.getPosition());
                        int order2 = Util.getPositionGroupOrder(t1.getPosition());
                        if (order == order2) {
                            return 0;
                        } else if (order > order2) {
                            return -1;
                        } else {
                            return 1;
                        }
                    }
                });
            }

            List<Member> singleMembers = filterMemberByPosition(members, false);
            if (singleMembers.size() > 0) {
                Collections.sort(singleMembers, new Comparator<Member>() {
                    @Override
                    public int compare(Member o1, Member o2) {
                        if (o1.getName() != null && o2.getName() != null) {
                            return o1.getName().toLowerCase().compareTo(o2.getName().toLowerCase());
                        } else {
                            return 0;
                        }
                    }
                });
            }
            List<Member> result = new ArrayList<>();
            result.addAll(positionsMembers);
            result.addAll(singleMembers);
            membersCount = result.size();
            mGroupView.showMembers(result);
        }

        //update count view
        mGroupView.showTotalMembers(membersCount);
        mGroupView.showAddMemberAction(membersCount < mMaxMembers);
    }

    private void loadMeetingLocation(final Member member) {
        mAddressNameUseCase.execute(member, new DisposableObserver<String>() {
            @Override
            public void onNext(@NonNull String name) {
                if (StringUtils.isNotEmpty(name)) {
                    mGroupView.showMeetingLocation(name);
                } else {
                    mGroupView.showMeetingLocationByCode(member.getMeetingLocation());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mGroupView.showMeetingLocationByCode(member.getMeetingLocation());
            }

            @Override
            public void onComplete() {
            }
        });
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_DAY_OF_WEEK:
                mGroupView.showDayOfWeek(items);
                break;
        }
    }

    private boolean isValidGroup(Group group) {
        boolean isValid = true;
        if (StringUtils.isEmpty(group.getName())) {
            mGroupView.showNameError();
            isValid = false;
        }

        if (StringUtils.isEmpty(group.getDayMeeting())) {
            mGroupView.showDayMeetingError();
            isValid = false;
        }

        if (group.getTimeMeeting() == null) {
            mGroupView.showTimeToMeetingError();
            isValid = false;
        }
        return isValid;
    }

    private boolean isValidMembers(List<Member> members) {
        boolean isValid = true;

        //check positions group
//        boolean existPresident = existPosition(members, PositionGroup.PRESIDENT);
//        boolean existSecretary = existPosition(members, PositionGroup.SECRETARY);
//        boolean existTreasurer = existPosition(members, PositionGroup.TREASURER);
//        if (!existPresident || !existSecretary || !existTreasurer) {
//            mGroupView.showPositionGroupError();
//            isValid = false;
//        }

        //check meeting place
        if (getMeetingLocation(members) == null) {
            mGroupView.showMeetingLocationError();
            isValid = false;
        }
        return isValid;
    }

    /**
     * Filter list of the members by position
     *
     * @param members     List of the members
     * @param hasPosition Flag to filter
     * @return Sub-list of the members
     */
    private static List<Member> filterMemberByPosition(List<Member> members, boolean hasPosition) {
        List<Member> tmp = new ArrayList<>();
        for (Member member : members) {
            if (hasPosition) {
                if (StringUtils.isNotEmpty(member.getPosition())) {
                    tmp.add(member);
                }
            } else {
                if (StringUtils.isEmpty(member.getPosition())) {
                    tmp.add(member);
                }
            }
        }
        return tmp;
    }

    /**
     * Checks if exists position group
     *
     * @param members  List of the members
     * @param position {@link PositionGroup} position group
     * @return True if position group exists and false in otherwise
     */
    private static boolean existPosition(List<Member> members, @PositionGroup String position) {
        for (Member member : members) {
            if (StringUtils.nullToString(member.getPosition()).equals(position)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Gets a meeting location of the group
     *
     * @param members List of the members
     * @return Member
     */
    public static Member getMeetingLocation(List<Member> members) {
        for (Member member : members) {
            if (StringUtils.isNotEmpty(member.getMeetingLocation())) {
                return member;
            }
        }
        return null;
    }
}
