package com.cobis.gestionasesores.presentation.sections.documents.items;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.ExifInterface;
import android.net.Uri;
import android.provider.MediaStore;

import com.bayteq.libcore.io.FileUtils;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.Document;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.DeleteDocumentUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveDocumentUseCase;
import com.cobis.gestionasesores.utils.Util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public class DocumentPresenter implements DocumentContract.Presenter {
    private static final String DOCUMENT_TMP = "tmp";

    private Document mDocument;
    private int mPersonId;
    @DocumentType
    private String mType;
    private DocumentContract.View mDocumentView;
    private SaveDocumentUseCase mSaveDocumentUseCase;
    private DeleteDocumentUseCase mDeleteDocumentUseCase;
    private DocumentsData mDocumentData;
    private int mCompressionQuality;

    public DocumentPresenter(DocumentContract.View documentView, int personId, DocumentsData documentData, String type, SaveDocumentUseCase documentUseCase, DeleteDocumentUseCase deleteDocumentUseCase) {
        mDocumentView = documentView;
        mDocumentData = documentData;
        mSaveDocumentUseCase = documentUseCase;
        mDeleteDocumentUseCase = deleteDocumentUseCase;
        mPersonId = personId;
        mType = type;
        mDocumentView.setPresenter(this);
    }

    @Override
    public void start() {
        mCompressionQuality = BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.DOCUMENT_COMPRESSION_QUALITY);
        mDocument = mDocumentData.getDocumentByType(mType);
        intDocument();
    }

    private void intDocument() {
        if (mDocument != null) {
            mDocumentView.showTitle(mType);
            mDocumentView.setDocument(mDocument);
        } else {
            mDocumentView.sendResult();
        }
    }

    @Override
    public void onExpirationSet(int year, int month, int dayOfMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, dayOfMonth);
        mDocumentView.setExpirationDate(calendar.getTimeInMillis());
    }

    @Override
    public void onClickExpirationDate() {
        mDocumentView.showDateDialog();
    }

    @Override
    public void onClickTakePicture() {
        File cameraResultPath = new File(String.format("%s/%s.jpg", BankAdvisorApp.getInstance().getCacheDirectory(), Util.getTimeStampString()));
        mDocumentView.openImageIntent(cameraResultPath.getAbsolutePath());
    }

    @Override
    public void processResultBitmap(Uri selectedImageUri, boolean isCamera) {
        Bitmap document = null;
        try {
            if (isCamera) {
                document = fromCamera(mDocumentView.getContext(), selectedImageUri);
                FileUtils.delete(selectedImageUri.getPath());
            } else {
                document = fromGallery(mDocumentView.getContext(), selectedImageUri);
            }
        } catch (IOException e) {
            Log.e("processResultBitmap::", e);
        }

        if (document == null) {
            mDocumentView.showCaptureError();
        } else {
            Log.i("Original Size:" + document.getWidth() + "x" + document.getHeight());
            String tmpDocument = BankAdvisorApp.getInstance().getCacheDirectory() + "/" + DOCUMENT_TMP;
            File tmpFile = new File(tmpDocument);
            if (tmpFile.exists()) {
                tmpFile.delete();
            }
            try {
                FileOutputStream fos = new FileOutputStream(tmpFile);
                document.compress(Bitmap.CompressFormat.JPEG, mCompressionQuality, fos);
                fos.close();
                document.recycle();
            } catch (Exception ex) {
                Log.e("Error compressing image!", ex);
            }
            mDocumentView.showDocumentImage(tmpDocument);
        }
    }

    @Override
    public boolean isEditMode() {
        return StringUtils.isNotEmpty(mDocument.getImage()) && mDocument.getStatus() != SyncStatus.SYNCED;
    }

    @Override
    public void saveDocument(String documentPath) {
        mDocumentView.clearErrors();
        if (isDocumentValid(documentPath)) {
            try {
                mDocument.setCaptureDate(Calendar.getInstance().getTimeInMillis());
                mDocument.setImage(swapDocumentFolder(documentPath, mDocument.getType()));
                mDocument.setExtension(BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_IMAGE_EXTENSION));
                mDocumentData.replaceDocument(mDocument);

                mDocumentView.showSaveProgress();
                mSaveDocumentUseCase.execute(new SaveDocumentUseCase.Params(mPersonId, mDocumentData, mType), new DisposableObserver<ResultData>() {
                    @Override
                    public void onNext(@NonNull ResultData resultData) {
                        if (resultData.getType() == ResultType.SUCCESS) {
                            if (isEditMode()) {
                                mDocumentView.showDocumentSave();
                            } else {
                                mDocumentView.showDocumentEdit();
                            }
                            mDocumentView.sendResult();
                        } else {
                            mDocumentView.showSaveError();
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("DocumentPresenter: Save document error! ", e);
                        mDocumentView.dismissProgress();
                        if (Util.isNetworkError(e)) {
                            mDocumentView.showNetworkError();
                        } else {
                            mDocumentView.showSaveError();
                        }
                    }

                    @Override
                    public void onComplete() {
                        mDocumentView.dismissProgress();
                    }
                });
            } catch (Exception ex) {
                mDocumentView.showDocumentSaveError();
            }
        }
    }

    private boolean isDocumentValid(String documentPath) {
        boolean isValid = true;
       /*COBIS: expiration date of the document is option
        if(expirationDate != null && ){
            mDocumentView.showExpirationDateError();
            isValid = false;
        }*/

        if (StringUtils.isEmpty(documentPath)) {
            mDocumentView.showImageEmpty();
            isValid = false;
        }
        return isValid;
    }

    @Override
    public void deleteDocument() {
        mDeleteDocumentUseCase.execute(new DeleteDocumentUseCase.Params(mPersonId, mDocument.getType()), new DisposableObserver<Boolean>() {
            @Override
            public void onNext(@NonNull Boolean response) {
                mDocument.setExpirationDate(null);
                mDocumentView.showDocumentDelete();
                mDocumentView.sendResult();
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mDocumentView.showDeleteDocumentError();
            }

            @Override
            public void onComplete() {

            }
        });
    }

    @Override
    public boolean isEditable() {
        return mDocument.isEditable();
    }

    private Bitmap fromCamera(Context context, Uri photoUri) throws IOException {
        Bitmap bitmap = MediaStore.Images.Media.getBitmap(context.getContentResolver(), photoUri);
        ExifInterface ei = new ExifInterface(photoUri.getPath());
        int orientation = ei.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
        switch (orientation) {
            case ExifInterface.ORIENTATION_NORMAL:
                return bitmap;
            case ExifInterface.ORIENTATION_ROTATE_90:
                return Util.rotateImage(bitmap, 90);
            case ExifInterface.ORIENTATION_ROTATE_180:
                return Util.rotateImage(bitmap, 180);
            case ExifInterface.ORIENTATION_ROTATE_270:
                return Util.rotateImage(bitmap, 270);
            default:
                return bitmap;
        }
    }

    private Bitmap fromGallery(Context context, Uri photoUri) throws IOException {
        Bitmap srcBitmap;
        InputStream is = context.getContentResolver().openInputStream(photoUri);
        srcBitmap = BitmapFactory.decodeStream(is);
        is.close();

        if (srcBitmap == null) {
            return null;
        }

        int orientation = Util.getOrientation(context, photoUri);
        if (orientation > 0) {
            srcBitmap = Util.rotateImage(srcBitmap, orientation);
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        String type = context.getContentResolver().getType(photoUri);
        if ("image/png".equals(type)) {
            srcBitmap.compress(Bitmap.CompressFormat.PNG, 100, baos);
        } else if ("image/jpg".equals(type) || "image/jpeg".equals(type)) {
            srcBitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
        }
        byte[] bMapArray = baos.toByteArray();
        baos.close();
        return BitmapFactory.decodeByteArray(bMapArray, 0, bMapArray.length);
    }

    private String swapDocumentFolder(String temporal, String type) throws Exception {
        return FileUtils.save(Util.getDocumentPath(type, BankAdvisorApp.getInstance().getConfig().getString(Parameters.DEFAULT_IMAGE_EXTENSION)), FileUtils.read(temporal));
    }
}
