package com.cobis.gestionasesores.presentation.group;

import android.app.Activity;
import android.app.ProgressDialog;
import android.app.TimePickerDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import com.bayteq.libcore.util.ConvertUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.MeetingLocation;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.presentation.customers.CustomersPresenter;
import com.cobis.gestionasesores.presentation.customers.SelectCustomerActivity;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.groups.MemberAdapter;
import com.cobis.gestionasesores.presentation.member.MemberActivity;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.widgets.AddressInputEditText;
import com.cobis.gestionasesores.widgets.RegexInputFilter;
import com.cobis.gestionasesores.widgets.TimePickerFragment;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class GroupFragment extends ErrorBaseFragment implements GroupContract.View, TimePickerDialog.OnTimeSetListener, MemberAdapter.OnItemClickListener {
    private static final int REQUEST_CUSTOMER = 1;
    private static final int REQUEST_MEMBER = 2;

    private static final String TIME_DIALOG = "time_dialog";

    private GroupContract.Presenter mPresenter;

    @BindView(R.id.input_name)
    TextInputEditText mNameEditText;
    @BindView(R.id.input_number)
    TextInputEditText mNumberEditText;
    @BindView(R.id.input_cycle)
    TextInputEditText mCycleEditText;
    @BindView(R.id.input_time_meeting)
    TextInputEditText mTimeMeetingEditText;
    @BindView(R.id.spinner_day_meeting)
    Spinner mDayMeetingSpinner;
    @BindView(R.id.recycler_members)
    RecyclerView mMembersRecyclerView;
    @BindView(R.id.text_members_header)
    TextView mMembersHeaderText;
    @BindView(R.id.text_members_error)
    TextView mMembersErrorText;
    @BindView(R.id.button_delete_location)
    ImageButton mDeleteLocationMeetingButton;

    @BindView(R.id.input_layout_name)
    TextInputLayout mNameInputLayout;
    @BindView(R.id.input_layout_number)
    TextInputLayout mNumberInputLayout;
    @BindView(R.id.input_layout_time_meeting)
    TextInputLayout mTimeMeetingInputLayout;
    @BindView(R.id.input_layout_cycle)
    TextInputLayout mCycleInputLayout;
    @BindView(R.id.input_meeting_location)
    AddressInputEditText mMeetingLocationTextView;
    @BindView(R.id.layout_members_section)
    View mMembersSectionView;
    @BindView(R.id.button_save_group_info)
    Button saveGroupInfoBtn;

    @BindView(R.id.button_add_member)
    Button mAddMemberButton;


    private CatalogItemAdapter mDayMeetingAdapter;
    private MemberAdapter mAdapter;

    private boolean mIsDeleteOptionEnabled = false;

    private ProgressDialog mProgressDialog;

    public static GroupFragment newInstance() {
        Bundle args = new Bundle();
        GroupFragment fragment = new GroupFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_group, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mTimeMeetingEditText.setKeyListener(null);
        mDayMeetingAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.group_hint_day_meeting);
        mDayMeetingSpinner.setAdapter(mDayMeetingAdapter);
        mCycleEditText.setText(String.valueOf(getResources().getInteger(R.integer.default_cycle_group)));

        mNameEditText.setFilters(new InputFilter[]{new RegexInputFilter(RegexInputFilter.REGEX_LETTERS_AND_NUMBERS), new InputFilter.AllCaps()});

        //Your RecyclerView
        mMembersRecyclerView.setHasFixedSize(true);
        mMembersRecyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        mMembersRecyclerView.addItemDecoration(new DividerItemDecoration(getContext(), LinearLayoutManager.VERTICAL));

        mAdapter = new MemberAdapter(new ArrayList<Member>(0), this);
        mMembersRecyclerView.setAdapter(mAdapter);
        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_group, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        menu.findItem(R.id.menu_delete).setVisible(mIsDeleteOptionEnabled);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_group:
                mPresenter.onClickSave(buildGroup());
                return true;
            case R.id.menu_delete:
                mPresenter.onClickDelete();
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_CUSTOMER && resultCode == Activity.RESULT_OK) {
            mPresenter.onCustomerResult((Person) data.getSerializableExtra(SelectCustomerActivity.EXTRA_CUSTOMER), mAdapter.getMembers());
        } else if (requestCode == REQUEST_MEMBER && resultCode == Activity.RESULT_OK) {
            mPresenter.onMemberResult(data.getIntExtra(MemberActivity.EXTRA_RESULT, 0));
        }
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @OnClick(R.id.input_time_meeting)
    public void onClickTimeToMeeting(View view) {
        mPresenter.onClickTimeToMeeting((Long) mTimeMeetingEditText.getTag());
    }

    @OnClick(R.id.button_add_member)
    public void onClickAddMember(View view) {
        mPresenter.onClickAddMember(mAdapter.getMembers());
    }

    @OnClick(R.id.button_delete_location)
    public void onClickDeleteLocationMeeting(View view) {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.group_dialog_delete_location)).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                mPresenter.onDeleteLocationMeeting(mAdapter.getMembers());
            }
        }).setNegativeButton(R.string.action_cancel, null).show();
    }

    @Override
    public void setPresenter(GroupContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void enableName(boolean enable) {
        if (enable) {
            mNameEditText.setEnabled(true);
        } else {
            mNameEditText.setKeyListener(null);
            mNameEditText.setFocusable(false);
            mNameEditText.setEnabled(false);
        }

    }

    @Override
    public void showTimePicker(Long time) {
        TimePickerFragment fragment = (TimePickerFragment) getActivity().getSupportFragmentManager().findFragmentByTag(TIME_DIALOG);
        if (fragment == null) {
            fragment = TimePickerFragment.newInstance(time);
            fragment.setOnTimeSetListener(this);
            fragment.show(getActivity().getSupportFragmentManager(), TIME_DIALOG);
        }
    }

    @Override
    public void showTimeToMeeting(Long time) {
        mTimeMeetingEditText.setText(DateUtils.formatTime(time));
        mTimeMeetingEditText.setTag(time);
    }

    @Override
    public void showDayOfWeek(List<CatalogItem> items) {
        mDayMeetingAdapter.setCatalogItems(items);
    }

    @Override
    public void setGroupData(Group group) {
        mNameEditText.setText(StringUtils.nullToString(group.getName()));
        mDayMeetingSpinner.setSelection(mDayMeetingAdapter.getItemPositionByCode(group.getDayMeeting()));
        showTimeToMeeting(group.getTimeMeeting());

        mCycleEditText.setText(String.valueOf(group.getCycle()));
        mNumberEditText.setText(String.valueOf(group.getServerId()));
    }

    @Override
    public void showNameError() {
        mNameInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showDayMeetingError() {
        mDayMeetingAdapter.showError(R.string.val_field_required);
    }

    @Override
    public void showTimeToMeetingError() {
        mTimeMeetingInputLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void clearErrors() {
        mNameInputLayout.setErrorEnabled(false);
        mDayMeetingAdapter.clearError();
        mTimeMeetingInputLayout.setErrorEnabled(false);
        mMembersErrorText.setVisibility(View.INVISIBLE);
    }

    @Override
    public void showMessageDeleteSuccess(String message) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.group_msg_delete), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            closeAndExit();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showPositionGroupError() {
        showMembersError(getString(R.string.group_error_position_group));
    }

    @Override
    public void showMeetingLocationError() {
        showMembersError(getString(R.string.group_error_meeting_location));
    }

    @Override
    public void showMeetingLocation(String location) {
        setLocationMeetingText(location);
    }

    @Override
    public void showMeetingLocationByCode(String meetingLocation) {
        switch (meetingLocation) {
            case MeetingLocation.HOME:
                setLocationMeetingText(getString(R.string.location_home));
                break;
            case MeetingLocation.WORK:
                setLocationMeetingText(getString(R.string.location_work));
                break;
            default:
                setLocationMeetingText(null);
        }
    }

    @Override
    public void showSaveProgress() {
        showProgress(getString(R.string.group_msg_saving));
    }

    private void showProgress(String message) {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setMessage(message);
            mProgressDialog.show();
        }
    }

    @Override
    public void hideProgress() {
        if (isAdded() && mProgressDialog != null) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void toggleMemberSection(boolean shouldShow) {
        mMembersSectionView.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        mMeetingLocationTextView.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        if (!isMeetingLocationEmpty()) {
            mDeleteLocationMeetingButton.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        }
    }

    @Override
    public boolean isMeetingLocationEmpty() {
        return StringUtils.isEmpty(mMeetingLocationTextView.getText());
    }

    @Override
    public void showCantEditGroup() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.group_error_cant_edit_members)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showLoadProgress(boolean messageValidate) {
        if (messageValidate) {
            showProgress(getString(R.string.group_msg_validating));
        } else {
            showProgress(getString(R.string.group_msg_loading));
        }
    }

    @Override
    public void showCreateButton() {
        saveGroupInfoBtn.setText(R.string.group_create);
    }

    @Override
    public void showUpdateButton() {
        saveGroupInfoBtn.setText(R.string.group_update);
    }

    @Override
    public void showConfirmDelete() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.group_dialog_delete).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                mPresenter.onConfirmDelete();
                dialogInterface.dismiss();
            }
        }).setNegativeButton(R.string.action_cancel, null).show();
    }

    @Override
    public void showDeleteOption(boolean show) {
        mIsDeleteOptionEnabled = show;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showLocationDeleteOption(boolean show) {
        mDeleteLocationMeetingButton.setVisibility(show ? View.VISIBLE : View.GONE);
    }

    private void setLocationMeetingText(String value) {
        mMeetingLocationTextView.setText(value);
    }

    @Override
    public void showMessageSaveSuccess(String message) {
        if (message == null) {
            Toast.makeText(getContext(), R.string.group_msg_save, Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, null)
                    .show();
        }
    }

    @Override
    public void showMembers(List<Member> members) {
        mAdapter.updateAll(members);
    }

    @Override
    public void showTotalMembers(int count) {
        mMembersHeaderText.setText(getString(R.string.group_members_title, count));
    }

    @Override
    public void showDeleteError() {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.operation_fail_message)).setPositiveButton(getString(R.string.action_accept), null).show();
    }

    @Override
    public void showSaveError(String message) {
        new AlertDialog.Builder(getContext()).setMessage(StringUtils.isNotEmpty(message) ? message : getString(R.string.error_save)).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showAddMemberAction(boolean isVisible) {
        if (isAdded()) {
            mAddMemberButton.setVisibility(isVisible ? View.VISIBLE : View.INVISIBLE);
        }
    }

    @Override
    public void startSelectCustomer(int[] spouseIds) {
        startActivityForResult(SelectCustomerActivity.newIntent(getContext(), null, spouseIds, CustomersPresenter.Mode.MEMBER_GROUP), REQUEST_CUSTOMER);
    }

    @Override
    public void startMember(int groupId, Member member, List<Member> currentMembers) {
        startActivityForResult(MemberActivity.newIntent(getContext(), groupId, member, currentMembers), REQUEST_MEMBER);
    }

    @Override
    public void closeAndExit() {
        getActivity().finish();
    }

    @Override
    public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
        mPresenter.setTimeToMeetingSet(hourOfDay, minute);
    }

    @OnClick(R.id.button_save_group_info)
    public void onClickSaveGroup(View view) {
        mPresenter.onClickSave(buildGroup());
    }

    private void showMembersError(String message) {
        mMembersErrorText.setText(message);
        mMembersErrorText.setVisibility(View.VISIBLE);
    }

    private Group buildGroup() {
        return new Group.Builder().setCycle(ConvertUtils.tryToInt(mCycleEditText.getText().toString(), getResources().getInteger(R.integer.default_cycle_group))).setDayMeeting(mDayMeetingAdapter.getItemCode(mDayMeetingSpinner.getSelectedItemPosition())).setName(mNameEditText.getText().toString()).setTimeMeeting((Long) mTimeMeetingEditText.getTag()).setMembers(mAdapter.getMembers()).build();
    }

    @Override
    public void onItemClick(Member item) {
        mPresenter.onClickMember(item, mAdapter.getMembers());
    }
}
