package com.study.common.util;

import java.security.MessageDigest;



//MD5不可逆,保存用户密码到数据库时,先加密,再保存
public class MD5 {
	//盐(Salt)值在密码学中，通过在密码任意固定位置插入特定的字符串,让相同的密码拥有不同的加密结果
	public static void main(String[] args) throws Exception {
		//String password = "adminA123456";
		//String password = "user123456";
		System.out.println(enctypeMD5("haha123456"));
		System.out.println(enctypeMD5("bbb123456"));
		System.out.println(enctypeMD5("ccc123456"));
		System.out.println(enctypeMD5("ddd123456"));
		System.out.println(enctypeMD5("eee123456"));
		//System.out.println(enctypeMD5("zhangziyu123456"));
	}
	//MD5加密
	public static String enctypeMD5(String source)  {
		//System.out.println(source);
		MessageDigest md5=null;
		try {
			md5 = MessageDigest.getInstance("MD5");
			if(source!=null){
				md5.update(source.getBytes("utf-8"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return byteArrayToHex(md5.digest());
	}
	
	public static String byteArrayToHex(byte[] byteArray) {
		// 首先初始化一个字符数组，用来存放每个16进制字符
		char[] hexDigits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		// new一个字符数组，这个就是用来组成结果字符串的（解释一下：一个byte是八位二进制，也就是2位十六进制字符（2的8次方等于16的2次方））
		char[] resultCharArray = new char[byteArray.length * 2];
		// 遍历字节数组，通过位运算（位运算效率高），转换成字符放到字符数组中去
		int index = 0;
		for (byte b : byteArray) {
			resultCharArray[index++] = hexDigits[b >>> 4 & 0xf];
			resultCharArray[index++] = hexDigits[b & 0xf];
		}
		// 字符数组组合成字符串返回
		return new String(resultCharArray);
	}

}
