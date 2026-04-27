package model;

public class User {
    private int id;
    private String name;
    private int age;
    private String gender;
    private double income;
    private String category;
    private String location;

    public User() {}

    public User(int id, String name, int age, String gender, double income, String category, String location) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.income = income;
        this.category = category;
        this.location = location;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public double getIncome() { return income; }
    public void setIncome(double income) { this.income = income; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
}
