package com.lp.service.impl;

import com.lp.utils.SystemInitUtil;
import org.springframework.stereotype.Service;

/**
 * Created by CPR161 on 2018-11-09.
 */
@Service("scanCadFileService")
public class TaskScanCadFileServiceImpl {
    public void init(){
        SystemInitUtil sys = new SystemInitUtil();
        sys.init();
    }
}
