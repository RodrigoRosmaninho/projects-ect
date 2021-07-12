package pt.ua.deti.es.l31.labproject.controllers;

import java.time.Instant;

public class SimpleEnvironment {
    private String name;
    private String icao;
    private Instant time;
    private double latitude;
    private double longitude;
    private double aqi;
    private double co;
    private double no;
    private double no2;
    private double o3;
    private double so2;
    private double pm10;
    private double nh3;

    public SimpleEnvironment(String name, String icao, Instant time, double latitude, double longitude, double aqi, double co, double no, double no2, double o3, double so2, double pm10, double nh3) {
        this.name = name;
        this.icao = icao;
        this.time = time;
        this.latitude = latitude;
        this.longitude = longitude;
        this.aqi = aqi;
        this.co = co;
        this.no = no;
        this.no2 = no2;
        this.o3 = o3;
        this.so2 = so2;
        this.pm10 = pm10;
        this.nh3 = nh3;
    }

    public String getName() {
        return name;
    }

    public String getIcao() {
        return icao;
    }

    public Instant getTime() {
        return time;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getAqi() {
        return aqi;
    }

    public double getCo() {
        return co;
    }

    public double getNo() {
        return no;
    }

    public double getNo2() {
        return no2;
    }

    public double getO3() {
        return o3;
    }

    public double getSo2() {
        return so2;
    }

    public double getPm10() {
        return pm10;
    }

    public double getNh3() {
        return nh3;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setIcao(String icao) {
        this.icao = icao;
    }

    public void setTime(Instant time) {
        this.time = time;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public void setAqi(double aqi) {
        this.aqi = aqi;
    }

    public void setCo(double co) {
        this.co = co;
    }

    public void setNo(double no) {
        this.no = no;
    }

    public void setNo2(double no2) {
        this.no2 = no2;
    }

    public void setO3(double o3) {
        this.o3 = o3;
    }

    public void setSo2(double so2) {
        this.so2 = so2;
    }

    public void setPm10(double pm10) {
        this.pm10 = pm10;
    }

    public void setNh3(double nh3) {
        this.nh3 = nh3;
    }
}
