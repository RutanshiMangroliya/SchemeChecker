package controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import dao.SchemeDAO;

public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        SchemeDAO dao = new SchemeDAO();
        
        List<Map<String, Object>> mostRecommended = dao.getMostRecommended();
        List<Map<String, Object>> categoryDistribution = dao.getCategoryDistribution();
        List<Map<String, Object>> incomeStats = dao.getIncomeGroupStats();
        
        request.setAttribute("mostRecommended", mostRecommended);
        request.setAttribute("categoryDistribution", categoryDistribution);
        request.setAttribute("incomeStats", incomeStats);
        
        request.getRequestDispatcher("report.jsp").forward(request, response);
    }
}
