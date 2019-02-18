package com.groupOrder.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class GroupOrderJNDIDAO implements GroupOrderDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO GROUP_ORDER (GORDER_ID,DRIVER_ID,MEM_ID,STATE,TOTAL_AMOUT,LAUNCH_TIME,START_TIME,END_TIME,START_LNG,START_LAT,END_LNG,END_LAT,ORDER_TYPE,RATE,NOTE) VALUES('GODR'||LPAD(to_char(GODR_ID_SEQ.NEXTVAL),3,'0'),?,?,?,?,CURRENT_TIMESTAMP,?,?,?,?,?,?,?,?,?)";
		private static final String GET_ALL_STMT = 
			"SELECT GORDER_ID ,DRIVER_ID, MEM_ID,STATE,TOTAL_AMOUT,LAUNCH_TIME,START_TIME,END_TIME,START_LNG,START_LAT,END_LNG,END_LAT,ORDER_TYPE,RATE,NOTE FROM GROUP_ORDER";
		private static final String GET_ONE_STMT = 
			"SELECT GORDER_ID ,DRIVER_ID, MEM_ID,STATE,TOTAL_AMOUT,LAUNCH_TIME,START_TIME,END_TIME,START_LNG,START_LAT,END_LNG,END_LAT,ORDER_TYPE,RATE,NOTE FROM GROUP_ORDER where GORDER_ID = ?";
		private static final String DELETE = 
			"DELETE FROM GROUP_ORDER where GORDER_ID = ?";
		private static final String UPDATE = 
			"UPDATE GROUP_ORDER set DRIVER_ID=?,MEM_ID=?,STATE=?,TOTAL_AMOUT=?,START_TIME=?,END_TIME=?,START_LNG=?,START_LAT=?,END_LNG=?,END_LAT=?,ORDER_TYPE=?,RATE=?,NOTE=? where GORDER_ID = ?";

	@Override
	public void insert(GroupOrderVO groupOrderVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, groupOrderVO.getDriverID());
			pstmt.setString(2, groupOrderVO.getMemID());
			pstmt.setInt(3,groupOrderVO.getState());
			pstmt.setInt(4,groupOrderVO.getTotalAmout());			
			pstmt.setDate(5,groupOrderVO.getStartTime());
			pstmt.setDate(6,groupOrderVO.getEndTime());
			pstmt.setDouble(7,groupOrderVO.getStartLng());
			pstmt.setDouble(8,groupOrderVO.getStartLat());
			pstmt.setDouble(9,groupOrderVO.getEndLng());
			pstmt.setDouble(10,groupOrderVO.getEndLat());
			pstmt.setInt(11,groupOrderVO.getOrderType());
			pstmt.setInt(12,groupOrderVO.getRate());
			pstmt.setString(13,groupOrderVO.getNote());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(GroupOrderVO groupOrderVO) {
		// TODO Auto-generated method stub
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, groupOrderVO.getDriverID());
			pstmt.setString(2, groupOrderVO.getMemID());
			pstmt.setInt(3,groupOrderVO.getState());
			pstmt.setInt(4,groupOrderVO.getTotalAmout());			
			pstmt.setDate(5,groupOrderVO.getStartTime());
			pstmt.setDate(6,groupOrderVO.getEndTime());
			pstmt.setDouble(7,groupOrderVO.getStartLng());
			pstmt.setDouble(8,groupOrderVO.getStartLat());
			pstmt.setDouble(9,groupOrderVO.getEndLng());
			pstmt.setDouble(10,groupOrderVO.getEndLat());
			pstmt.setInt(11,groupOrderVO.getOrderType());
			pstmt.setInt(12,groupOrderVO.getRate());
			pstmt.setString(13,groupOrderVO.getNote());
			pstmt.setString(14, groupOrderVO.getGorderID());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String groupOrderno) {
		// TODO Auto-generated method stub
		Connection con =null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, groupOrderno);
			
			pstmt.executeUpdate();
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		}
	

	@Override
	public GroupOrderVO findByPrimaryKey(String groupOrderno) {
		// TODO Auto-generated method stub
		GroupOrderVO groupOrderVO =null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
		con = ds.getConnection();
		pstmt = con.prepareStatement(GET_ONE_STMT);
		pstmt.setString(1, groupOrderno);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			
		
			groupOrderVO = new GroupOrderVO();
			groupOrderVO.setGorderID(rs.getString("GORDER_ID"));
			groupOrderVO.setDriverID(rs.getString("DRIVER_ID"));
			groupOrderVO.setMemID(rs.getString("MEM_ID"));
			groupOrderVO.setState(rs.getInt("STATE"));
			groupOrderVO.setTotalAmout(rs.getInt("TOTAL_AMOUT"));
			groupOrderVO.setLaunchTime(rs.getTimestamp("LAUNCH_TIME"));
			groupOrderVO.setStartTime(rs.getDate("START_TIME"));
			groupOrderVO.setEndTime(rs.getDate("END_TIME"));
			groupOrderVO.setStartLng(rs.getDouble("START_LNG"));
			groupOrderVO.setStartLat(rs.getDouble("START_LAT"));
			groupOrderVO.setEndLng(rs.getDouble("END_LNG"));
			groupOrderVO.setEndLat(rs.getDouble("END_LAT"));
			groupOrderVO.setOrderType(rs.getInt("ORDER_TYPE"));
			groupOrderVO.setRate(rs.getInt("RATE"));
			groupOrderVO.setNote(rs.getString("NOTE"));
		}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return groupOrderVO;
	}

	@Override
	public List<GroupOrderVO> getAll() {
		// TODO Auto-generated method stub
		List<GroupOrderVO> list =new ArrayList<GroupOrderVO>();
		GroupOrderVO groupOrderVO =null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				
				groupOrderVO = new GroupOrderVO();
				groupOrderVO.setGorderID(rs.getString("GORDER_ID"));
				groupOrderVO.setDriverID(rs.getString("DRIVER_ID"));
				groupOrderVO.setMemID(rs.getString("MEM_ID"));
				groupOrderVO.setState(rs.getInt("STATE"));
				groupOrderVO.setTotalAmout(rs.getInt("TOTAL_AMOUT"));
				groupOrderVO.setLaunchTime(rs.getTimestamp("LAUNCH_TIME"));
				groupOrderVO.setStartTime(rs.getDate("START_TIME"));
				groupOrderVO.setEndTime(rs.getDate("END_TIME"));
				groupOrderVO.setStartLng(rs.getDouble("START_LNG"));
				groupOrderVO.setStartLat(rs.getDouble("START_LAT"));
				groupOrderVO.setEndLng(rs.getDouble("END_LNG"));
				groupOrderVO.setEndLat(rs.getDouble("END_LAT"));
				groupOrderVO.setOrderType(rs.getInt("ORDER_TYPE"));
				groupOrderVO.setRate(rs.getInt("RATE"));
				groupOrderVO.setNote(rs.getString("NOTE"));
				list.add(groupOrderVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
		
	}

}