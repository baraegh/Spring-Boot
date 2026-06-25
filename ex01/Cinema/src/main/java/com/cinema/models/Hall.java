package com.cinema.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "halls")
public class Hall {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
    @Column(name = "id")
    private Long    id;

    @Column(name = "serial_number")
    private Long    serialNumber;

    @Column(name = "seats_count")
    private int     seatsCount;

    public Hall() {
    }

    public Hall(Long id, Long serialNumber, int seatsCount) {
        this.id = id;
        this.serialNumber = serialNumber;
        this.seatsCount = seatsCount;
    }

    public Hall(Long serialNumber, int seatsCount) {
        this.serialNumber = serialNumber;
        this.seatsCount = seatsCount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(Long serialNumber) {
        this.serialNumber = serialNumber;
    }

    public int getSeatsCount() {
        return seatsCount;
    }

    public void setSeatsCount(int seatsCount) {
        this.seatsCount = seatsCount;
    }

    
}
