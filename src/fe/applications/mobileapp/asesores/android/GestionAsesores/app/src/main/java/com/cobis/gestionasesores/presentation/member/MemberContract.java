package com.cobis.gestionasesores.presentation.member;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public interface MemberContract {

    interface MemberView extends BaseView<MemberPresenter>, ErrorBaseContract.ErrorBaseView{
        void setMember(Member member);
        Member getMember();
        void sendResult(int newMembers);
        void clearErrors();
        void showPositions(List<CatalogItem> positions);
        void showMeetingLocations(List<CatalogItem> locations);
        void hidePositions();
        void hideMeetingLocations();
        void showAddRelation(boolean shouldShow);
        void toggleRelatedMembers(boolean shouldShow);
        void showVoluntarySaving(String value);
        void showDeleteWarning();
        void showDeleteSuccessMessage(String message, int result);
        void showAddRelatedMemberDialog(List<Member> otherMembers);
        void showSaveSuccessMessage(String message, int result);
        void showDeleteOption();
        void showErrorMessage(String message);
        void showNetworkError();
        void showSaveProgress();
        void showRemoveRelationProgress();
        void showDeleteProgress();
        void hideProgress();
        void updateNumberRelations();
        void startMemberInformation(Member member);
        void showRemoveRelationConfirmation();
        void removeMemberRelation(MemberRelation relation, String message);
        void exit();
        void showLoadProgress();
    }

    interface MemberPresenter extends BasePresenter, ErrorBaseContract.ErrorBasePresenter{
        void onFinishMember();
        void onClickDelete();
        void onAcceptDelete();
        void onClickAddRelatedMember(List<MemberRelation> memberRelations);
        void onMemberAdded(List<MemberRelation> currentRelations);
        void onClickMoreInformation();
        void onTryRemoveRelation(MemberRelation relation);
        void onConfirmRemoveRelation();
        void onTryToExit();
    }
}