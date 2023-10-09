package com.cobis.gestionasesores.presentation.group;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

/**
 * Created by mnaunay on 15/06/2017.
 */

public class GroupContract {
    public interface Presenter extends BasePresenter {

        void onClickTimeToMeeting(Long currentTime);

        void setTimeToMeetingSet(int hourOfDay, int minute);

        void onClickSave(Group group);

        void onClickDelete();

        void onConfirmDelete();

        void onClickAddMember(List<Member> members);

        void onCustomerResult(Person customer, List<Member> currentMembers);

        void onClickMember(Member member, List<Member> currentMembers);

        void onMemberResult(int membersCount);

        void onDeleteLocationMeeting(List<Member> members);
    }

    public interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {

        void enableName(boolean enable);

        void showTimePicker(Long time);

        void showTimeToMeeting(Long time);

        void showDayOfWeek(List<CatalogItem> items);

        void setGroupData(Group group);

        void showNameError();

        void showDayMeetingError();

        void showTimeToMeetingError();

        void clearErrors();

        void showMessageSaveSuccess(String message);

        void showMembers(List<Member> members);

        void showTotalMembers(int count);

        void showAddMemberAction(boolean isVisible);

        void startSelectCustomer(int[] spouseIds);

        void startMember(int groupId, Member member, List<Member> currentMembers);

        void closeAndExit();

        void showDeleteError();

        void showNetworkError();

        void showSaveError(String error);

        void showMessageDeleteSuccess(String message);

        void showPositionGroupError();

        void showMeetingLocationError();

        void showMeetingLocation(String location);

        void showMeetingLocationByCode(String meetingLocation);

        void showSaveProgress();

        void hideProgress();

        void toggleMemberSection(boolean shouldShow);

        void showCreateButton();

        void showUpdateButton();

        void showConfirmDelete();

        void showDeleteOption(boolean show);

        void showLocationDeleteOption(boolean show);

        boolean isMeetingLocationEmpty();

        void showCantEditGroup();

        void showLoadProgress(boolean messageValidate);
    }
}
