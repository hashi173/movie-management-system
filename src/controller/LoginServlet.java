package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.MemberDAO;
import model.ManagementStaff;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDAO memberDAO;

    public LoginServlet() {
        super();
    }

    @Override
    public void init() {
        memberDAO = new MemberDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/view/Member/LoginView.jsp");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/view/Member/LoginView.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String inUsername = request.getParameter("inUsername");
        String inPassword = request.getParameter("inPassword");

        ManagementStaff managementStaff = memberDAO.checkLogin(inUsername, inPassword);
        if (managementStaff != null) {
            HttpSession session = request.getSession();
            session.setAttribute("managementStaff", managementStaff);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/ManagementStaff/ManagementStaffHomeView.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("loginError", "Sai tên đăng nhập hoặc mật khẩu!");
            request.setAttribute("inUsername", inUsername);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/Member/LoginView.jsp");
            dispatcher.forward(request, response);
        }
    }
}
