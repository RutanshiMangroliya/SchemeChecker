package model;

public class Scheme {
    private int schemeId;
    private String name;
    private String description;
    private int minAge;
    private int maxAge;
    private double maxIncome;
    private String categoryRequired;
    private String genderRequired;
    private String applyLink;  // NEW: official government apply URL

    public Scheme() {}

    public int getSchemeId() { return schemeId; }
    public void setSchemeId(int schemeId) { this.schemeId = schemeId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getMinAge() { return minAge; }
    public void setMinAge(int minAge) { this.minAge = minAge; }

    public int getMaxAge() { return maxAge; }
    public void setMaxAge(int maxAge) { this.maxAge = maxAge; }

    public double getMaxIncome() { return maxIncome; }
    public void setMaxIncome(double maxIncome) { this.maxIncome = maxIncome; }

    public String getCategoryRequired() { return categoryRequired; }
    public void setCategoryRequired(String categoryRequired) { this.categoryRequired = categoryRequired; }

    public String getGenderRequired() { return genderRequired; }
    public void setGenderRequired(String genderRequired) { this.genderRequired = genderRequired; }

    public String getApplyLink() { return applyLink; }
    public void setApplyLink(String applyLink) { this.applyLink = applyLink; }
}
