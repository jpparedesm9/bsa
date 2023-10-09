package com.cobis.gestionasesores.widgets;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.os.Handler;
import android.support.annotation.StringDef;
import android.util.AttributeSet;
import android.view.View;

import com.bayteq.libcore.logs.Log;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * Widget for draw Gauge for 3 sections. The original implementation was forked from https://github.com/mucahitsidimi/GaugeView
 * Created by mnaunay on 27/06/2017
 */
public class GaugeView extends View {
    @Retention(RetentionPolicy.SOURCE)
    @StringDef({FIRST_ITEM,SECOND_ITEM,THIRD_ITEM})
    public @interface Item{}

    public static final String FIRST_ITEM = "IT1";
    public static final String SECOND_ITEM = "IT2";
    public static final String THIRD_ITEM = "IT3";


    public static final int DEFAULT_ROTATE_DEGREE = -225;
    public static final int DEFAULT_LOOP = 300;

    private final Handler watcher = new Handler();
    private float internalArcStrokeWidth;
    private int colorFirstItem = Color.parseColor("#59F859");
    private int colorSecondItem = Color.parseColor("#F8AE59");
    private int colorThirdItem = Color.parseColor("#F85959");
    private int colorMainCenterCircle = Color.WHITE;
    private int colorCenterCircle = Color.parseColor("#434854");
    private int colorPointerLine = Color.parseColor("#434854");

    private float paddingMain;
    private float paddingInnerCircle;

    private float rotateDegree = DEFAULT_ROTATE_DEGREE; // for pointer line

    private float sweepAngleFirstChart = 0;
    private float sweepAngleSecondChart = 0;
    private float sweepAngleThirdChart = 0;
    private float strokePointerLineWidth = 4.5f;

    private float x;
    private float y;
    private float constantMeasure;
    private boolean isWidthBiggerThanHeight;

    private double internalArcStrokeWidthScale = 0.215;
    private double paddingInnerCircleScale = 0.27;
    private double pointerLineStrokeWidthScale = 0.006944;
    private float mainCircleScale = 2.0F;

    //--animation
    @Item
    private String itemTarget = THIRD_ITEM;
    private int maxLoop = DEFAULT_LOOP;
    private boolean isInProgress = false;
    private boolean resetMode = false;
    private boolean canReset = false;
    private int sweepAngleControl=0;
    private float degree;
    private String caption;

    public GaugeView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        x = getWidth();
        y = getHeight();

        if (x >= y) {
            constantMeasure = y;
            isWidthBiggerThanHeight = true;
        } else {
            constantMeasure = x;
            isWidthBiggerThanHeight = false;
        }

        internalArcStrokeWidth = (float) (constantMeasure * internalArcStrokeWidthScale);

        paddingInnerCircle = (float) (constantMeasure * paddingInnerCircleScale);

        strokePointerLineWidth = (float) (constantMeasure * pointerLineStrokeWidthScale);

        // middle arcs START
        Paint paintInnerArc1 = new Paint();
        paintInnerArc1.setStyle(Paint.Style.STROKE);
        paintInnerArc1.setStrokeWidth(internalArcStrokeWidth);
        paintInnerArc1.setColor(colorFirstItem);
        paintInnerArc1.setAntiAlias(true);

        Paint paintInnerArc2 = new Paint();
        paintInnerArc2.setStyle(Paint.Style.STROKE);
        paintInnerArc2.setStrokeWidth(internalArcStrokeWidth);
        paintInnerArc2.setColor(colorSecondItem);
        paintInnerArc2.setAntiAlias(true);

        Paint paintInnerArc3 = new Paint();
        paintInnerArc3.setStyle(Paint.Style.STROKE);
        paintInnerArc3.setStrokeWidth(internalArcStrokeWidth);
        paintInnerArc3.setColor(colorThirdItem);
        paintInnerArc3.setAntiAlias(true);

        RectF rectfInner;
        if (isWidthBiggerThanHeight) {
            rectfInner = new RectF((x - constantMeasure) / 2 + paddingInnerCircle, paddingInnerCircle, (x - constantMeasure) / 2 + paddingInnerCircle + constantMeasure - 2
                    * paddingInnerCircle, constantMeasure - paddingInnerCircle);
        } else {
            rectfInner = new RectF(paddingInnerCircle, (y - constantMeasure) / 2 + paddingInnerCircle, constantMeasure - paddingInnerCircle, (y - constantMeasure) / 2
                    + constantMeasure - paddingInnerCircle);
        }

        canvas.drawArc(rectfInner, 135, sweepAngleFirstChart, false, paintInnerArc1); // 135
        canvas.drawArc(rectfInner, 225, sweepAngleSecondChart, false, paintInnerArc2);
        canvas.drawArc(rectfInner, 315, sweepAngleThirdChart, false, paintInnerArc3);

        if(caption != null && caption.length()>0){
            drawCaption(canvas);
        }

        // pointer line START
        drawPointer(canvas);
    }



    private void drawCaption(Canvas canvas){
        Paint paint = new Paint();
        paint.setAntiAlias(true);
        paint.setColor(Color.BLACK);
        paint.setTextSize(16 * getResources().getDisplayMetrics().density);

        Rect rectangle = new Rect();
        paint.getTextBounds(caption, 0,caption.length(), rectangle);
        canvas.drawText(caption, x/2 -  Math.abs(rectangle.width())/2, y - (y/4) ,paint);
    }


    private void drawPointer(Canvas canvas) {
        int mainCircleStroke = (int) (mainCircleScale * constantMeasure / 60);
        Paint p = new Paint();
        p.setAntiAlias(true);
        p.setColor(colorPointerLine);
        p.setStrokeWidth(strokePointerLineWidth);
        canvas.rotate(rotateDegree, x / 2, y / 2);

        int a = 5;
        if (isWidthBiggerThanHeight) {
            float stopX = (x - constantMeasure) / 2 + paddingInnerCircle + constantMeasure - 2 * paddingInnerCircle + mainCircleStroke;
            float stopY = y / 2;
            Path path = new Path();
            path.setFillType(Path.FillType.EVEN_ODD);
            path.moveTo(x / 2 + mainCircleStroke / a, y / 2 - mainCircleStroke);
            path.lineTo(x / 2 + mainCircleStroke / a, y / 2 + mainCircleStroke);
            path.lineTo(stopX, stopY);
            path.close();
            canvas.drawPath(path, p);
        } else {
            float stopX = constantMeasure - paddingInnerCircle + mainCircleStroke;
            float stopY = y / 2;

            Path path = new Path();
            path.setFillType(Path.FillType.EVEN_ODD);
            path.moveTo(x / 2 + mainCircleStroke / a, y / 2 - mainCircleStroke);
            path.lineTo(x / 2 + mainCircleStroke / a, y / 2 + mainCircleStroke);
            path.lineTo(stopX, stopY);
            path.close();
            canvas.drawPath(path, p);
        }

        // center circles START
        Paint paintInnerCircle = new Paint();
        paintInnerCircle.setStyle(Paint.Style.FILL);
        paintInnerCircle.setColor(colorCenterCircle);
        paintInnerCircle.setAntiAlias(true);
        canvas.drawCircle(x / 2, y / 2, mainCircleStroke, paintInnerCircle);

        Paint paintCenterCircle = new Paint();
        paintCenterCircle.setStyle(Paint.Style.FILL);
        paintCenterCircle.setColor(colorMainCenterCircle);
        canvas.drawCircle(x / 2, y / 2, mainCircleStroke / 2, paintCenterCircle);
        // center circles END

    }

    public float getInternalArcStrokeWidth() {
        return internalArcStrokeWidth;
    }

    public void setInternalArcStrokeWidth(float internalArcStrokeWidth) {
        this.internalArcStrokeWidth = internalArcStrokeWidth;
        invalidate();
    }

    public int getColorFirstItem() {
        return colorFirstItem;
    }

    public void setColorFirstItem(int colorFirstItem) {
        this.colorFirstItem = colorFirstItem;
        invalidate();
    }

    public int getColorSecondItem() {
        return colorSecondItem;
    }

    public void setColorSecondItem(int colorSecondItem) {
        this.colorSecondItem = colorSecondItem;
        invalidate();
    }

    public int getColorThirdItem() {
        return colorThirdItem;
    }

    public void setColorThirdItem(int colorThirdItem) {
        this.colorThirdItem = colorThirdItem;
        invalidate();
    }

    public int getColorCenterCircle() {
        return colorCenterCircle;
    }

    public void setColorCenterCircle(int colorCenterCircle) {
        this.colorCenterCircle = colorCenterCircle;
        invalidate();
    }

    public int getColorMainCenterCircle() {
        return colorMainCenterCircle;
    }

    public void setColorMainCenterCircle(int colorMainCenterCircle) {
        this.colorMainCenterCircle = colorMainCenterCircle;
        invalidate();
    }

    public int getColorPointerLine() {
        return colorPointerLine;
    }

    public void setColorPointerLine(int colorPointerLine) {
        this.colorPointerLine = colorPointerLine;
        invalidate();
    }

    public float getPaddingMain() {
        return paddingMain;
    }

    public void setPaddingMain(float paddingMain) {
        this.paddingMain = paddingMain;
        invalidate();
    }

    public float getPaddingInnerCircle() {
        return paddingInnerCircle;
    }

    public void setPaddingInnerCircle(float paddingInnerCircle) {
        this.paddingInnerCircle = paddingInnerCircle;
        invalidate();
    }

    public float getRotateDegree() {
        return rotateDegree;
    }

    public void setRotateDegree(float rotateDegree) {
        this.rotateDegree = rotateDegree;
        invalidate();
    }

    public float getSweepAngleFirstChart() {
        return sweepAngleFirstChart;
    }

    public void setSweepAngleFirstChart(float sweepAngleFirstChart) {
        this.sweepAngleFirstChart = sweepAngleFirstChart;
        invalidate();
    }

    public float getSweepAngleSecondChart() {
        return sweepAngleSecondChart;
    }

    public void setSweepAngleSecondChart(float sweepAngleSecondChart) {
        this.sweepAngleSecondChart = sweepAngleSecondChart;
        invalidate();
    }

    public float getSweepAngleThirdChart() {
        return sweepAngleThirdChart;
    }

    public void setSweepAngleThirdChart(float sweepAngleThirdChart) {
        this.sweepAngleThirdChart = sweepAngleThirdChart;
        invalidate();
    }

    public float getStrokePointerLineWidth() {
        return strokePointerLineWidth;
    }

    public void setStrokePointerLineWidth(float strokePointerLineWidth) {
        this.strokePointerLineWidth = strokePointerLineWidth;
        invalidate();
    }

    public float getX() {
        return x;
    }

    public void setX(float x) {
        this.x = x;
        invalidate();
    }

    public float getY() {
        return y;
    }

    public void setY(float y) {
        this.y = y;
        invalidate();
    }

    public float getConstantMeasure() {
        return constantMeasure;
    }

    public void setConstantMeasure(float constantMeasure) {
        this.constantMeasure = constantMeasure;
        invalidate();
    }

    public boolean isWidthBiggerThanHeight() {
        return isWidthBiggerThanHeight;
    }

    public void setWidthBiggerThanHeight(boolean isWidthBiggerThanHeight) {
        this.isWidthBiggerThanHeight = isWidthBiggerThanHeight;
        invalidate();
    }

    public double getInternalArcStrokeWidthScale() {
        return internalArcStrokeWidthScale;
    }

    public void setInternalArcStrokeWidthScale(double internalArcStrokeWidthScale) {
        this.internalArcStrokeWidthScale = internalArcStrokeWidthScale;
        invalidate();
    }

    public double getPaddingInnerCircleScale() {
        return paddingInnerCircleScale;
    }

    public void setPaddingInnerCircleScale(double paddingInnerCircleScale) {
        this.paddingInnerCircleScale = paddingInnerCircleScale;
        invalidate();
    }

    public double getPointerLineStrokeWidthScale() {
        return pointerLineStrokeWidthScale;
    }

    public void setPointerLineStrokeWidthScale(double pointerLineStrokeWidthScale) {
        this.pointerLineStrokeWidthScale = pointerLineStrokeWidthScale;
        invalidate();
    }

    public String getCaption() {
        return caption;
    }

    public GaugeView setCaption(String caption) {
        this.caption = caption;
        return this;
    }

    public String getItemTarget() {
        return itemTarget;
    }

    public void setItemTarget(@Item String itemTarget) {
        this.itemTarget = itemTarget;
    }

    public void reset(){
        if (!isInProgress && !resetMode && canReset) {
            resetMode = true;
            runningReset();
        }
    }

    public void play(){
        if (!isInProgress) {
            isInProgress = true;
            runningPlay();
        }
    }

    private int getMaxItemTarget(@Item String item){
        switch (item){
            case FIRST_ITEM:
                return 45;
            case SECOND_ITEM:
                return 135;
            case THIRD_ITEM:
                return 225;
        }
        return 0;
    }

    private synchronized void runningReset(){
        new Thread() {
            public void run() {
                for (int i = 0; i < maxLoop; i++) {
                    try {
                        watcher.post(new Runnable() {
                            @Override
                            public void run() {
                                setSweepAngleFirstChart(0);
                                setSweepAngleSecondChart(0);
                                setSweepAngleThirdChart(0);
                                setRotateDegree(DEFAULT_ROTATE_DEGREE);
                            }
                        });
                        Thread.sleep(1);
                    } catch (InterruptedException e) {
                        Log.d("GaugeView::runningReset: ",e);
                    }
                    if (i == (maxLoop-1)) {
                        resetMode = false;
                        canReset = false;
                    }

                }
            }
        }.start();
    }

    private synchronized void runningPlay(){
        new Thread() {
            public void run() {
                degree = rotateDegree;
                sweepAngleControl = 0;
                for (int i = 0; i < maxLoop; i++) {
                    try {
                        watcher.post(new Runnable() {
                            @Override
                            public void run() {
                                degree++;
                                sweepAngleControl++;
                                if(sweepAngleControl <= getMaxItemTarget(itemTarget)) {
                                    setRotateDegree(degree);
                                }
                                if (sweepAngleControl <= 90) {
                                    sweepAngleFirstChart++;
                                    setSweepAngleFirstChart(sweepAngleFirstChart);
                                } else if (sweepAngleControl <= 180) {
                                    sweepAngleSecondChart++;
                                    setSweepAngleSecondChart(sweepAngleSecondChart);
                                } else if (sweepAngleControl <= 270) {
                                    sweepAngleThirdChart++;
                                    setSweepAngleThirdChart(sweepAngleThirdChart);
                                }

                            }
                        });
                        Thread.sleep(5);
                    } catch (InterruptedException e) {
                        Log.d("GaugeView::runningPlay: ",e);
                    }

                    if (i == (maxLoop-1)) {
                        isInProgress = false;
                        canReset = true;
                    }
                }
            }
        }.start();
    }
}
