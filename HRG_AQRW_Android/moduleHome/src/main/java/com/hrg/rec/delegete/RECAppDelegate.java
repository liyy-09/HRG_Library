package com.hrg.rec.delegete;

import android.support.annotation.Keep;

import com.hrg.common.base.ViewManager;
import com.hrg.common.delegate.IApplicationDelegate;
import com.hrg.rec.fragment.RechargeFragment;

/**
 * <p>类说明</p>
 *
 * @name RECAppDelegate
 */
@Keep
public class RECAppDelegate implements IApplicationDelegate {
    @Override
    public void onCreate() {
        //主动添加
        ViewManager.getInstance().addFragment(0, RechargeFragment.newInstance());
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
