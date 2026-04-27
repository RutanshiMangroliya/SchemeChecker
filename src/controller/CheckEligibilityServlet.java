package controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Scheme;
import model.User;
import dao.SchemeDAO;
import dao.UserDAO;

public class CheckEligibilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        double income = Double.parseDouble(request.getParameter("income"));
        String category = request.getParameter("category");
        String location = request.getParameter("location");

        User user = new User();
        user.setName(name);
        user.setAge(age);
        user.setGender(gender);
        user.setIncome(income);
        user.setCategory(category);
        user.setLocation(location);

        UserDAO userDAO = new UserDAO();
        int userId = userDAO.insertUser(user);
        user.setId(userId);

        SchemeDAO schemeDAO = new SchemeDAO();
        List<Scheme> allSchemes = schemeDAO.getAllSchemes();
        List<Scheme> eligibleSchemes = new ArrayList<>();

        for (Scheme scheme : allSchemes) {
            boolean ageOk = user.getAge() >= scheme.getMinAge() && user.getAge() <= scheme.getMaxAge();
            boolean incomeOk = user.getIncome() <= scheme.getMaxIncome();
            boolean categoryOk = scheme.getCategoryRequired().equalsIgnoreCase("Any") 
                                 || scheme.getCategoryRequired().equalsIgnoreCase(user.getCategory());
            boolean genderOk = scheme.getGenderRequired().equalsIgnoreCase("Any") 
                               || scheme.getGenderRequired().equalsIgnoreCase(user.getGender());

            if (ageOk && incomeOk && categoryOk && genderOk) {
                eligibleSchemes.add(scheme);
                schemeDAO.saveResult(userId, scheme.getSchemeId());
            }
        }

        request.setAttribute("user", user);
        request.setAttribute("eligibleSchemes", eligibleSchemes);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
