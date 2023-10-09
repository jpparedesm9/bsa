package com.cobis.gestionasesores.presentation.sections;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.widget.Toast;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.presentation.error.ErrorBaseFragment;
import com.cobis.gestionasesores.presentation.person.PersonActivity;

public abstract class SectionFragment extends ErrorBaseFragment implements SectionViewBase{
    protected ProgressDialog mProgressDialog;

    @Override
    public void sendResult(boolean isSuccess, int prospectId) {
        getActivity().setResult(isSuccess? Activity.RESULT_OK: Activity.RESULT_CANCELED, PersonActivity.newIntent(prospectId));
        getActivity().finish();
    }

    @Override
    public void showSaveError(String message) {
        new AlertDialog.Builder(getContext())
                .setMessage(StringUtils.isNotEmpty(message)?message: getString(R.string.error_save))
                .setCancelable(false)
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
    public void showFinishedMessage(final boolean isSuccess, final int personId, String message) {
        if (message == null) {
            Toast.makeText(getContext(), getString(R.string.form_section_finished_msg), Toast.LENGTH_SHORT).show();
        } else {
            new AlertDialog.Builder(getContext())
                    .setMessage(message)
                    .setCancelable(false)
                    .setPositiveButton(R.string.action_accept, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            sendResult(isSuccess, personId);
                        }
                    })
                    .show();
        }
    }


    @Override
    public void hideProgress() {
        if(mProgressDialog != null && mProgressDialog.isShowing()){
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showSaveProgress() {
        showProgress(getString(R.string.progress_save_msg));
    }

    @Override
    public void showLoadSectionProgress() {
        showProgress(getString(R.string.progress_load_msg));
    }

    private void showProgress(String message){
        if(mProgressDialog == null){
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(message);
            mProgressDialog.setCancelable(false);
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.show();
        }
    }
}
