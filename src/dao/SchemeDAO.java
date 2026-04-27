package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Scheme;
import util.DBConnection;

public class SchemeDAO {

    public List<Scheme> getAllSchemes() {
        List<Scheme> schemes = new ArrayList<>();
        String sql = "SELECT scheme_id, name, description, min_age, max_age, " +
                     "max_income, category_required, gender_required, apply_link FROM schemes";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Scheme scheme = new Scheme();
                scheme.setSchemeId(rs.getInt("scheme_id"));
                scheme.setName(rs.getString("name"));
                scheme.setDescription(rs.getString("description"));
                scheme.setMinAge(rs.getInt("min_age"));
                scheme.setMaxAge(rs.getInt("max_age"));
                scheme.setMaxIncome(rs.getDouble("max_income"));
                scheme.setCategoryRequired(rs.getString("category_required"));
                scheme.setGenderRequired(rs.getString("gender_required"));
                scheme.setApplyLink(rs.getString("apply_link"));  // NEW
                schemes.add(scheme);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return schemes;
    }

    public void saveResult(int userId, int schemeId) {
        String sql = "INSERT INTO results (user_id, scheme_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, schemeId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, Object>> getMostRecommended() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.name, COUNT(r.id) as count FROM results r " +
                     "JOIN schemes s ON r.scheme_id = s.scheme_id " +
                     "GROUP BY s.scheme_id ORDER BY count DESC LIMIT 10";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("count", rs.getInt("count"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getCategoryDistribution() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT category, COUNT(DISTINCT id) as count FROM users GROUP BY category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("category", rs.getString("category"));
                map.put("count", rs.getInt("count"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getIncomeGroupStats() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT " +
                     "CASE " +
                     "  WHEN income < 250000 THEN 'Low' " +
                     "  WHEN income BETWEEN 250000 AND 800000 THEN 'Medium' " +
                     "  ELSE 'High' " +
                     "END AS group_name, COUNT(*) as count " +
                     "FROM users GROUP BY group_name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("group", rs.getString("group_name"));
                map.put("count", rs.getInt("count"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
