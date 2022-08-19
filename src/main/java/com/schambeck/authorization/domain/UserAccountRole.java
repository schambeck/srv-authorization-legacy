package com.schambeck.authorization.domain;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class UserAccountRole {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    private String id;

    @Column(nullable = false, unique = true)
    private String role;

    public String getRole() {
        return role;
    }

    public UserAccountRole(String role) {
        this.role = role;
    }

    protected UserAccountRole() {}
}
