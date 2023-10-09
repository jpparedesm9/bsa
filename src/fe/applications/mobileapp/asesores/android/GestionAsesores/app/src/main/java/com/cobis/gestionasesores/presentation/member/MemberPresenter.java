package com.cobis.gestionasesores.presentation.member;

import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.NetworkUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.DeleteMemberUseCase;
import com.cobis.gestionasesores.domain.usecases.GetMemberUseCase;
import com.cobis.gestionasesores.domain.usecases.RemoveRelationshipUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveMemberUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public class MemberPresenter extends ErrorPresenter implements MemberContract.MemberPresenter {

    private MemberContract.MemberView mView;

    private List<Member> mCurrentMembers;
    private Member mMember;
    private int mLocalGroupId;
    private SaveMemberUseCase mSaveMemberUseCase;
    private RemoveRelationshipUseCase mRemoveRelationshipUseCase;
    private DeleteMemberUseCase mDeleteMemberUseCase;
    private GetMemberUseCase mGetMemberUseCase;

    private MemberRelation mRelationToDelete = null;
    private boolean mSendRelationUpdate = false;
    //Adriana Chiluisa: If we show a server error when saving or deleting member we have to request
    //the group info from server again
    private boolean mTriedToSaveOrDelete = false;

    public MemberPresenter(MemberContract.MemberView view, int localGroupId, Member member, List<Member> currentMembers,
                           SaveMemberUseCase saveMemberUseCase,
                           RemoveRelationshipUseCase removeRelationshipUseCase,
                           DeleteMemberUseCase deleteMemberUseCase,
                           GetMemberUseCase getMemberUseCase) {
        super(view);
        mView = view;
        mMember = member;
        mCurrentMembers = currentMembers;
        mLocalGroupId = localGroupId;
        mSaveMemberUseCase = saveMemberUseCase;
        mRemoveRelationshipUseCase = removeRelationshipUseCase;
        mDeleteMemberUseCase = deleteMemberUseCase;
        mGetMemberUseCase = getMemberUseCase;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadMember();
    }

    @Override
    public void onFinishMember() {
        Member member = mView.getMember();
        if (mMember != null) {
            member.setServerId(mMember.getServerId());
            member.setRfc(mMember.getRfc());
            member.setLocalSpouseId(mMember.getLocalSpouseId());
            member.setRiskLevel(mMember.getRiskLevel());
            member.setSyncedToServer(mMember.isSyncedToServer());
        }
        saveMember(mLocalGroupId, member);
    }

    @Override
    public void onClickDelete() {
        mView.showDeleteWarning();
    }

    @Override
    public void onAcceptDelete() {
        mView.showDeleteProgress();
        mDeleteMemberUseCase.execute(new DeleteMemberUseCase.DeleteMemberRequest(mLocalGroupId, mMember),
                new DisposableObserver<ResultData>() {
                    @Override
                    public void onNext(@NonNull ResultData resultData) {
                        if (resultData.getType() == ResultType.SUCCESS) {
                            mView.showDeleteSuccessMessage(resultData.getErrorMessage(), ConvertUtils.tryToInt(StringUtils.nullToString(resultData.getData()), 0));

                            if (resultData.getErrorMessage() == null) {
                                mView.sendResult(ConvertUtils.tryToInt(StringUtils.nullToString(resultData.getData()), 0));
                            }
                        } else {
                            mTriedToSaveOrDelete = true;
                            mView.showErrorMessage(resultData.getErrorMessage());
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("MemberPresenter: Error in deleteMember! ", e);
                        mView.hideProgress();
                        if (Util.isNetworkError(e)) {
                            mView.showNetworkError();
                        } else {
                            mView.showErrorMessage(null);
                        }
                    }

                    @Override
                    public void onComplete() {
                        mView.hideProgress();
                    }
                });
    }

    @Override
    public void onClickAddRelatedMember(List<MemberRelation> memberRelations) {
        mView.showAddRelatedMemberDialog(getMembersForRelation(mMember, mCurrentMembers, memberRelations));
    }

    @Override
    public void onMemberAdded(List<MemberRelation> currentRelations) {
        List<Member> relatedMembers = getMembersForRelation(mMember, mCurrentMembers, currentRelations);
        mView.showAddRelation(!relatedMembers.isEmpty());
        mView.updateNumberRelations();
    }

    @Override
    public void onClickMoreInformation() {
        mView.startMemberInformation(mMember);
    }

    @Override
    public void onTryRemoveRelation(MemberRelation relation) {
        mRelationToDelete = relation;
        mView.showRemoveRelationConfirmation();
    }

    @Override
    public void onConfirmRemoveRelation() {
        if (mRelationToDelete == null) return;
        mView.showRemoveRelationProgress();
        mRemoveRelationshipUseCase.execute(new RemoveRelationshipUseCase.RemoveRelationRequest(mLocalGroupId, mMember, mRelationToDelete.getCustomerId()),
                new DisposableObserver<ResultData>() {
                    @Override
                    public void onNext(ResultData resultData) {
                        if (resultData.getType() == ResultType.SUCCESS) {
                            mView.removeMemberRelation(mRelationToDelete, resultData.getErrorMessage());

                            if (resultData.getErrorMessage() == null) {
                                mView.updateNumberRelations();
                            }

                            mRelationToDelete = null;
                            mSendRelationUpdate = true;
                        } else {
                            mView.showErrorMessage(resultData.getErrorMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        Log.e("MemberPresenter: Error in removeRelationship! ", e);
                        mView.hideProgress();
                        if (Util.isNetworkError(e)) {
                            mView.showNetworkError();
                        } else {
                            mView.showErrorMessage(null);
                        }
                    }

                    @Override
                    public void onComplete() {
                        mView.hideProgress();
                    }
                });
    }

    @Override
    public void onTryToExit() {
        //If relation was changed or we attempted to save and server showed error we should request group update
        if (mSendRelationUpdate || mTriedToSaveOrDelete) {
            mView.sendResult(mCurrentMembers.size());
        } else {
            mView.exit();
        }
    }

    private void loadMember() {
        if (mMember.isSyncedToServer()) {
            mView.showLoadProgress();
            mGetMemberUseCase.execute(new GetMemberUseCase.GetMemberRequest(mLocalGroupId, mMember.getServerId()),
                    new DisposableObserver<Member>() {
                        @Override
                        public void onNext(Member member) {
                            mMember = member;
                            loadCatalogs();
                        }

                        @Override
                        public void onError(Throwable e) {
                            loadCatalogs();
                        }

                        @Override
                        public void onComplete() {
                            mView.hideProgress();
                        }
                    });
        } else {
            loadCatalogs();
        }
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_FAMILY_RELATIONSHIP, Catalog.CAT_POSITION, Catalog.CAT_MEETING_LOCATION};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initMember(mMember);
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("MemberPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void handleCatalogItems(int code, List<CatalogItem> catalogItems) {
        switch (code) {
            case Catalog.CAT_MEETING_LOCATION:
                checkMeetingLocations(mMember, mCurrentMembers);
                mView.showMeetingLocations(catalogItems);
                break;
            case Catalog.CAT_POSITION:
                List<CatalogItem> availablePositions = checkAvailablePositions(mMember, mCurrentMembers, catalogItems);
                if (availablePositions.isEmpty()) mView.hidePositions();
                mView.showPositions(availablePositions);
                break;
        }
    }

    private void initMember(Member member) {
        List<Member> relatedMembers = getMembersForRelation(member, mCurrentMembers, member == null ? null : member.getRelationships());
        if (member != null) {
            mView.setMember(member);
            if (!isNewMember(member, mCurrentMembers) && (!member.isSyncedToServer() || NetworkUtils.isOnline())) {
                mView.showDeleteOption();
            }
            if (relatedMembers.isEmpty()) {
                mView.toggleRelatedMembers(member.getRelationships() != null && !member.getRelationships().isEmpty());
            } else {
                mView.toggleRelatedMembers(true);
            }
            checkError(member);
        }
        mView.showAddRelation(!relatedMembers.isEmpty());
        mView.updateNumberRelations();
    }

    @NonNull
    private List<CatalogItem> checkAvailablePositions(Member member, List<Member> currentMembers, List<CatalogItem> positions) {
        List<CatalogItem> availablePositions = new ArrayList<>();

        for (CatalogItem position : positions) {
            boolean isAvailable = true;
            for (Member currentMember : currentMembers) {
                if (member != null && member.getServerId() != currentMember.getServerId() && position.getCode().equals(currentMember.getPosition())) {
                    isAvailable = false;
                    break;
                }
            }
            if (isAvailable) {
                availablePositions.add(position);
            }
        }

        return availablePositions;
    }

    private void checkMeetingLocations(Member member, List<Member> currentMembers) {
        if (member != null && member.getMeetingLocation() != null) {
            return;
        }

        boolean isLocationAssigned = false;
        for (Member currentMember : currentMembers) {
            if (StringUtils.isNotEmpty(currentMember.getMeetingLocation())) {
                isLocationAssigned = true;
                break;
            }
        }
        if (isLocationAssigned) {
            mView.hideMeetingLocations();
        }
    }

    private void saveMember(int groupId, Member member) {
        mView.showSaveProgress();
        mSaveMemberUseCase.execute(new SaveMemberUseCase.SaveMemberRequest(groupId, member),
                new DisposableObserver<ResultData>() {
                    @Override
                    public void onNext(@NonNull ResultData resultData) {
                        if (resultData.getType() == ResultType.SUCCESS) {
                            mView.showSaveSuccessMessage(resultData.getErrorMessage(), ConvertUtils.tryToInt(StringUtils.nullToString(resultData.getData()), 0));

                            if (resultData.getErrorMessage() == null) {
                                mView.sendResult(ConvertUtils.tryToInt(StringUtils.nullToString(resultData.getData()), 0));
                            }
                        } else {
                            mTriedToSaveOrDelete = true;
                            mView.showErrorMessage(resultData.getErrorMessage());
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("MemberPresenter: Error in saveMember! ", e);
                        mView.hideProgress();
                        if (Util.isNetworkError(e)) {
                            mView.showNetworkError();
                        } else {
                            mView.showErrorMessage(null);
                        }
                    }

                    @Override
                    public void onComplete() {
                        mView.hideProgress();
                    }
                });
    }

    private List<Member> getMembersForRelation(Member currentMember, List<Member> currentMembers, List<MemberRelation> currentRelations) {
        List<Member> result = new ArrayList<>();

        if (currentMember != null && !currentMembers.isEmpty()) {
            for (Iterator<Member> iterator = currentMembers.iterator(); iterator.hasNext(); ) {
                Member m = iterator.next();
                if (m.getServerId() == currentMember.getServerId()) {
                    iterator.remove();
                }
            }
        }

        for (Member member : currentMembers) {
            if (member.isSyncedToServer()) {
                boolean isFound = false;
                if (currentRelations != null) {
                    for (MemberRelation relation : currentRelations) {
                        if (relation.getCustomerId() == member.getServerId()) {
                            isFound = true;
                            break;
                        }
                    }
                }
                if (!isFound) {
                    result.add(member);
                }
            }
        }

        Collections.sort(result, new Comparator<Member>() {
            @Override
            public int compare(Member member, Member t1) {
                return member.getName().compareTo(t1.getName());
            }
        });

        return result;
    }

    private boolean isNewMember(Member member, List<Member> members) {
        for (Member m : members) {
            if (m.getServerId() == member.getServerId()) {
                return true;
            }
        }
        return false;
    }
}
