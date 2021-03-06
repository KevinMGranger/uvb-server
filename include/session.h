#pragma once
#include <http_parser.h>
#include "buffer.h"

typedef struct {
    buffer_t name;
    buffer_t value;
} http_header_t;

typedef struct {
    uint64_t current_header;
    bool header_ready; // can we put data into the header yet?
    bool reading_value;
    bool done;
    http_header_t headers[20];
    buffer_t url;
} http_msg_t;

typedef struct {
    int fd;
    http_msg_t msg;
    http_parser parser;
} connection_t;
