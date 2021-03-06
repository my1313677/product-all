package com.thinkgem.jeesite.modules.live.speaker.entity;

import com.thinkgem.jeesite.modules.live.base.persistence.ExDataEntity;

/**
 * @version 1.0
 * @author tangqian
 */
public class SpeakerSpeech extends ExDataEntity<SpeakerSpeech> {

	private static final long serialVersionUID = 1L;

	private Integer speakerId;

	private String name;

	private Integer fileId;

	private Integer sort;

	private String auditBy;

	private java.util.Date auditTime;

	private String auditReason;

	private String roomId;

	public void setSpeakerId(Integer value) {
		this.speakerId = value;
	}

	public Integer getSpeakerId() {
		return this.speakerId;
	}

	public void setName(String value) {
		this.name = value;
	}

	public String getName() {
		return this.name;
	}

	public void setFileId(Integer value) {
		this.fileId = value;
	}

	public Integer getFileId() {
		return this.fileId;
	}

	public void setSort(Integer value) {
		this.sort = value;
	}

	public Integer getSort() {
		return this.sort;
	}

	public void setAuditBy(String value) {
		this.auditBy = value;
	}

	public String getAuditBy() {
		return this.auditBy;
	}

	public void setAuditTime(java.util.Date value) {
		this.auditTime = value;
	}

	public java.util.Date getAuditTime() {
		return this.auditTime;
	}

	public void setAuditReason(String value) {
		this.auditReason = value;
	}

	public String getAuditReason() {
		return this.auditReason;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

}
