package com.study.charts.vo;


public class Series {
	private String type;
	private Data[] data;
	
	
	
	




	public String getType() {
		return type;
	}




	public void setType(String type) {
		this.type = type;
	}









	public Data[] getData() {
		return data;
	}




	public void setData(Data[] data) {
		this.data = data;
	}




	public class Data{
		private int value;
		private String name;
		private Children[] children;
		public int getValue() {
			return value;
		}
		public void setValue(int value) {
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Children[] getChildren() {
			return children;
		}
		public void setChildren(Children[] children) {
			this.children = children;
		}
		
		
		
	}
}
