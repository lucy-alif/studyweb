package com.study.util;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.BoundListOperations;
import org.springframework.data.redis.core.BoundValueOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

@Component
public class RedisUtil {
    @Autowired
    private RedisTemplate<String, Object> template;
    /**
     * 向redis添加一个键值
     * @param key
     * @return
     */
    public Object getDataFromCache(String key){
    	ValueOperations<String,Object> operation=template.opsForValue();
        //BoundValueOperations<String, Object> bound = template.boundValueOps(key);
        return operation.get(key);
    }
    /**
     * 从redis中取出一个键值
     * @param key
     * @param data
     */
    public void setDataToCache(String key,Object data){
//      BoundValueOperations<String,Object> ops = template.boundValueOps(key);
//      ops.set(data);
    	ValueOperations<String,Object> operation=template.opsForValue();
    	operation.set(key, data);
    }
    /**
     * 清除缓存
     * @param cacheKey
     */
    public void clearCache(String cacheKey){
        template.delete(cacheKey);
    }
    /**
     * 从缓存中获取一个list
     * @param cacheKey
     * @return
     */
    public List<Object> getCacheList(String cacheKey){
        BoundListOperations<String, Object> bound = template.boundListOps(cacheKey);
        long size = bound.size();
        return bound.range(0, size);
    }
    /**
     * 覆盖一个list
     * @param cacheKey
     * @param dataList
     */
    public void updatCacheList(String cacheKey,List<Object> dataList){
        template.delete(cacheKey);
        BoundListOperations<String, Object> bound = template.boundListOps(cacheKey);
        bound.rightPushAll(dataList.toArray());
    }
    /**
     * 获取一个hash
     * @param cacheKey
     * @return
     */
    public Map<String, Object> getCacheMap(String cacheKey){
        BoundHashOperations<String, String, Object> bound = template.boundHashOps(cacheKey);
        return bound.entries();
    }
    /**
     * 从hash里获取一个值
     * @param cacheKey
     * @param key
     * @return
     */
    public Object getDataFromCacheMap(String cacheKey,Object key){
        BoundHashOperations<String, Object, Object> bound = template.boundHashOps(cacheKey);
        return bound.get(key);
    }
    /**
     * 向hash放进一个键值
     * @param cacheKey
     * @param key
     * @param value
     */
    public void setDataFromCacheMap(String cacheKey,Object key,Object value){
        BoundHashOperations<String, Object, Object> bound = template.boundHashOps(cacheKey);
        bound.put(key, value);
    }
}
