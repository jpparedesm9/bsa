package com.cobis.gestionasesores.presentation.synchronization.upload;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.widgets.Dialog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link UploadFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class UploadFragment extends Fragment implements UploadContract.View, DialogInterface.OnClickListener, DialogInterface.OnMultiChoiceClickListener {

    private boolean preventAll, preventSingle;
    private boolean[] selectedItems, temp;
    private UploadContract.Presenter presenter;
    private ProgressDialog progressLoading;
    private TextView copiedLine;

    @BindView(R.id.text_sync_up)
    TextView txtSyncDescription;
    @BindView(R.id.sync_details)
    LinearLayout syncDetails;
    @BindView(R.id.btn_synchronize)
    Button btnSynchronize;
    @BindView(R.id.progress_bar)
    ProgressBar progressBarSync;
    @BindView(R.id.btn_finish)
    Button btnFinish;

    public UploadFragment() {
        // Required empty public constructor
    }

    public static UploadFragment newInstance() {
        return new UploadFragment();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.menu_sync, menu);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_upload, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        presenter.start();
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        String[] items = getUploadItems();
        if (selectedItems == null) {
            selectedItems = new boolean[items.length];
            for (int i = 0; i < selectedItems.length; i++) {
                selectedItems[i] = true;
            }
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_synchronization_settings:
                return presenter.handleMenuSettings();
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void openMenuSettings() {
        temp = Arrays.copyOf(selectedItems, selectedItems.length);
        Dialog.newInstance(getContext())
                .setBackCancellable(true)
                .setTitle(R.string.sync_title)
                .setMultiChoiceItems(R.array.items_synchronization, temp, this)
                .setNegativeButton(android.R.string.cancel, null)
                .setPositiveButton(android.R.string.ok, this)
                .show(getFragmentManager(), null);
    }

    @Override
    public String[] getUploadItems() {
        return getResources().getStringArray(R.array.items_synchronization);
    }

    @Override
    public void showFinish(boolean show) {
        btnFinish.setVisibility(show ? View.VISIBLE : View.GONE);
    }

    @Override
    public void showFinishSuccess() {
        Toast.makeText(getContext(), getString(R.string.synchronization_msg_success), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.registerReceiver();
    }

    @Override
    public void onPause() {
        super.onPause();
        presenter.unregisterReceiver();
    }

    @OnClick(R.id.btn_synchronize)
    public void onSynchronize(View view) {
        presenter.startSynchronization(selectedItems);
    }

    @Override
    public void setPresenter(UploadContract.Presenter presenter) {
        this.presenter = presenter;
    }

    @Override
    public void appendDetail(String message) {
        TextView txtDetail = makeDetail();
        txtDetail.setText(message);
        syncDetails.addView(txtDetail);
        txtDetail.requestFocus();

        if (copiedLine != null) {
            syncDetails.addView(copiedLine);
            copiedLine = null;
        }
        ((ScrollView) syncDetails.getParent()).fullScroll(ScrollView.FOCUS_DOWN);
    }

    @NonNull
    private TextView makeDetail() {
        TextView txtDetail = new TextView(getContext());
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        txtDetail.setLayoutParams(params);
        return txtDetail;
    }

    @Override
    public void appendDetailWithResourceArg(int message, int type, Object... formatArgs) {
        List<Object> args = new ArrayList<>();
        args.add(type > 0 ? getString(type) : "" + type);
        args.addAll(Arrays.asList(formatArgs));
        appendDetail(message, args.toArray());
    }

    @Override
    public void replaceLastDetailWithResourceArg(int message, int type, Object... formatArgs) {
        List<Object> args = new ArrayList<>();
        args.add(type > 0 ? getString(type) : "" + type);
        args.addAll(Arrays.asList(formatArgs));
        replaceLastDetail(message, args.toArray());
    }

    @Override
    public void appendDetail(@StringRes int message, Object... formatArgs) {
        appendDetail(getString(message, formatArgs));
    }

    @Override
    public void replaceLastDetail(@StringRes int message, Object... formatArgs) {
        if (syncDetails.getChildCount() > 0) {
            syncDetails.removeViewAt(syncDetails.getChildCount() - 1);
        }
        appendDetail(message, formatArgs);
    }

    @Override
    public void clearDetails() {
        syncDetails.removeAllViews();
    }

    @Override
    public void showProgressBar() {
        progressBarSync.setVisibility(View.VISIBLE);
        btnSynchronize.setVisibility(View.GONE);
    }

    @Override
    public void hideProgressBar() {
        progressBarSync.setVisibility(View.GONE);
        btnSynchronize.setVisibility(View.VISIBLE);
    }

    @Override
    public void showLoading() {
        hideLoading();
        progressLoading = new ProgressDialog(getContext());
        progressLoading.setMessage(getString(R.string.synchronization_loading_item_count_msg));
        progressLoading.setCancelable(false);
        progressLoading.setCanceledOnTouchOutside(false);
        progressLoading.show();
    }

    @Override
    public void hideLoading() {
        if (progressLoading != null && progressLoading.isShowing()) {
            progressLoading.dismiss();
            progressLoading = null;
        }
    }

    @Override
    public void setSyncText(@StringRes int message, Object... formatArgs) {
        txtSyncDescription.setText(getString(message, formatArgs));
    }

    @Override
    public void copyLastDetail() {
        if (syncDetails.getChildCount() > 0) {
            copiedLine = makeDetail();
            copiedLine.setText(((TextView) syncDetails.getChildAt(syncDetails.getChildCount() - 1)).getText());
        }
    }

    @Override
    public void showSyncRunning() {
        Toast.makeText(getContext(), getString(R.string.synchronization_sync_running), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void onClick(DialogInterface dialog, int which, boolean isChecked) {
        ListView list = ((AlertDialog) dialog).getListView();
        if (which == 0) {
            if (preventAll) {
                preventAll = false;
            } else {
                preventSingle = true;
                for (int i = 1; i < list.getAdapter().getCount(); i++) {
                    if (isChecked && !list.isItemChecked(i)) {
                        list.performItemClick(list.getChildAt(i), i, list.getItemIdAtPosition(i));
                    } else if (!isChecked && list.isItemChecked(i)) {
                        list.performItemClick(list.getChildAt(i), i, list.getItemIdAtPosition(i));
                    }
                }
                preventSingle = false;
            }
        } else {
            if (!preventSingle) {
                if (isChecked) {
                    boolean checkAll = true;
                    for (int i = 1; i < temp.length; i++) {
                        if (!temp[i]) {
                            checkAll = false;
                            break;
                        }
                    }
                    if (checkAll) {
                        preventAll = true;
                        list.performItemClick(list.getChildAt(0), 0, list.getItemIdAtPosition(0));
                    }
                } else if (temp[0]) {
                    preventAll = true;
                    list.performItemClick(list.getChildAt(0), 0, list.getItemIdAtPosition(0));
                }
            }
        }
    }

    @Override
    public void onClick(DialogInterface dialog, int which) {
        selectedItems = Arrays.copyOf(temp, temp.length);
        presenter.onSelectUploadItems(selectedItems);
    }

    @OnClick(R.id.btn_finish)
    public void onClickFinish(View view) {
        presenter.onClickFinish();
    }
}
