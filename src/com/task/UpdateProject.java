package com.task;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import config.DbHelper;

@WebServlet("/updateproject")
public class UpdateProject extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false); // Get existing session (do not create new one)

        // Check if session or role is null
        if (session == null || session.getAttribute("role") == null) {
            resp.sendRedirect("index.jsp"); // Redirect to login if session is invalid
            return;
        }

        String role = session.getAttribute("role").toString();
        String title = req.getParameter("title");
        String abbr = req.getParameter("abbr");
        String descr = req.getParameter("descr");
        String pid = req.getParameter("pid");
        String status = req.getParameter("status");
        String mgrid = req.getParameter("mgrid");

        try {
            if (mgrid == null) {
                DbHelper.executeDML("UPDATE task_group SET title=?,abbr=?,description=?,status=? WHERE id=?", 
                    title, abbr, descr, status, pid);
            } else {
                DbHelper.executeDML("UPDATE task_group SET title=?,abbr=?,description=?,status=?,mgrid=? WHERE id=?", 
                    title, abbr, descr, status, mgrid, pid);
            }
            session.setAttribute("msg", "Project updated successfully");
            
            // Redirect based on role
            if (role.equals("A")) {
                resp.sendRedirect("projects.jsp");
            } else {
                resp.sendRedirect("pprojects.jsp");
            }
        } catch (Exception ex) {
            System.out.println("Error " + ex.getMessage());
            session.setAttribute("error", "Failed to update project");
            resp.sendRedirect("error.jsp"); // Redirect to error page
        }
    }
}