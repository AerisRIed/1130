#!/bin/csh -f

set HOST_NAME = `hostname`

./clean.csh

echo "The Host is: $HOST_NAME"

switch ("$HOST_NAME")
    case kdt-*
        echo "Jasper Running at: $HOST_NAME"
        jg -superlint superlint.tcl &
        breaksw
    case noi-*
        echo "Jasper Running at: $HOST_NAME"
        bsub -q smallq jg -superlint superlint.tcl &
        breaksw
    default:
        echo "Unknow environment for host: $HOST_NAME"
        breaksw
endsw
