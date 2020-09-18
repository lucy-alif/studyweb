package com.study.common.page;
/**
 * 封装分页信息
 * @author Administrator
 * @param <T>
 */
public class PageInfo{
	private int currentPage;//当前第几页
	private int lastIndex;//最后1页第1条记录的位置
	private boolean lastPage;//是否为最后一页
	private int pageCount; //总共几页
	private int pageSize = 8; //每页的记录数,默认5条
	private int startIndex = 0;//当前页第1条记录的位置,从0开始
	private int totalCount; //总记录数
	public PageInfo()
    {
        super();
    }
	public PageInfo(Integer totalCount) {
		this.totalCount=totalCount;
		this.startIndex=0;
	}
    public PageInfo(Integer totalCount, Integer startIndex) {
		this.totalCount=totalCount;
		this.startIndex=startIndex;
	}

	public PageInfo(Integer totalCount, Integer pageSize,Integer startIndex) {
		this.totalCount=totalCount;
		this.startIndex=startIndex;
		this.pageSize=pageSize;
	}
	public Integer getCurrentPage() { //获得当前第几页:如 
		this.currentPage = startIndex/pageSize + 1;//pageSize=5;startIndex=6;currentPage=2;
		return this.currentPage;
	}
	public Integer getLastIndex() { //获得最后一页的第一条记录的位置
		if(totalCount>0){
			if(totalCount%pageSize == 0) {
				this.lastIndex = totalCount - pageSize;//totalCount=20;pageSize=5;lastIndex=15;
			} else {
				this.lastIndex = totalCount - (totalCount%pageSize);//totalCount=22;pageSize=5;lastIndex=20;
			}
		}
		return this.lastIndex;
	}
	public boolean getLastPage() {//判断是否为最后一页
		lastPage=(totalCount - startIndex) <= pageSize;
		return lastPage;
	}
	public Integer getNextIndex() { //获得下一页的第一条记录的位置
		Integer nextIndex = startIndex + pageSize;//等于当前页第1条记录的位置+每页的条数    startIndex=5,pageSize=5; nextIndex=10
		if (nextIndex >= totalCount)//判断是否超过最大条数,超过代表已经是最后一页
			return startIndex;
		else
			return nextIndex;
	}
	public Integer getPageCount() {//获得总页数
		this.pageCount = totalCount/pageSize;
		if(totalCount%pageSize > 0) { //不能整除
			this.pageCount++;
		}
		if(this.pageCount == 0) {//无数据
			this.pageCount = 1;
		}
		return pageCount;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public Integer getPreviousIndex() {//获得前一页的第1条记录的起始位置
		Integer previousIndex = startIndex - pageSize;
		if (previousIndex < 0)//已经是第1页
			return 0;
		else
			return previousIndex;
	}
	public Integer getStartIndex() {
		//判断startIndex是否超出最大值,超出最大值则设置为最后一页
		return this.getTotalCount()>=startIndex?startIndex:lastIndex;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setPageSize(Integer pageSize) {
		if(pageSize<=0){
			this.pageSize=10;
		}else
			this.pageSize = pageSize;
	}
	public void setStartIndex(Integer startIndex) {
		if (startIndex==null||startIndex < 0)
			this.startIndex = 0;
		else
			this.startIndex = startIndex;
	}
	public void setTotalCount(Integer totalCount) {
		if (totalCount > 0) {
			this.totalCount = totalCount;
		} else {
			this.totalCount = 0;
		}
	}
}
