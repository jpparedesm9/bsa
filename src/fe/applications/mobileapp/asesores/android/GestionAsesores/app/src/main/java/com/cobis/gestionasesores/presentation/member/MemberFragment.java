package com.cobis.gestionasesores.presentation.member;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PositionGroup;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.member.moreinformation.MemberInformationActivity;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by bqtdesa02 on 6/16/2017.
 */

public class MemberFragment extends ErrorBaseFragment implements MemberContract.MemberView {

    private static final String RELATED_MEMBER_DIALOG = "related_member_dialog";

    @BindView(R.id.input_layout_name)
    TextInputLayout mNameInputLayout;
    @BindView(R.id.input_layout_voluntary_saving)
    TextInputLayout mVoluntarySavingInputLayout;

    @BindView(R.id.input_name)
    TextInputEditText mNameEditText;
    @BindView(R.id.input_voluntary_saving)
    TextInputEditText mVoluntarySavingEditText;

    @BindView(R.id.list_related_members)
    RecyclerView mRelatedMemberList;
    @BindView(R.id.spinner_position)
    Spinner mPositionSpinner;
    @BindView(R.id.spinner_meeting_location)
    Spinner mMeetingLocationSpinner;
    @BindView(R.id.btn_add_related_member)
    Button mAddRelatedMemberBtn;
    @BindView(R.id.text_list_title)
    TextView mListTitleText;

    private CatalogItemAdapter mPositionAdapter;
    private CatalogItemAdapter mMeetingLocationAdapter;
    private MemberRelationAdapter mMemberRelationAdapter;
    private ProgressDialog mProgressDialog;
    private MemberContract.MemberPresenter mPresenter;
    private boolean mShowDeleteOption = false;

    public static MemberFragment newInstance() {
        Bundle args = new Bundle();
        MemberFragment fragment = new MemberFragment();
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
        return inflater.inflate(R.layout.fragment_member, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mPositionAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.member_hint_position);
        mMeetingLocationAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.member_hint_meeting_location);
        mMemberRelationAdapter = new MemberRelationAdapter(mMemberRelationListener);

        mRelatedMemberList.setLayoutManager(new LinearLayoutManager(getContext()));
        mRelatedMemberList.setAdapter(mMemberRelationAdapter);

        mPositionSpinner.setAdapter(mPositionAdapter);
        mMeetingLocationSpinner.setAdapter(mMeetingLocationAdapter);

        mAddRelatedMemberBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mPresenter.onClickAddRelatedMember(mMemberRelationAdapter.getMemberRelations());
            }
        });

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_member, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        menu.findItem(R.id.menu_delete).setVisible(mShowDeleteOption);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_member:
                mPresenter.onFinishMember();
                return true;
            case R.id.menu_delete:
                mPresenter.onClickDelete();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(MemberContract.MemberPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setMember(Member member) {
        mNameEditText.setText(member.getName());

        mVoluntarySavingEditText.setText(member.getVoluntarySaving());

        if (member.getRelationships() != null) {
            mMemberRelationAdapter.setMemberRelations(member.getRelationships());
        }

        mPositionSpinner.setSelection(mPositionAdapter.getItemPositionByCode(member.getPosition()));
        mMeetingLocationSpinner.setSelection(mMeetingLocationAdapter.getItemPositionByCode(member.getMeetingLocation()));
    }

    @Override
    public Member getMember() {
        return new Member.Builder()
                .addName(mNameEditText.getText().toString())
                .addPosition(mPositionAdapter.getItemCode(mPositionSpinner.getSelectedItemPosition(), PositionGroup.MEMBER))
                .addVoluntarySaving(mVoluntarySavingEditText.getText().toString())
                .addMeetingLocation(mMeetingLocationAdapter.getItemCode(mMeetingLocationSpinner.getSelectedItemPosition()))
                .addRelationships(mMemberRelationAdapter.getMemberRelations())
                .build();
    }

    @Override
    public void sendResult(int newMembers) {
        getActivity().setResult(Activity.RESULT_OK, MemberActivity.newIntentResult(newMembers));
        getActivity().finish();
    }

    @Override
    public void clearErrors() {
        mNameInputLayout.setErrorEnabled(false);
        mVoluntarySavingInputLayout.setErrorEnabled(false);

        mPositionAdapter.clearError();
        mMeetingLocationAdapter.clearError();
    }

    @Override
    public void showPositions(List<CatalogItem> positions) {
        mPositionAdapter.setCatalogItems(positions);
    }

    @Override
    public void showMeetingLocations(List<CatalogItem> locations) {
        mMeetingLocationAdapter.setCatalogItems(locations);
    }

    @Override
    public void hidePositions() {
        mPositionSpinner.setVisibility(View.GONE);
    }

    @Override
    public void hideMeetingLocations() {
        mMeetingLocationSpinner.setVisibility(View.GONE);
    }

    @Override
    public void showVoluntarySaving(String value) {
        mVoluntarySavingEditText.setText(value);
    }

    @Override
    public void showDeleteWarning() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.member_dialog_delete_msg)
                .setPositiveButton(R.string.action_delete, mOnClickAcceptDelete)
                .setNegativeButton(R.string.action_cancel, null)
                .show();
    }

    @Override
    public void showDeleteSuccessMessage(String message, final int result) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.member_delete_success_msg), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            sendResult(result);
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showAddRelatedMemberDialog(List<Member> otherMembers) {
        if (getFragmentManager().findFragmentByTag(RELATED_MEMBER_DIALOG) == null) {
            MemberRelationshipDialog dialog = MemberRelationshipDialog.newInstance(otherMembers);
            dialog.setListener(mRelationListener);
            dialog.show(getFragmentManager(), RELATED_MEMBER_DIALOG);
        }
    }

    @Override
    public void showSaveSuccessMessage(String message, final int result) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.member_save_success_msg), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            sendResult(result);
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showDeleteOption() {
        mShowDeleteOption = true;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showErrorMessage(String message) {
        new AlertDialog.Builder(getContext())
                .setMessage(StringUtils.isNotEmpty(message) ? message : getString(R.string.error_save))
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.error_message_network)
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showSaveProgress() {
        showProgress(R.string.member_save_message);
    }

    @Override
    public void showRemoveRelationProgress() {
        showProgress(R.string.member_remove_relationship_message);
    }

    @Override
    public void showDeleteProgress() {
        showProgress(R.string.member_delete_message);
    }

    @Override
    public void showAddRelation(boolean shouldShow) {
        mAddRelatedMemberBtn.setVisibility(shouldShow ? View.VISIBLE : View.INVISIBLE);
    }

    @Override
    public void toggleRelatedMembers(boolean shouldShow) {
        mAddRelatedMemberBtn.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        mRelatedMemberList.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        mListTitleText.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }

    @Override
    public void hideProgress() {
        if (mProgressDialog != null) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void updateNumberRelations() {
        mListTitleText.setText(getString(R.string.member_relationships_list_title, mMemberRelationAdapter.getItemCount()));
    }

    @Override
    public void startMemberInformation(Member member) {
        startActivity(MemberInformationActivity.newIntent(getContext(), member));
    }

    @Override
    public void showRemoveRelationConfirmation() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.member_remove_relation_message)
                .setNegativeButton(R.string.action_cancel, null)
                .setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        mPresenter.onConfirmRemoveRelation();
                    }
                })
                .setCancelable(false)
                .show();
    }

    @Override
    public void removeMemberRelation(MemberRelation relation, String message) {
        mMemberRelationAdapter.removeMemberRelation(relation);
        if (message != null) {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            updateNumberRelations();
                        }
                    })
                    .show();
        }
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void showLoadProgress() {
        showProgress(R.string.progress_load_msg);
    }

    @OnClick(R.id.btn_member_information)
    public void onClickMemberInformation(View view){
        mPresenter.onClickMoreInformation();
    }

    private DialogInterface.OnClickListener mOnClickAcceptDelete = new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialog, int which) {
            dialog.dismiss();
            mPresenter.onAcceptDelete();
        }
    };

    private MemberRelationshipDialog.MemberRelationListener mRelationListener = new MemberRelationshipDialog.MemberRelationListener() {
        @Override
        public void onSelected(MemberRelation relation) {
            mMemberRelationAdapter.addMemberRelation(relation);
            mPresenter.onMemberAdded(mMemberRelationAdapter.getMemberRelations());
        }
    };

    private void showProgress(@StringRes int message) {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(message));
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.show();
        }
    }

    private MemberRelationAdapter.MemberRelationListener mMemberRelationListener = new MemberRelationAdapter.MemberRelationListener() {
        @Override
        public void onClickRemove(MemberRelation relation) {
            mPresenter.onTryRemoveRelation(relation);
        }
    };
}
