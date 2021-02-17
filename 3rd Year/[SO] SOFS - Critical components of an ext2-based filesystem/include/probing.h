/**
 *  \file 
 *  \brief A probing toolkit.
 *
 *  This toolkit provides a simple monitoring system which allows 
 *  the programmer to include messages into his/her code.
 *  The system may be turned on or off.
 *  The system uses a probing ID to determine which messages must be displayed.
 *  The ID is a positive value.
 *  Upon writing the code, one should assign an ID to every probe message.
 *  Upon activating the probing system, 
 *      one can set, add or remove ranges of IDs that must be logged or displayed.
 *
 *  \author Artur Pereira - 2008-2009, 2016-2019
 *  \author Miguel Oliveira e Silva - 2009, 2017
 *  \author António Rui Borges - 2010-2015
 *
 *  \remarks In case an error occurs, every function throws an error code (an int)
 */

#ifndef __SOFS19_PROBING__
#define __SOFS19_PROBING__

#include <stdio.h>
#include <inttypes.h>
#include <stdarg.h>
#include <errno.h>

namespace sofs19
{

    /**
     * \defgroup probing probing
     * \brief The probing toolkit
     * \ingroup core
     * \details This toolkit allows to selected the set of functions whose
     *      probing messages should be displayed
     */

    /** @{ */

    /* *************************************** */

    extern const char *SOPROBE_RED; ///< the red probing color
    extern const char *SOPROBE_GREEN;   ///< the green probing color
    extern const char *SOPROBE_YELLOW;  ///< the yellow probing color
    extern const char *SOPROBE_BLUE;    ///< the blue probing color
    extern const char *SOPROBE_MAGENTA; ///< the magenta probing color
    extern const char *SOPROBE_CYAN;    ///< the cyan probing color

    /* *************************************** */

    /**
     *  \brief Opening of the probing system.
     *  \param fp a file pointer of the output stream to be used
     *  \param lower the minimum probing ID to be activated
     *  \param upper the maximum probing ID to be activated
     */
    void soProbeOpen(FILE * fp, uint32_t lower = 0, uint32_t upper = 1000);

    /* *************************************** */

    /**
     *  \brief Closing the probing system.
     */
    void soProbeClose(void);

    /* *************************************** */

    /**
     *  \brief Set the probing file stream.
     *  \details Only the stream is changed, keeping the activated ranges of IDs
     *  \param [in] fp a file pointer of the output stream to be used
     */
    void soProbeStream(FILE * fp);

    /* *************************************** */

    /**
     *  \brief Set probing IDs to the given range.
     *  \details remove all IDs and then activate the given range
     *  \param [in] lower the minimum probing ID to be activated
     *  \param [in] upper the maximum probing ID to be activated
     */
    void soProbeSetIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Add a range of probing IDs.
     *  \param [in] lower the minimum probing ID to be activated
     *  \param [in] upper the maximum probing ID to be activated
     */
    void soProbeAddIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Remove a range of probing IDs.
     *  \param [in] lower the minimum probing ID to be deactivated
     *  \param [in] upper the maximum probing ID to be deactivated
     */
    void soProbeRemoveIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Print a probing message with blue color if ID is visible.
     *
     *  Apart from the \e id argument it works like the \e fprintf function.
     *
     *  \param [in] id the probing ID of the message
     *  \param [in] fmt the format string (as in \e fprintf)
     */
    void soProbe(uint32_t id, const char *fmt, ...);

    /* *************************************** */

    /**
     *  \brief Print a probing message with given color if ID is visible.
     *
     *  Apart from the \e color and \e id arguments, it works like the \e fprintf function.
     *  The color is a string in ANSI terminal format. 
     *  For instance "01;31" means red font.
     *  Four macros are defined for red, blue, green and yellow.
     *
     *  \param [in] color string defining the probing color
     *  \param [in] id the probing ID of the message
     *  \param [in] fmt the format string (as in \e fprintf)
     */
    void soProbe(const char *color, uint32_t id, const char *fmt, ...);

    /* *************************************** */

    /** @} */

};

#endif /* __SOFS19_PROBING__ */
