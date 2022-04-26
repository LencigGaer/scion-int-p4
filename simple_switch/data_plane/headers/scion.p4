#ifndef __include_scion__
#define __include_scion__

// Copy from SIDN/p4-scion repository

/* 
 * Copyright (c) 2021, SIDN Labs
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * 
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * 
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

typedef bit<16> isdAddr_t;
typedef bit<48> asAddr_t;

enum bit<8> PathType {
  SCION = 0x01,
  ONEHOP = 0x02
}

enum bit<8> NextHdr {
  TCP_SCION = 0x06,
  UDP_SCION = 0x11,
  HBH = 0xC8,
  E2E = 0xC9,
  SCMP = 0xCA,
  BFD_SCION = 0xCB
}

header scion_common_h {
    bit<4>    version;
    bit<8>    qos;
    bit<20>   flowID;
    NextHdr   nextHdr;
    bit<8>    hdrLen;
    bit<16>   payloadLen;
    PathType  pathType;
    bit<2>    dt;
    bit<2>    dl;//4,8,12,16
    bit<2>    st;
    bit<2>    sl;//4,8,12,16
    bit<16>   rsv;
}

header scion_addr_common_h {
    isdAddr_t dstISD;
    asAddr_t  dstAS;
    isdAddr_t srcISD;
    asAddr_t  srcAS;
}


header scion_addr_host_32_h {
    bit<32> host;
}

header scion_addr_host_64_h {
    bit<64> host;
}

header scion_addr_host_96_h {
    bit<96> host;
}

header scion_addr_host_128_h {
    bit<128> host;
}

header scion_addr_host_256_h {
    bit<256> host;
}

header scion_path_meta_h {
    bit<2>    currInf;
    bit<6>    currHF;
    bit<6>    rsv;
    bit<6>    seg0Len;
    bit<6>    seg1Len;
    bit<6>    seg2Len;
}

header scion_info_field_h {
    bit<6>    rsv0;
    bit<1>    peering;
    bit<1>    direction;
    bit<8>    rsv1;
    bit<16>   segId;
    bit<32>   timestamp;
}

header scion_hop_field_h {
    varbit<18144> data;
}

#endif
