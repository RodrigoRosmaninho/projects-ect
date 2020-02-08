/**
 * \file 
 * \brief The \b sofs19 exception support
 * \author Artur Pereira - 2016-2019
 */
#ifndef __SOFS19_EXCEPTION__
#define __SOFS19_EXCEPTION__

#include <exception>

namespace sofs19
{

    /**
     * \defgroup exception exception
     * \brief \c sofs19 exception data type
     * \ingroup core
     * @{
     */

    /**
     * \brief The \b sofs19 exception class
     */
    class SOException:public std::exception
    {
      public:
        int en;                 ///< (system) error number
        const char *func;       ///< name of function that has thrown the exception
        char msg[100];          ///< buffer to store the exception message

        /**
         * \brief the constructor
         * \param _en (system) error number 
         * \param _func name of function throwing the exception
         */
         SOException(int _en, const char *_func);

        /**
         * \brief default exception message
         * \return pointer to exception message
         */
        const char *what() const throw();
    };

    /** @} */

};

#endif /* __SOFS19_EXCEPTION__ */
