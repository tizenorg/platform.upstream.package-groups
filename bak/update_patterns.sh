#!/bin/bash

# Update pattern in OBS


function update_patterns () {
    prj=$1
    patterns=$2
    DEBUG=
    echo "Deleting old patterns"
    for i in `osc meta pattern $prj`; do 
        $DEBUG osc meta pattern $prj $i --delete
    done
    echo "Updating patterns"
    for i in `cat projects/$patterns`; do 
        $DEBUG osc meta pattern $prj $i -F patterns/$i.xml
    done
}




#update_patterns MeeGo:1.0:Core CORE
update_patterns Trunk TRUNK
update_patterns Trunk:Testing TRUNK

#update_patterns MeeGo:1.0:IVI IVI
update_patterns Trunk:non-oss NON-OSS
update_patterns Trunk:non-oss:Testing NON-OSS
