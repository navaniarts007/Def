<form action="addtask" method="post">
    <label>Employee ID:</label>
    <input type="text" name="emp_id" required>

    <label>Sub Department:</label>
    <input type="text" name="sub_department" required>

    <label>Task Group:</label>
    <select name="task_group" required>
        <option value="Development">Development</option>
        <option value="Testing">Testing</option>
        <option value="Support">Support</option>
    </select>

    <label>Task Description:</label>
    <select name="task_description" required>
        <option value="Feature Implementation">Feature Implementation</option>
        <option value="Bug Fixing">Bug Fixing</option>
        <option value="Testing Scenarios">Testing Scenarios</option>
    </select>

    <label>Remark:</label>
    <textarea name="remark"></textarea>

    <label>Status:</label>
    <select name="status">
        <option value="PENDING">Pending</option>
        <option value="DONE">Done</option>
    </select>

    <button type="submit">Add Task</button>
</form>
