#ifndef __PORT_H
#define __PORT_H
/* code */
#include "types.h"

    // Base class for ports ,(CPU need to send  port number to MUX( multiplexure) to send data or read data from hardware)
    class Port
    {
        protected:
            uint16_t portnumber;
            Port(uint16_t portnumber);
            ~Port();
    };

    // port of 8bit (take or gibe 8bit data only)
    class Port8Bit : public Port{
        public:
            Port8Bit(uint16_t portnumber);
            ~Port8Bit();
            virtual void Write(uint8_t data);
            virtual uint8_t Read();
    };

// 8 bit port but slower than earlier one
    class Port8BitSlow : public Port8Bit{
        public:
            Port8BitSlow(uint16_t portnumber);
            ~Port8BitSlow();
            virtual void Write(uint8_t data);
            // virtual uint8_t Read();
    };


     class Port16Bit : public Port{
        public:
            Port16Bit(uint16_t portnumber);
            ~Port16Bit();
            virtual void Write(uint16_t data);
            virtual uint16_t Read();
    };

     class Port32Bit : public Port{
        public:
            Port32Bit(uint16_t portnumber);
            ~Port32Bit();
            virtual void Write(uint32_t data);
            virtual uint32_t Read();
    };

#endif //__PORT_H
