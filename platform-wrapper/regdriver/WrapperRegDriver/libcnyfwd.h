/*
 * This file is the confidential and proprietary property of Convey Computer.
 * Copyright (C) 2011-2012 Convey Computer Corporation. All rights reserved.
 */

#include <stdint.h>

//COMMAND_NOT_FOUND taken from shared.h in cnyfwd tree (p6x/opt/convey/sbin/cnyfwd/shared.h)
//must be kept in sync with that file but it is in svn so its a manual process
#define COMMAND_NOT_FOUND	-100

typedef enum RTN_VAL_ENUM {

  PEEKPOKE_DEFAULT=0,
  UNSIGNED_LONG_T,
  STRING_T,
  NO_RETURN_T,
  RAW_SOCKET_T,
  FILE_T

}ppc_rtn_val_t;

#define EXPECT_ULONG_RTN "!RTN_VAL:ULONG"
#define EXPECT_STRING_RTN "!RTN_VAL:STRING"
#define EXPECT_RAW_SOCKET_RTN "!RTN_VAL:RAW"
#define EXPECT_NO_RTN "!RTN_VAL:NONE"
#define EXPECT_FILE_RTN "!RTN_VAL:FILE:"

/* Opens a socket to the MP */
extern int cny_fwd_open();

/* Closes the MP socket */
extern int cny_fwd_close();

/* Reads an fpga CSR */
extern int cny_fwd_read(char * fpga, uint64_t off, uint64_t *data);

/* Writes an fpga CSR */
extern int cny_fwd_write(char * fpga, uint64_t off, uint64_t data, uint64_t mask);

/* sends a string command to the daemon */
extern int cny_fwd_cmd(char * command, ppc_rtn_val_t rtn_type, void * rtn_val_ptr,char * rslt_file_name);

char *strcasestr(const char *haystack, const char *needle);
