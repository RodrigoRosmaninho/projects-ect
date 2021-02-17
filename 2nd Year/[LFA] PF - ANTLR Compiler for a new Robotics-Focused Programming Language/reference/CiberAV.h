#ifndef __CIBER_CIBERAV_
#define __CIBER_CIBERAV_

#include <stdio.h>

/* CiberAV.h */

#include <stdbool.h>

//#define forever while (1)
//#define not !
//#define or ||
//#define and &&

 
/** \brief connect to a local simulator
 * \param name Robot's name
 * \param pos Robot's position in starting grid
 */
void init(const char *name, int pos);

/** \brief connect to a (possible) remote simulator
 * \param name Robot's name
 * \param pos Robot's position in starting grid
 * \param host simulator's IP address
 */
void init2(const char *name, int pos, const char *host);

/** \brief print a string
 * \param s The string to be printed
 */
void printStr(char *s);
 
/** \brief print a value
 * \param v The value to be printed
 */
void printValue(int v);

/** \brief ends the robot's run
 * \fn end()
 */
#define end() return 0;

/** \brief apply orders during time cycles 
 * \details This is the only function that calls the ReadSensors function, thus
 * it is the only one that make the system advance
 * \param time The number of cycles to apply
 */
void apply(int time);

/** \brief Apply given powers to left and write motors 
 * \details the power ranges between -150 and 150. A power of
 * 100 moves the correponding wheel 0.1 diameters in a cycle time.
 * \param left The power to be applied to the left motor
 * \param right The power to be applied to the right motor
 */
void motors(int left, int right);

/** \brief Pick up an target piece.
 * \details The robot must be over a target area to be succeful. 
 * Otherwise it is penalized
 */
void pickup();

/** \brief States that the robot starts its returning path.
 * \details Returning time is a score contributor. This way the robot
 * can explore the maze before deciding to return
 */
void returning();

/** \brief States that the robot has finished its run
 * \details The simulador finishes the robot's run as soon as this command is issued.
 * If at the end of the competition the robot doesn't send this command a penalty is applied to it.
 */
void finish();

#define FRONTSENSOR  0
#define LEFTSENSOR   1
#define RIGHTSENSOR  2
#define REARSENSOR   3

/** \brief get the distance measure by the specified obstacle sensor
 * \param sensorId the sensor to be read. 
 *   Must be one of FRONT_SENSOR, LEFTSENSOR, RIGHTSENSOR, or REARSENSOR
 * \return the sensor measure 
 */
int obstacleDistance(int sensorId);

/** \brief get the angle measure by the specified beacon sensor 
 * \param id Id of the beacon to be located. Must be a value between 
 *    1 and n, where n is the number of beacons.
 * \return The angular position of the beacon in relation to the robot front axis
 * \see avNumberOfBeacons().
 */
int beaconAngle(int id);

/** \brief get the angle measure by the compass 
 * \return The angular position of the virtual north in relation to the robot
 *   front axis.
 */
int northAngle();

/** \brief get the type of the groung the robot is over on
 * \details This is done using the ground sensor
 *   where the robot is at the moment of the reading
 * \return A value between 1 and n, if the robot is over a target area, or
 *   0 if it is out of any target area.
 */
int groundType();

/** \brief Check if robot is over the specified target area
 * \param id The target area to be detected
 * \return true if the robot is over the specified target area,
 *   and false otherwise.
 */
bool onTarget(int id);

/** \brief Get the number of beacons in the maze
 * \return The number of beacons
 */
int numberOfBeacons();

/** \brief get the angular position of the robot's starting point in 
 *     relation to its front axis
 * \details the measure is noisy.
 * \return The measured angular position.
 */
int startAngle();

/** \brief get the distance from the robot's center to its starting point.
 * \details The measure is noisy.
 * \return The measured distance
 */
int startDistance();

#endif
