package com.hrg.common.base;

import android.Manifest;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.support.annotation.IdRes;
import android.support.annotation.Keep;
import android.support.annotation.NonNull;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;

import com.hrg.common.BuildConfig;
import com.hrg.common.R;
import com.hrg.common.utils.PermissionUtils;
import com.hrg.common.utils.Utils;
import com.orhanobut.logger.Logger;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * <p>Activity基类 </p>
 *
 * @author liyy 2018/11/21
 * @name BaseActivity
 */
@Keep
public abstract class BaseActivity extends AppCompatActivity {

    /**
     * 封装的findViewByID方法
     */
    @SuppressWarnings("unchecked")
    protected <T extends View> T $(@IdRes int id) {
        return (T) super.findViewById(id);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ViewManager.getInstance().addActivity(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ViewManager.getInstance().finishActivity(this);
    }

    @Override
    public boolean onSupportNavigateUp() {
        onBackPressed();
        return true;
    }

    /**
     * Setup the toolbar.
     *
     * @param toolbar   toolbar
     * @param hideTitle 是否隐藏Title
     */
    protected void setupToolBar(Toolbar toolbar, boolean hideTitle) {
        setSupportActionBar(toolbar);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setHomeAsUpIndicator(R.mipmap.ic_arrow_back);
            actionBar.setDisplayHomeAsUpEnabled(true);
            actionBar.setDisplayShowHomeEnabled(true);
            if (hideTitle) {
                //隐藏Title
                actionBar.setDisplayShowTitleEnabled(false);
            }
        }
    }

    /**
     * 添加fragment
     *
     * @param fragment
     * @param frameId
     */
    protected void addFragment(BaseFragment fragment, @IdRes int frameId) {
        Utils.checkNotNull(fragment);
        getSupportFragmentManager()
                .beginTransaction()
                .add(frameId, fragment, fragment.getClass().getSimpleName())
                .addToBackStack(fragment.getClass().getSimpleName())
                .commitAllowingStateLoss();
    }

    /**
     * 替换fragment
     * @param fragment
     * @param frameId
     */
    protected void replaceFragment(BaseFragment fragment, @IdRes int frameId) {
        Utils.checkNotNull(fragment);
        getSupportFragmentManager()
                .beginTransaction()
                .replace(frameId, fragment, fragment.getClass().getSimpleName())
                .addToBackStack(fragment.getClass().getSimpleName())
                .commitAllowingStateLoss();
    }

    /**
     * 隐藏fragment
     * @param fragment
     */
    protected void hideFragment(BaseFragment fragment) {
        Utils.checkNotNull(fragment);
        getSupportFragmentManager().beginTransaction()
                .hide(fragment)
                .commitAllowingStateLoss();
    }

    /**
     * 显示fragment
     * @param fragment
     */
    protected void showFragment(BaseFragment fragment) {
        Utils.checkNotNull(fragment);
        getSupportFragmentManager().beginTransaction()
                .show(fragment)
                .commitAllowingStateLoss();
    }

    /**
     * 移除fragment
     * @param fragment
     */
    protected void removeFragment(BaseFragment fragment) {
        Utils.checkNotNull(fragment);
        getSupportFragmentManager().beginTransaction()
                .remove(fragment)
                .commitAllowingStateLoss();
    }

    /**
     * 弹出栈顶部的Fragment
     */
    protected void popFragment() {
        if (getSupportFragmentManager().getBackStackEntryCount() > 1) {
            getSupportFragmentManager().popBackStack();
        } else {
            finish();
        }
    }

    /*
    * ================ Android6.0的权限管理 ================
    * https://www.jianshu.com/p/95790125b7f4
    * */

    private static final int REQUESRCARMEA = 10000;

    public void checkCameraPermission() {
        if (PermissionUtils.checkAndApplyPermissionActivity(this,
                new String[]{Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE},
                REQUESRCARMEA)) {
            Log.i("", "");
            // 获取到权限的操作, 没有权限会申请权限, 然后在 onRequestPermissionsResult 处理申请的结果
        } else {
            Log.i("", "");
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        if (PermissionUtils.checkPermission(grantResults)) {
            // 申请权限成功
            switch (requestCode) {
                case 0x001:
                    //do something
                    break;
                case 0x002:
                    //do something
                    break;
            }
        } else {
//            // 提示没有什么权限（弹toast 貌似有bug）
//            PermissionUtils.showPermissionsToast(this, permissions);
            // or 去权限管理界面
            gotoPermissionManager(this);
        }
    }

    /**
     * 去应用权限管理界面
     */
    public static void gotoPermissionManager(Context context) {
        Intent intent;
        ComponentName comp;

        // 防止刷机出现的问题
        try {
            switch (Build.MANUFACTURER) {
                case "Huawei":
                    intent = new Intent();
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    comp = new ComponentName("com.huawei.systemmanager", "com.huawei.permissionmanager.ui.MainActivity");
                    intent.setComponent(comp);
                    context.startActivity(intent);
                    break;
                case "Meizu":
                    intent = new Intent("com.meizu.safe.security.SHOW_APPSEC");
                    intent.addCategory(Intent.CATEGORY_DEFAULT);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    context.startActivity(intent);
                    break;
                case "Xiaomi":
                    String rom = getSystemProperty("ro.miui.ui.version.name");

                    if ("v5".equals(rom)) {
                        Uri packageURI = Uri.parse("package:" + context.getApplicationInfo().packageName);
                        intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, packageURI);
                    } else {//if ("v6".equals(rom) || "v7".equals(rom)) {
                        intent = new Intent("miui.intent.action.APP_PERM_EDITOR");
                        intent.setClassName("com.miui.securitycenter", "com.miui.permcenter.permissions.AppPermissionsEditorActivity");
                        intent.putExtra("extra_pkgname", context.getPackageName());
                    }

                    context.startActivity(intent);
                    break;
                case "Sony":
                    intent = new Intent();
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    comp = new ComponentName("com.sonymobile.cta", "com.sonymobile.cta.SomcCTAMainActivity");
                    intent.setComponent(comp);
                    context.startActivity(intent);
                    break;
                case "OPPO":
                    intent = new Intent();
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    comp = new ComponentName("com.color.safecenter", "com.color.safecenter.permission.PermissionManagerActivity");
                    intent.setComponent(comp);
                    context.startActivity(intent);
                    break;
                case "LG":
                    intent = new Intent("android.intent.action.MAIN");
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    comp = new ComponentName("com.android.settings", "com.android.settings.Settings$AccessLockSummaryActivity");
                    intent.setComponent(comp);
                    context.startActivity(intent);
                    break;
                case "Letv":
                    intent = new Intent();
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("packageName", BuildConfig.APPLICATION_ID);
                    comp = new ComponentName("com.letv.android.letvsafe", "com.letv.android.letvsafe.PermissionAndApps");
                    intent.setComponent(comp);
                    context.startActivity(intent);
                    break;
                default:
                    getAppDetailSettingIntent(context);
                    break;
            }
        } catch (Exception e) {
            getAppDetailSettingIntent(context);
        }
    }

    /**
     * 获取系统属性值
     */
    public static String getSystemProperty(String propName) {
        String line;
        BufferedReader input = null;

        try {
            Process p = Runtime.getRuntime().exec("getprop " + propName);
            input = new BufferedReader(new InputStreamReader(p.getInputStream()), 1024);
            line = input.readLine();
            input.close();
        } catch (IOException ex) {
            Log.e("BaseActivity", "Unable to read sysprop " + propName, ex);
            return null;
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException e) {
                    Log.e("BaseActivity", "Exception while closing InputStream", e);
                }
            }
        }

        return line;
    }

    // 以下代码可以跳转到应用详情，可以通过应用详情跳转到权限界面(6.0系统测试可用)
    public static void getAppDetailSettingIntent(Context context) {
        Intent localIntent = new Intent();
        localIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

        if (Build.VERSION.SDK_INT >= 9) {
            localIntent.setAction("android.settings.APPLICATION_DETAILS_SETTINGS");
            localIntent.setData(Uri.fromParts("package", context.getPackageName(), null));
        } else if (Build.VERSION.SDK_INT <= 8) {
            localIntent.setAction(Intent.ACTION_VIEW);
            localIntent.setClassName("com.android.settings", "com.android.settings.InstalledAppDetails");
            localIntent.putExtra("com.android.settings.ApplicationPkgName", context.getPackageName());
        }

        launchApp(context, localIntent);
    }

    /**
     * 安全的启动APP
     */
    public static boolean launchApp(Context ctx, Intent intent) {
        if (ctx == null)
            throw new NullPointerException("ctx is null");
        try {
            ctx.startActivity(intent);
            return true;
        } catch (ActivityNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
