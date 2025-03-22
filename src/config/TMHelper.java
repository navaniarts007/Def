package config;
//Add to existing imports
import java.util.Collections;
import java.util.List;
import java.util.Map;
//Add to existing imports
import java.util.Collections;
public class TMHelper {

	public static String getUserName(String id) {
	    try {
	        Map<String, String> data = DbHelper.executeDQLReturnSingle(
	            "SELECT full_name FROM employees WHERE employee_id=?", 
	            id
	        );
	        return (data != null) ? data.get("full_name") : "Unassigned";
	    } catch (Exception ex) {
	        System.out.println("Error in getUserName: " + ex.getMessage());
	        return "Unassigned";
	    }
	}
	// Add to TMHelper.java under existing methods
	public static List<Map<String, String>> getTaskGroups(String pid) {
	    try {
	        return DbHelper.executeDQL(
	            "SELECT id, title, description FROM task_group WHERE pid=? AND active=1", 
	            pid
	        );
	    } catch (Exception ex) {
	        System.out.println("Error in getTaskGroups: " + ex.getMessage());
	        return java.util.Collections.emptyList();
	    }
	}
	public static String genTaskId(String id) {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT ifnull(max(id)+1,1) as id FROM tasks WHERE pid=?", id);
			return data.get("id");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getProjectName(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT title FROM task_group WHERE id=?", id);
			return data.get("title");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getCompletedTask(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT count(id) as total FROM tasks WHERE status='14' and pid=?", id);
			return data.get("total");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getEmployeeProjectId(String id) {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT pid FROM employees WHERE employee_id=?", id);
			return data.get("pid");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getEmployeeAttendance(String id,String month,String year) {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT round(ifnull(sum(logtime),0)/9,1) as days FROM attendance WHERE tid=? and approved=1 "
					+ "and month(adate)=? and year(adate)=? and progress not in('On Leave','Absent')", id,month,year);
			return data.get("days");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getProjectTeamCount(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT count(id) as total FROM employees WHERE pid=?", id);
			return data.get("total");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getManagerfromProjectId(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT mgrid FROM task_group WHERE id=? order by id desc", id);
			return data.get("mgrid");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getProjectfromEmployeeId(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT pid FROM team WHERE uid=? order by id desc", id);
			return data.get("pid");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getEmployeeTaskCount(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT count(id) as total FROM tasks WHERE uid=? and status!='Done'", id);
			return data.get("total");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getMasterName(String id)  {
		try {
			Map<String,String> data=DbHelper.executeDQLReturnSingle("SELECT mastername FROM masters WHERE id=?", id);
			return data.get("mastername");
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static String getPriorityColor(String id)  {
		try {
			switch(id) {
				case "2":
					return "bg-success text-white";
				case "3":
					return  "bg-warning text-white";
				case "4":
					return  "bg-danger text-white";
				default:
					return "";
			}
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static List<Map<String,String>> getMastersList(String catname)  {
		try {
			List<Map<String,String>> data=DbHelper.executeDQL("SELECT id,mastername FROM masters WHERE catname=? and active=1", catname);
			return data;
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
	
	public static List<Map<String,String>> getEmployeesList(String pid)  {
		try {
			List<Map<String,String>> data=DbHelper.executeDQL("SELECT employee_id,full_name FROM employees WHERE pid=?", pid);
			return data;
		}catch(Exception ex) {
			System.out.println("Error "+ex.getMessage());
		}
		return null;
	}
}
