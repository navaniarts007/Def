<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid p-2">
    <div class="card shadow" style="min-height: 90vh">
        <div class="card-body">
        	<jsp:include page="msg.jsp"></jsp:include>
        	<a href="#" class="btn btn-success btn-sm float-right" data-target="#addpro" data-toggle="modal"><i class="fa fa-plus"></i> Add New Project</a>
			<h4 class="p-2" style="border-bottom:2px solid green;" >Task Group</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Task Group Title</th>
						<th>Abbreviation</th>
						<th>Status</th>
						<th>Manager</th>
						<th>Active</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
					String sql="select * from task_group WHERE 1=?";
					List<Map<String,String>> data=DbHelper.executeDQL(sql, "1");
					for(Map<String,String> row : data) { %>
						<tr>
							<td><%= row.get("id") %></td>
							<td><%= row.get("title") %></td>
							<td><%= row.get("abbr") %></td>
							
							<td><%= TMHelper.getMasterName(row.get("status")) %></td>
							<td><%= TMHelper.getUserName(row.get("mgrid")) %></td>
							<td>
								<% if(Integer.parseInt(row.get("active"))==0) { %>
								<span class="badge badge-danger">Inactive</span>
								<%} else { %>
								<span class="badge badge-success">Active</span>
								<% } %>
							</td>
							<td style="width:110px;">
							<a href="tasks.jsp?pid=<%= row.get("id") %>" class="btn btn-primary btn-sm">Tasks</a>
							<button class="btn btn-primary btn-sm" data-toggle="modal"
								data-target="#r<%=row.get("id")%>">Edit</button>
							<div class="modal fade" id="r<%=row.get("id")%>">
								<div class="modal-dialog">
									<form class="modal-content" method="post"
										action="updateproject">
										<input type="hidden" value="<%= row.get("id") %>" name="pid">										
										<div class="modal-header">
											<h5>Edit Task Group</h5>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>Task Title</label> <input type="text" name="title"
													value="<%=row.get("title")%>"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Abbreviation</label> <input type="text" name="abbr"
													value="<%=row.get("abbr")%>" maxlength="5"
													class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Description</label>
												<textarea name="descr" rows="4"
													class="form-control form-control-sm"><%=row.get("description")%></textarea>
											</div>
										
											<div class="form-group">
												<label>Status</label> <select name="status"
													class="form-control form-control-sm">
													<%
													for(Map<String,String> sts:TMHelper.getMastersList("Project Status")) {
													%>
													<option <%= sts.get("id").equals(row.get("status")) ?"selected":"" %> value="<%= sts.get("id") %>"><%= sts.get("mastername") %></option>
													<% } %>
												</select>
											</div>
											<div class="form-group">
												<label>Manager</label> <select name="mgrid"
													class="form-control form-control-sm">
													<%
													for(Map<String,String> sts:DbHelper.executeDQL("SELECT * FROM employees WHERE role=?", "M")) {
													%>
													<option <%= sts.get("employee_id").equals(row.get("mgrid")) ?"selected":"" %> value="<%= sts.get("employee_id") %>"><%= sts.get("full_name") %></option>	
													<% } %>
												</select>
											</div>
										</div>
										<div class="modal-footer">
											<input type="submit" value="Save Project"	
												class="btn btn-primary btn-sm">
										</div>
									</form>
								</div>
							</div>
							</td>
						</tr>						
					<% } %>
				</tbody>
			</table>
        </div>
    </div>
</div>
<div class="modal fade" id="addpro">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="addproject">
			<div class="modal-header">
				<h5>Add Task Group</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">Task Title</label>
					<div class="col-sm-8">
					<input type="text" name="title" class="form-control form-control-sm">
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Abbreviation</label>
					<div class="col-sm-8">
					<input type="text" name="abbr" maxlength="5" class="form-control form-control-sm">
				</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Description</label>
					<div class="col-sm-8">
					<textarea name="descr" rows="4" class="form-control form-control-sm"></textarea>
				</div>
				</div>
				
								
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save Project" class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>

<jsp:include page="footer.jsp"></jsp:include>