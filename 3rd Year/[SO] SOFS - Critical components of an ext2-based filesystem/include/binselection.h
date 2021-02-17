/**
 *  \file 
 *  \brief The bin IDs selection toolkit.
 *
 *  This toolkit provides a simple way to select what binary version of
 *  the functions to use in a given moment.
 *  The selection can be done in run time.
 *  The IDs of the functions are the same used by the probing system.
 *
 *  \author Artur Pereira - 2019
 *
 *  \remarks In case an error occurs, every function throws an error code (an int)
 */

#ifndef __SOFS19_BIN_SELECTION__
#define __SOFS19_BIN_SELECTION__

#include <inttypes.h>

namespace sofs19
{

    /** 
     * \defgroup binselection BinSelection
     *  \brief The bin selection toolkit.
     *  \ingroup core
     *  \details This toolkit allows to choose the binary functions to be used.
     *      Every function in the \c sofs19 API has a unique ID.
     *      Every function to be implemented has 3 versions, with
     *      prefixes \c so, \c bin, and \c grp,
     *      corresponding to the \c main version, the \c binary version, and
     *      the \c group version, respectively.
     *      The \c main version calls either the \c binary version or
     *      the \c group version depending on the current bin configuration map.
     *      If the function ID is included in the bin configuration mao,
     *      the \c binary version is called; otherwise, the \c group
     *      version is called.
     *
     **/

    /** @{ */

    /* *************************************** */

    /**
     *  \brief Set bin configuration map.
     *  \details Resets the current bin configuration and sets the given range
     *    as the new bin configuration map.
     *  \param lower left margin of the range to be activated
     *  \param upper right margin of the range to be activated
     */
    void soBinSetIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Add bin ID range to the current bin configuration map.
     *  \param lower left margin of the range to be added
     *  \param upper right margin of the range to be added
     */
    void soBinAddIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Remove bin ID range from the current bin configuration map.
     *  \param lower left margin of the range to be deactivated
     *  \param upper right margin of the range to be deactivated
     */
    void soBinRemoveIDs(uint32_t lower, uint32_t upper);

    /* *************************************** */

    /**
     *  \brief Check if given ID is activated.
     *  \details IDs covered by the current configuration represent binary functions 
     *    to be used.
     *  \param id ID of the function to be checked
     *  \return \c true if the given ID is included in the current
     *      configuration map and \c false otherwise.
     */
    bool soBinSelected(uint32_t id);

    /* *************************************** */

    /** @} */

};

#endif /* __SOFS19_BIN_SELECTION__ */
