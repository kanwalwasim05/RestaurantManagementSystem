package com.library.librarymanagement.model;

public class Staff {
    private Integer staffId;
    private Integer branchId;
    private String name;
    private String role;
    private String email;
    private String password;

    public Staff() {}
    public Staff(Integer staffId, Integer branchId, String name, String role, String email, String password) {
        this.staffId = staffId;
        this.branchId = branchId;
        this.name = name;
        this.role = role;
        this.email = email;
        this.password = password;
    }

    public Integer getStaffId() { return staffId; }
    public void setStaffId(Integer staffId) { this.staffId = staffId; }
    public Integer getBranchId() { return branchId; }
    public void setBranchId(Integer branchId) { this.branchId = branchId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}