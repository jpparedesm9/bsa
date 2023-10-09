package com.cobis.gestionasesores.presentation.error;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.ServerAction;

public abstract class ErrorBaseFragment extends Fragment implements ErrorBaseContract.ErrorBaseView {

    private ErrorBaseContract.ErrorBasePresenter mErrorBasePresenter;

    protected TextView txtSyncError;
    private View errorParent;

    private boolean isInfoEnabled = false;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        txtSyncError = view.findViewById(R.id.txt_error);
        if (txtSyncError != null) {
            errorParent = (View) txtSyncError.getParent();
        }
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.server_action, menu);
    }

    @Override
    public void onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        menu.findItem(R.id.menu_server_action).setVisible(isInfoEnabled);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_server_action:
                mErrorBasePresenter.onClickInfo();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void setErrorPresenter(ErrorBaseContract.ErrorBasePresenter presenter) {
        mErrorBasePresenter = presenter;
    }

    @Override
    public void showSyncError(String message) {
        if (txtSyncError != null) {
            txtSyncError.setText(message);
        }
        if (errorParent != null) {
            errorParent.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void hideSyncError() {
        if (errorParent != null) {
            errorParent.setVisibility(View.GONE);
        }
    }

    @Override
    public void enableInfo() {
        isInfoEnabled = true;
        getActivity().invalidateOptionsMenu();
    }

    @Override
    public void showAction(ServerAction action) {
        new AlertDialog.Builder(getContext())
                .setTitle(action.getName())
                .setMessage(action.getDescription())
                .setCancelable(false)
                .setPositiveButton(R.string.action_accept, null)
                .show();
        action.setRead(false);
    }
}
