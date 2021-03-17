#include <stdio.h>
#include <unistd.h>
#include <fcntl.h> 			// open
#include <inttypes.h>		 // uint8_t, etc
#include <linux/i2c-dev.h> // I2C bus definitions
#include <sys/ioctl.h>
#include <time.h>

void delay(int milliseconds)
{
    long pause;
    clock_t now,then;

    pause = milliseconds*(CLOCKS_PER_SEC/1000);
    now = then = clock();
    while( (now-then) < pause )
        now = clock();
}

int main() {
	
  int ADS_address = 0x45;	// base address of our device on the I2C bus
  int I2CFile;
  	
  uint8_t buffer[2];		// 2 byte buffer to store the data read from the I2C device
  int cnt = 0;
  int16_t val;				// Stores the 16 bit value of our ADC conversion
  int readCount = 0;
  int t = 0;

  I2CFile = open("/dev/i2c-1", O_RDWR);		// Open the I2C device
  
  ioctl(I2CFile, I2C_SLAVE, ADS_address);   // Specify the address of the I2C Slave to communicate with

  printf("Writing 0x06 \n");
  
  t = clock();
  buffer[0] = 0x06;  //reset 
  write(I2CFile, buffer, 1);	


  printf("Writing 0x4006 \n");
  buffer[0] = 0x40;
  buffer[1] = 0x06;				//continuos conversion, 90SPS
//  buffer[1] = 0x00;				//csingle shot conversion, 20SPS 
  //write(I2CFile, buffer, 2);	// this set config register
  
  
  /*
  buffer[0] = 0x20;  //read config only for debug
  write(I2CFile, buffer, 1);	  
  read(I2CFile, buffer, 1);	
  printf("config value %x \n", buffer[0]);
  */

  
	buffer[0] = 0x08;
	write(I2CFile, buffer, 1);	  // start conversion

// tentative for single shot conversion mode
//	buffer[0] = 0x21;  
//	write(I2CFile, buffer, 1);	  // read status register
	
 
// Wait for the conversion to complete, this requires bit 7 to change from 0->1
//  while ((buffer[0] & 0x80) == 0)	// readBuf[0] contains 8 MSBs of config register, AND with 10000000 to select bit 7
//  {
//	  buffer[0] = 0x21;  	// not sure if need all the time
//	  write(I2CFile, buffer, 1);	  // read status register
//	  read(I2CFile, buffer, 1);	// Read the status register into readBuf
//	  printf("status %x \r", buffer[0]);
//  }

while (cnt < 1000)
{
  buffer[0] = 0x10;
  write(I2CFile, buffer, 1);	// command to read value
  
  readCount = read(I2CFile, buffer, 2);		// Read the contents of the conversion register into readBuf
  if (readCount != 2)
  {
    printf("I2C Read error %d", readCount);
  }

  val = buffer[0] << 8 | buffer[1];	// Combine the two bytes of readBuf into a single 16 bit result 
  
  printf("%d AD Reading %d  (0x%x)\n",++cnt, val, val);	// Print the result to terminal

  delay(100);
}		
  close(I2CFile);
  
  return 0;

}
