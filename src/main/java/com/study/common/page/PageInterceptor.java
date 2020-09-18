package com.study.common.page;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.log4j.Logger;

@Intercepts({ 
	@Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class,Integer.class}),
})
public class PageInterceptor implements Interceptor {
	private static Logger logger = Logger.getLogger(PageInterceptor.class);
	private static final String SELECT_ID = "listpage";

	// 插件运行的代码，它将代替原有的方法
	public Object intercept(Invocation invocation) throws Throwable {
		// System.out.println("PageInterceptor -- intercept");
		logger.debug("进入分页拦截器");
		if (invocation.getTarget() instanceof StatementHandler) {
			StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
			MetaObject metaStatementHandler = SystemMetaObject.forObject(statementHandler);
			MappedStatement mappedStatement = (MappedStatement) metaStatementHandler
					.getValue("delegate.mappedStatement");
			String selectId = mappedStatement.getId();// 取出查询语句的ID
			logger.debug("解析得到的sql:" + selectId);
			if ((selectId.substring(selectId.lastIndexOf(".") + 1).toLowerCase()).indexOf(SELECT_ID) > -1) {// 判断是否为分页查询
				logger.debug("处理分页sql开始");
				BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
				// 分页参数作为参数对象parameterObject的一个属性
				String sql = boundSql.getSql();
				Object paramObj = boundSql.getParameterObject();// 获得参数
				PageInfo pageInfo = null;
				if (paramObj instanceof PageInfo) {
					pageInfo = (PageInfo) paramObj;
				} else if (paramObj instanceof Map) { // 多参数的情况，找到第一个PageInfo的参数
					for (Map.Entry<String, Object> e : ((Map<String, Object>) paramObj).entrySet()) {
						if (e.getValue() instanceof PageInfo) {
							pageInfo = (PageInfo) e.getValue();
							break;
						}
					}
				}
				if (pageInfo == null) {
					logger.debug("无分页信息");
					return invocation.proceed();
				}
				Connection connection = (Connection) invocation.getArgs()[0];
				// 设置分页参数中的总页数
				setPageParameter(sql, connection, mappedStatement, boundSql, pageInfo);
				// 重写sql
				String pageSql = concatPageSql(sql, pageInfo);
				logger.debug("添加分页的sql:" + pageSql);
				// 重置分页sql
				metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
			}
		}
		return invocation.proceed();// 将执行权交给下一个拦截器
	}

	private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement, BoundSql boundSql,
			PageInfo pageInfo) {
		String countSql = "select count(0) from (" + sql + ") t";// 记录总记录数的SQL
		PreparedStatement countStmt = null;
		ResultSet rs = null;
		try {
			countStmt = connection.prepareStatement(countSql);
			BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql,
					boundSql.getParameterMappings(), boundSql.getParameterObject());// 计算总数的BoundSql
			ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement,
					boundSql.getParameterObject(), countBS);
			parameterHandler.setParameters(countStmt);
			// setParameters(countStmt, mappedStatement, countBS,
			// boundSql.getParameterObject());
			rs = countStmt.executeQuery();
			int totalCount = 0;
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
			pageInfo.setTotalCount(totalCount);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (countStmt != null)
					countStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 代入参数值
	 * 
	 * @param ps
	 * @param mappedStatement
	 * @param boundSql
	 * @param parameterObject
	 * @throws SQLException
	 */
	// private void setParameters(PreparedStatement ps,
	// MappedStatement mappedStatement, BoundSql boundSql,
	// Object parameterObject) throws SQLException {
	// ParameterHandler parameterHandler = new
	// DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
	// parameterHandler.setParameters(ps);
	// }

	/**
	 * 拦截类型StatementHandler
	 */
	@Override
	public Object plugin(Object target) {
		if (target instanceof StatementHandler) {
			return Plugin.wrap(target, this);
		} else {
			return target;
		}
	}

	public String concatPageSql(String sql, PageInfo pageInfo) {
		StringBuffer sb = new StringBuffer();
		sb.append(sql);
		sb.append(" limit ").append(pageInfo.getStartIndex()).append(" , ").append(pageInfo.getPageSize());
		return sb.toString();
	}

	@Override
	public void setProperties(Properties arg0) {
		// TODO Auto-generated method stub
	}
}