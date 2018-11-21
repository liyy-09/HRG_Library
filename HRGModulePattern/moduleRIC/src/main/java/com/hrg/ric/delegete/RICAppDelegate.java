package com.hrg.ric.delegete;

import android.support.annotation.Keep;

import com.hrg.common.base.IApplicationDelegate;
import com.hrg.common.base.ViewManager;
import com.hrg.ric.fragment.RICDeviceFragment;
import com.hrg.ric.fragment.RICListFragment;

/**
 * <p>类说明</p>
 *
 * @name RICAppDelegate
 */
@Keep
public class RICAppDelegate implements IApplicationDelegate {
    @Override
    public void onCreate() {
        //主动添加
        ViewManager.getInstance().addFragment(0, RICListFragment.newInstance());
        ViewManager.getInstance().addFragment(0, RICDeviceFragment.newInstance());
    }

    @Override
    public void onTerminate() {

    }

    @Override
    public void onLowMemory() {

    }

    @Override
    public void onTrimMemory(int level) {

    }
}
