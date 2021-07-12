package com.labproj;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.Instant;
import java.time.ZoneId;
import java.util.Objects;

import com.influxdb.annotations.Column;
import com.influxdb.annotations.Measurement;

@Measurement(name = "state")
public class State {

    @Column(name="stateID")
    private long stateID;

    @Column(timestamp = true)
    private Instant time;

    @Column(tag = true)
    private String icao24;

    @Column(name="callsign")
    private String callsign;

    @Column(name="origin_country")
    @JsonProperty("origin_country")
    private String originCountry;

    // TODO: change to integer
    @Column(name="time_position")
    @JsonProperty("time_position")
    private String timePosition;

    @Column(name="last_contact")
    @JsonProperty("last_contact")
    private int lastContact;

    @Column(name="longitude")
    private float longitude;

    @Column(name="latitude")
    private float latitude;

    @Column(name="baro_altitude")
    @JsonProperty("baro_altitude")
    private float baroAltitude;

    @Column(name="on_ground")
    @JsonProperty("on_ground")
    private boolean onGround;

    @Column(name="velocity")
    private float velocity;

    @Column(name="true_track")
    @JsonProperty("true_track")
    private float trueTrack;

    @Column(name="vertical_rate")
    @JsonProperty("vertical_rate")
    private float verticalRate;

    @Column(name="sensors")
    private String sensors;

    @Column(name="geo_altitude")
    @JsonProperty("geo_altitude")
    private float geoAltitude;

    @Column(name="squawk")
    private String squawk;

    @Column(name="spi")
    private boolean spi;

    @Column(name="position_source")
    @JsonProperty("position_source")
    private int positionSource;

    public State() {}

    @JsonCreator
    public State(Object[] state) {
        this.icao24 = state[0] != null ? state[0].toString() : "";
        this.callsign = state[1] != null ? state[1].toString() : "";
        this.originCountry = state[2] != null ? state[2].toString() : "";
        this.timePosition = (Instant.ofEpochSecond(state[3] != null ? Integer.parseInt(state[3].toString()) : 0)
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime())
                .toString();
        this.lastContact = state[4] != null ? Integer.parseInt(state[4].toString()) : 0;
        this.longitude = state[5] != null ? Float.parseFloat(state[5].toString()) : 0;
        this.latitude = state[6] != null ? Float.parseFloat(state[6].toString()) : 0;
        this.baroAltitude = state[7] != null ? Float.parseFloat(state[7].toString()) : 0;
        this.onGround = state[8] != null ? Boolean.parseBoolean(state[8].toString()) : false;
        this.velocity = state[9] != null ? Float.parseFloat(state[9].toString()) : 0;
        this.trueTrack = state[10] != null ? Float.parseFloat(state[10].toString()) : 0;
        this.verticalRate = state[11] != null ? Float.parseFloat(state[11].toString()) : 0;
        this.sensors = state[12] != null ? state[2].toString() : "";
        this.geoAltitude = state[13] != null ? Float.parseFloat(state[13].toString()) : 0;
        this.squawk = state[14] != null ? state[14].toString() : "";
        this.spi = state[15] != null ? Boolean.parseBoolean(state[15].toString()) : false;
        this.positionSource = state[16] != null ? Integer.parseInt( state[16].toString()) : 0;
    }

    public String getIcao24() {
        return icao24;
    }

    public String getCallsign() {
        return callsign;
    }

    public String getOriginCountry() {
        return originCountry;
    }

    public String getTimePosition() {
        return timePosition;
    }

    public int getLastContact() {
        return lastContact;
    }

    public float getLongitude() {
        return longitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public float getBaroAltitude() {
        return baroAltitude;
    }

    public boolean isOnGround() {
        return onGround;
    }

    public float getVelocity() {
        return velocity;
    }

    public float getTrueTrack() {
        return trueTrack;
    }

    public float getVerticalRate() {
        return verticalRate;
    }

    public String getSensors() {
        return sensors;
    }

    public float getGeoAltitude() {
        return geoAltitude;
    }

    public String getSquawk() {
        return squawk;
    }

    public boolean isSpi() {
        return spi;
    }

    public int getPositionSource() {
        return positionSource;
    }

    public void setTime(Instant time) {
        this.time = time;
    }

    public void setStateID(long stateID) {
        this.stateID = stateID;
    }

    public void setIcao24(String icao24) {
        this.icao24 = icao24;
    }

    public void setCallsign(String callsign) {
        this.callsign = callsign;
    }

    public void setOriginCountry(String originCountry) {
        this.originCountry = originCountry;
    }

    public void setTimePosition(String timePosition) {
        this.timePosition = timePosition;
    }

    public void setLastContact(int lastContact) {
        this.lastContact = lastContact;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public void setBaroAltitude(float baroAltitude) {
        this.baroAltitude = baroAltitude;
    }

    public void setOnGround(boolean onGround) {
        this.onGround = onGround;
    }

    public void setVelocity(float velocity) {
        this.velocity = velocity;
    }

    public void setTrueTrack(float trueTrack) {
        this.trueTrack = trueTrack;
    }

    public void setVerticalRate(float verticalRate) {
        this.verticalRate = verticalRate;
    }

    public void setSensors(String sensors) {
        this.sensors = sensors;
    }

    public void setGeoAltitude(float geoAltitude) {
        this.geoAltitude = geoAltitude;
    }

    public void setSquawk(String squawk) {
        this.squawk = squawk;
    }

    public void setSpi(boolean spi) {
        this.spi = spi;
    }

    public void setPositionSource(int positionSource) {
        this.positionSource = positionSource;
    }

    /*@Override
    public String toString() {
        return "State{" +
                "icao24='" + icao24 + '\'' +
                ", callsign='" + callsign + '\'' +
                ", origin_country='" + originCountry + '\'' +
                ", time_position=" + timePosition +
                ", last_contact=" + lastContact +
                ", longitude=" + longitude +
                ", latitude=" + latitude +
                ", baro_altitude=" + baroAltitude +
                ", on_ground=" + onGround +
                ", velocity=" + velocity +
                ", true_track=" + trueTrack +
                ", vertical_rate=" + verticalRate +
                ", sensors=" + sensors +
                ", geo_altitude=" + geoAltitude +
                ", squawk='" + squawk + '\'' +
                ", spi=" + spi +
                ", position_source=" + positionSource +
                '}';
    }*/
}
