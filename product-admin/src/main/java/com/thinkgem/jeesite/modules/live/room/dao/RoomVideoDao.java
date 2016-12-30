package com.thinkgem.jeesite.modules.live.room.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.live.room.entity.RoomVideo;

/**
 * @version 1.0
 * @author tangqian
 */
@MyBatisDao
public interface RoomVideoDao extends CrudDao<RoomVideo> {
	
}