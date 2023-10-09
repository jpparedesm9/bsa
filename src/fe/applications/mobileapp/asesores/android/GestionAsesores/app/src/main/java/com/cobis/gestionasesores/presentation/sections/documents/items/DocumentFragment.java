package com.cobis.gestionasesores.presentation.sections.documents.items;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.ProgressDialog;
import android.content.ComponentName;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Bundle;
import android.os.Parcelable;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.graphics.drawable.VectorDrawableCompat;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.ImageView;
import android.widget.Toast;

import com.bayteq.libcore.io.FileUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.utils.ResourcesUtil;
import com.cobis.gestionasesores.utils.Util;
import com.squareup.picasso.MemoryPolicy;
import com.squareup.picasso.Picasso;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by mnaunay on 14/06/2017.
 */
public class DocumentFragment extends Fragment implements DocumentContract.View {
    private static final int REQUEST_CODE_PICTURE = 1;
    @BindView(R.id.image_document)
    ImageView mDocumentImage;
    @BindView(R.id.action_take_picture)
    Button mButtonTakePicture;

    private DocumentContract.Presenter mPresenter;
    private String mCameraPhotoPath;
    private String mDocumentPath;
    private ProgressDialog mProgressDialog;

    public static DocumentFragment newInstance() {
        Bundle args = new Bundle();
        DocumentFragment fragment = new DocumentFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_document, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        mPresenter.start();

        if (mPresenter.isEditable()) {
            mButtonTakePicture.setCompoundDrawablesWithIntrinsicBounds(VectorDrawableCompat.create(getResources(), R.drawable.ic_add_photo, null), null, null, null);
        } else {
            mButtonTakePicture.setVisibility(View.GONE);
        }
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        if (mCameraPhotoPath != null) {
            outState.putString("filePath", mCameraPhotoPath);
        }
        super.onSaveInstanceState(outState);
    }

    @Override
    public void onViewStateRestored(Bundle savedInstanceState) {
        super.onViewStateRestored(savedInstanceState);
        if (savedInstanceState != null) {
            if (savedInstanceState.containsKey("filePath")) {
                mCameraPhotoPath = savedInstanceState.getString("filePath");
            }
        }
    }

    @Override
    public void dismissProgress() {
        if (mProgressDialog != null && mProgressDialog.isShowing()) {
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void showDeleteDocumentError() {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.document_error_delete)).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showTitle(String documentType) {
        if (getActivity() != null) {
            ((BaseActivity) getActivity()).getSupportActionBar().setTitle(ResourcesUtil.getDocumentName(documentType));
        }
    }

    @Override
    public void showNetworkError() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.error_message_network).setCancelable(false).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        if (mPresenter.isEditable()) {
            if (mPresenter.isEditMode()) {
                inflater.inflate(R.menu.form_edit_mode, menu);
            }
            inflater.inflate(R.menu.menu_section, menu);
        }
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.menu_finish_section:
                mPresenter.saveDocument(mDocumentPath);
                return true;
            case R.id.menu_delete:
                new AlertDialog.Builder(getContext()).setMessage(R.string.document_dialog_delete).setCancelable(false).setPositiveButton(R.string.action_delete, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dialogInterface.dismiss();
                        mPresenter.deleteDocument();
                    }
                }).setNegativeButton(R.string.action_cancel, null).show();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mCameraPhotoPath != null) {
            FileUtils.delete(mCameraPhotoPath);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE_PICTURE) {
            final boolean isCamera;
            if (data == null || data.getData() == null) {
                isCamera = true;
            } else {
                final String action = data.getAction();
                isCamera = action != null && action.equals(MediaStore.ACTION_IMAGE_CAPTURE);
            }
            Uri selectedImageUri;
            if (isCamera) {
                selectedImageUri = Uri.fromFile(new File(mCameraPhotoPath));
            } else {
                selectedImageUri = data.getData();
            }
            mPresenter.processResultBitmap(selectedImageUri, isCamera);
        }
    }

    @OnClick(R.id.action_take_picture)
    public void onClickPicture(View view) {
        mPresenter.onClickTakePicture();
    }

    @Override
    public void openImageIntent(String path) {
        mCameraPhotoPath = path;

        // Camera.
        final List<Intent> cameraIntents = new ArrayList<>();
        final Intent captureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        final PackageManager packageManager = getActivity().getPackageManager();
        final List<ResolveInfo> listCam = packageManager.queryIntentActivities(captureIntent, 0);
        for (ResolveInfo res : listCam) {
            final String packageName = res.activityInfo.packageName;
            final Intent intent = new Intent(captureIntent);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setComponent(new ComponentName(res.activityInfo.packageName, res.activityInfo.name));
            intent.setPackage(packageName);
            intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(mCameraPhotoPath)));
            cameraIntents.add(intent);
        }

        // Filesystem.
        final Intent galleryIntent = new Intent();
        galleryIntent.setType("image/*");
        galleryIntent.setAction(Intent.ACTION_PICK);

        // Chooser of filesystem options.
        final Intent chooserIntent = Intent.createChooser(galleryIntent, getString(R.string.document_picker_title));

        // Add the camera options.
        chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, cameraIntents.toArray(new Parcelable[cameraIntents.size()]));
        startActivityForResult(chooserIntent, REQUEST_CODE_PICTURE);
    }

    @Override
    public void clearErrors() {
        // mExpirationDateLayout.setErrorEnabled(false);
    }

    @Override
    public void showExpirationDateError() {
        // mExpirationDateLayout.setError(getString(R.string.val_field_required));
    }

    @Override
    public void showImageEmpty() {
        new AlertDialog.Builder(getContext()).setMessage(R.string.document_image_empty).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void sendResult() {
        Intent intent = new Intent();
        getActivity().setResult(Activity.RESULT_OK, intent);
        getActivity().finish();
    }

    @Override
    public void showDocumentSave() {
        Toast.makeText(getContext(), R.string.document_ms_save, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showDocumentEdit() {
        Toast.makeText(getContext(), R.string.document_ms_edit, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showDocumentDelete() {
        Toast.makeText(getContext(), R.string.document_ms_delete, Toast.LENGTH_LONG).show();
    }

    @Override
    public void showDocumentSaveError() {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.document_error_save)).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showSaveError() {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.document_error_save)).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showSaveProgress() {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(getContext());
            mProgressDialog.setMessage(getString(R.string.document_save_loading));
            mProgressDialog.setIndeterminate(true);
            mProgressDialog.setCancelable(false);
            mProgressDialog.setCanceledOnTouchOutside(false);
            mProgressDialog.show();
        }
    }

    @Override
    public void showDateDialog() {
       /* DatePickerFragment fragment = (DatePickerFragment) getActivity().getSupportFragmentManager()
                .findFragmentByTag(DATE_DIALOG);
        if (fragment == null) {
            fragment = DatePickerFragment.newInstance((Long) mExpirationDateText.getTag(),null);
            fragment.setOnDateSetListener(mOnExpirationDateSetListener);
            fragment.show(getActivity().getSupportFragmentManager(), DATE_DIALOG);
        }*/
    }

    @Override
    public void setPresenter(DocumentContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setDocument(Document document) {
        // mExpirationDateText.setText(DateUtils.formatDate(document.getExpirationDate()));
        showDocumentImage(document.getImage());
    }

    @Override
    public void setExpirationDate(Long expirationDate) {
        // mExpirationDateText.setTag(expirationDate);
        // mExpirationDateText.setText(DateUtils.formatDate(expirationDate));
    }

    @Override
    public void showCaptureError() {
        new AlertDialog.Builder(getContext()).setMessage(getString(R.string.document_take_picture)).setPositiveButton(R.string.action_accept, null).show();
    }

    @Override
    public void showDocumentImage(String documentPath) {
        mDocumentPath = documentPath;
        //MNA: NO_CACHE is very important to only use one path to temporal document!!
        Picasso.with(getContext()).load(Util.createUri(documentPath)).memoryPolicy(MemoryPolicy.NO_CACHE).error(R.drawable.ic_document_picture).placeholder(R.drawable.ic_document_picture).into(mDocumentImage);
    }

    private DatePickerDialog.OnDateSetListener mOnExpirationDateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
            mPresenter.onExpirationSet(year, month, dayOfMonth);
        }
    };
}
