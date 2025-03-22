<%@page import="config.TMHelper"%>
<%@page import="config.DbHelper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<jsp:include page="pheader.jsp"></jsp:include>

<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 90vh">
		<div class="card-body">
			<jsp:include page="msg.jsp"></jsp:include>
			<a href="#" class="btn btn-success btn-sm float-right" data-target="#addpro" data-toggle="modal">
				<i class="fa fa-plus"></i> Add New Project
			</a>
			<h4 class="p-2" style="border-bottom: 2px solid green;">Projects</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>Id</th>
						<th>Project Title</th>
						<th>Abbreviation</th>
						<th>Start Date</th>
						<th>Due Date</th>
						<th>Status</th>
						<th>Manager</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						if (session.getAttribute("id") != null) {
							String userId = session.getAttribute("id").toString();
							String sql = "SELECT p.id, title, abbr, startdt, enddt, status, description, u.full_name AS mgr " +
									   "FROM task_group p INNER JOIN employees u ON p.mgrid = u.id WHERE p.mgrid = ?";
							List<Map<String, String>> data = DbHelper.executeDQL(sql, userId);
							for (Map<String, String> row : data) {
					%>
					<tr>
						<td><%= row.get("id") %></td>
						<td><%= row.get("title") %></td>
						<td><%= row.get("abbr") %></td>
						<td><%= row.get("startdt") %></td>
						<td><%= row.get("enddt") %></td>
						<td><%= TMHelper.getMasterName(row.get("status")) %></td>
						<td><%= row.get("mgr") %></td>
						<td>
							<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#r<%= row.get("id") %>">Edit</button>
							<div class="modal fade" id="r<%= row.get("id") %>">
								<div class="modal-dialog">
									<form class="modal-content" method="post" action="updateproject">
										<input type="hidden" value="<%= row.get("id") %>" name="pid">										
										<div class="modal-header">
											<h5>Edit Project</h5>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>Project Title</label>
												<input type="text" name="title" value="<%= row.get("title") %>" class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Abbreviation</label>
												<input type="text" name="abbr" value="<%= row.get("abbr") %>" maxlength="5" class="form-control form-control-sm">
											</div>
											<div class="form-group">
												<label>Description</label>
												<textarea name="descr" rows="4" class="form-control form-control-sm"><%= row.get("description") %></textarea>
											</div>
										</div>
										<div class="modal-footer">
											<input type="submit" value="Save Project" class="btn btn-primary btn-sm">
										</div>
									</form>
								</div>
							</div>
						</td>
					</tr>
					<%
							}
						} else {
					%>
					<tr>
						<td colspan="8" class="text-center text-danger">User session ID not found.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
