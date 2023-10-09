package com.cobis.gestionasesores.presentation.memberverification;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.location.Location;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.DividerItemDecoration;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.widgets.GeoMapDialog;
import com.cobis.gestionasesores.widgets.GeoReferenceDialog;
import com.cobis.gestionasesores.widgets.form.QuestionAdapter;

import java.net.UnknownServiceException;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MemberVerificationFragment extends ErrorBaseFragment implements MemberVerificationContract.View, QuestionAdapter.QuestionListener, GeoMapDialog.GeoReferenceListener {

    public static final String GEO_DIALOG = "geo_dialog";
    @BindView(R.id.list_questions)
    RecyclerView mQuestionsList;
    @BindView(R.id.text_customer_name)
    TextView mNameText;
    private MemberVerificationContract.Presenter mPresenter;
    private ProgressDialog mProgressDialog;
    private boolean isVisibleActions = true;
    private QuestionAdapter mAdapter;

    public static MemberVerificationFragment newInstance() {
        Bundle args = new Bundle();
        MemberVerificationFragment fragment = new MemberVerificationFragment();
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
        return inflater.inflate(R.layout.fragment_member_verification, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);

        mAdapter = new QuestionAdapter(this);
        mQuestionsList.setLayoutManager(new LinearLayoutManager(getContext()));
        mQuestionsList.addItemDecoration(new DividerItemDecoration(getContext(), DividerItemDecoration.VERTICAL));
        mQuestionsList.setAdapter(mAdapter);

        mPresenter.start();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.verification, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        menu.findItem(R.id.menu_finish).setVisible(isVisibleActions);
        menu.findItem(R.id.menu_save_draft).setVisible(isVisibleActions);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish:
                mPresenter.onSave(mAdapter.getQuestions());
                return true;
            case R.id.menu_save_draft:
                mPresenter.onSaveDraft(mAdapter.getQuestions(), false);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setPresenter(MemberVerificationContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showName(String name) {
        mNameText.setText(name);
    }

    @Override
    public void showQuestions(List<Question> questions) {
        mAdapter.setQuestions(questions);
    }

    @Override
    public void showSaveProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(R.string.member_verification_save_msg));
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setCancelable(false);
            mProgressDialog.show();
        }
    }

    @Override
    public void hideSaveProgress() {
        if (mProgressDialog != null) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showSaveError(String error) {
        new AlertDialog.Builder(getContext())
                .setMessage(error != null ? error : getString(R.string.error_save))
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void showConfirmSaveChanges() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.member_verification_saved_draft_msg)
                .setPositiveButton(R.string.action_save, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        mPresenter.onSaveDraft(mAdapter.getQuestions(), true);
                    }
                })
                .setNegativeButton(R.string.action_discard, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        exit();
                    }
                })
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
    public void showSaveSuccess(String message, final boolean exit) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.member_verification_saved_msg), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            if (exit) {
                                sendResult();
                            }
                        }
                    })
                    .show();
        }
    }

    @Override
    public void showQuestionError(String code) {
        mAdapter.setError(code);
    }

    @Override
    public void clearErrors() {
        mAdapter.clearErrors();
    }

    @Override
    public void sendResult() {
        getActivity().setResult(Activity.RESULT_OK);
        exit();
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void viewQuestion(String code) {
        mQuestionsList.smoothScrollToPosition(mAdapter.getPositionByCode(code));
    }

    @Override
    public void updateQuestion(Question question) {
        mAdapter.updateQuestion(question);
    }

    @Override
    public void requestGeoReference(GeoReferenceDialog.GeoReferenceListener listener) {
        Fragment prev = getActivity().getSupportFragmentManager().findFragmentByTag(GEO_DIALOG);
        if (prev != null) {
            getActivity().getSupportFragmentManager().beginTransaction().remove(prev).commit();
        }

        GeoReferenceDialog newFragment = GeoReferenceDialog.newInstance();
        newFragment.setCancelable(false);
        newFragment.setListener(listener);
        newFragment.show(getActivity().getSupportFragmentManager(), GEO_DIALOG);
    }

    @Override
    public void hideActions(boolean isEnabled) {
        isVisibleActions = isEnabled;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showGpsMapDialog(Question question, GeoReference geoReference) {
        if (NetworkUtils.isOnline()){
            GeoMapDialog mapDialog = new GeoMapDialog();
            mapDialog.setListener(this);
            mapDialog.setQuestion(question);
            mapDialog.setQuestionLocation(geoReference);
            mapDialog.show(getFragmentManager(), GEO_DIALOG);
        }else {
            mPresenter.setGpsToQuestion(question);
        }

    }

    @Override
    public void showGeoLocationError() {
        Toast.makeText(getContext(), R.string.geo_reference_error_index_question, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void activateQuestion(Question question) {
        mAdapter.activateQuestion(question);
    }

    @Override
    public void activateGpsQuestions() {
        mAdapter.activateGpsQuestions();
    }

    @Override
    public void showGpsIsTooFar(Location Userlocation, Location questionLocation) {
        String message = getString(R.string.geo_reference_error_pin_to_far);
        message+=("\nPosición GPS: " + Userlocation.getLatitude() + ", " + Userlocation.getLongitude());
        message+=("\nPosición Objetivo: " + questionLocation.getLatitude() + ", " + questionLocation.getLongitude());
        Toast.makeText(getContext(), message, Toast.LENGTH_LONG).show();
    }


//    @Override
//    public void showGpsIsTooFar(Location userlocation) {
//        Toast.makeText(getContext(), R.string.geo_reference_error_pin_to_far, Toast.LENGTH_SHORT).show();
//        Toast.makeText(getContext(), "lat: " + userlocation.getLatitude() + "\nlng: " + userlocation.getLongitude(), Toast.LENGTH_LONG).show();
//    }

    @Override
    public void onQuestionValueChange(Question question, String newValue, String oldValue) {
        //This function has been replaced 26/11/2018
        //mPresenter.onChangeQuestion(question, newValue, oldValue);
    }

    @Override
    public void onGpsMapDialogClick(Question question) {
        mPresenter.onGpsMapDialogClick(question);
    }

    @Override
    public void gpsIsClose(Question question, Location markLocation, Location oficialLocation) {
        mPresenter.updateQuestionGeoreference(question, markLocation, oficialLocation);
        //mAdapter.activateQuestion(question);
        activateGpsQuestions();
    }

    @Override
    public void gpsIsFar() {

    }

    @Override
    public void onCancel() {

    }
}