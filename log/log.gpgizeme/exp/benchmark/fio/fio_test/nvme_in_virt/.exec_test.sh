#!/bin/sh

_fio_RW_QDx_MLT()
{
#_TG="RW_QD_MLT" _QD=1 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
#_TG="RW_QD_MLT" _QD=12 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
_TG="RW_QD_MLT" _QD=192 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
#_TG="RW_QD_MLT" _QD=384 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
#_TG="RW_QD_MLT" _QD=768 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
}

_fio_RW_QDx()
{
_TG="RW_QD" _QD=1 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
_TG="RW_QD" _QD=12 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
_TG="RW_QD" _QD=192 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
_TG="RW_QD" _QD=384 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
_TG="RW_QD" _QD=768 _NJ=192 _BS=4k _TY=RW _BDX; tstamp; sleep 30;
}

_fio_SW_QDx()
{
_TG="SW_QD" _QD=1 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=2 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=3 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=4 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=5 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=6 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=12 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=24 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=48 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=96 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QD" _QD=192 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
}

_fio_SW_NJx()
{
_TG="SW_NJ" _QD=1 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=2 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=3 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=4 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=5 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=6 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=12 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=24 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=48 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=96 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_NJ" _QD=1 _NJ=192 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
}

_fio_SW_QDNJx()
{
_TG="SW_QDNJ" _QD=1 _NJ=1 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=2 _NJ=2 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=3 _NJ=3 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=4 _NJ=4 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=5 _NJ=5 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=6 _NJ=6 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=12 _NJ=12 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=24 _NJ=24 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=48 _NJ=48 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=96 _NJ=96 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
_TG="SW_QDNJ" _QD=192 _NJ=192 _BS=128k _TY=SW _BDX; tstamp; sleep 30;
}




#_fio_RW_QDx;
_fio_RW_QDx_MLT;
