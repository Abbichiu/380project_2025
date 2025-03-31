package hkmu.wadd.model;

import hkmu.wadd.controller.PageVisit;

import java.util.Date;
import java.util.List;

public class SessionActivityModel {
    private String sessionId;
    private boolean isNew;
    private Date creationTime;
    private List<PageVisit> activityList;

    // Getters and Setters
    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public boolean isNew() {
        return isNew;
    }

    public void setNew(boolean isNew) {
        this.isNew = isNew;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    public List<PageVisit> getActivityList() {
        return activityList;
    }

    public void setActivityList(List<PageVisit> activityList) {
        this.activityList = activityList;
    }
}