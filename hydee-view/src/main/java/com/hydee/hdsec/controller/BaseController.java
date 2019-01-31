package com.hydee.hdsec.controller;

import com.hydee.hdsec.entity.*;
import com.hydee.hdsec.util.EnumUtil;
import com.hydee.hdsec.util.ServerChargeUtil;
import com.hydee.hydee.service.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by King.Liu
 * 2016/9/2.
 */
public class BaseController {
    @Autowired
    public CompanyTrainExercisesService companyTrainExercisesService;
    @Autowired
    public CompanyTrainTaskService companyTrainTaskService;
    @Autowired
    public CompanyTrainCLassService companyTrainCLassService;
    @Autowired
    public CompanyTrainBaseService companyTrainBaseService;
    @Autowired
    public CompanyOrgService companyOrgService;

    /**
     * 获取习题选项
     * @param exercisesList
     * @param exercisesId
     * @return
     * @throws Exception
     */
    protected List<CompanyTrainExercises> getOptions(List<CompanyTrainExercises> exercisesList, Long exercisesId) throws Exception{
        List<CompanyTrainExercises> exercisess = new ArrayList<CompanyTrainExercises>();
        for (CompanyTrainExercises trainExercises : exercisesList) {
            List<CompanyTrainExercisesOptions> options = companyTrainExercisesService.selectOptionsByExercisesId(trainExercises.getExercisesId());
            for (CompanyTrainExercisesOptions option : options ) {
                if("A".equals(option.getOptionNo())){
                    trainExercises.setOptionA(option.getContent());
                }else if("B".equals(option.getOptionNo())){
                    trainExercises.setOptionB(option.getContent());
                }else if("C".equals(option.getOptionNo())){
                    trainExercises.setOptionC(option.getContent());
                }else if("D".equals(option.getOptionNo())){
                    trainExercises.setOptionD(option.getContent());
                }
            }
            exercisess.add(trainExercises);
        }
        return exercisess;
    }

    /**
     * 根据任务ID，获取它相关的连锁，课件
     * @param taskId
     * @return
     * @throws Exception
     */
    protected Map<String,Object> getTaskDetail(Long taskId) throws Exception{
        Map<String,Object> map = new HashMap<String,Object>();
        CompanyTrainTask companyTrainTask = companyTrainTaskService.selectTaskById(taskId);
        CompanyTrainClassTask companyTrainClassTask = companyTrainTaskService.selectClassTaskByTaskId(taskId);
        List<CompanyTrainTaskThumbnail> taskThumbnailList = companyTrainTaskService.selectThumbnailByTaskId(taskId);
        List<CompanyTrainTaskCustomer> taskCustomerList = companyTrainTaskService.selectCustomerByTaskId(taskId);
        CompanyTrainClass companyTrainClass = companyTrainCLassService.selectByClassId(companyTrainClassTask.getClassId());
        CompanyTrainBase companyTrainBase = companyTrainBaseService.selectBaseById(companyTrainClass.getBaseId());
        if(companyTrainBase.getType().equals(EnumUtil.ExercisesBaseType.GROOVE.value)){
            List<CompanyTrainExercises> trainExercisesList = companyTrainExercisesService.selectByBaseId(companyTrainClass.getBaseId());
            map.put("trainExercisesList", trainExercisesList);
        }
        if(1 == companyTrainTask.getCommissionType()){
            companyTrainTask.setServeCharge(companyTrainTask.getServeCharge() == null ? Double.parseDouble(ServerChargeUtil.SERVERCHARGE) : companyTrainTask.getServeCharge());
        }else if(2 == companyTrainTask.getCommissionType()){
            companyTrainTask.setServeCharge(companyTrainTask.getServeCharge() == null ? Double.parseDouble(ServerChargeUtil.SERVERCHARGEPERCENT) : companyTrainTask.getServeCharge());
        }
        map.put("companyTrainBase", companyTrainBase);
        map.put("companyTrainClass", companyTrainClass);
        map.put("companyTrainTask", companyTrainTask);
        map.put("taskThumbnailList", taskThumbnailList);
        map.put("taskCustomerList", taskCustomerList);
        return map;
    }
}
