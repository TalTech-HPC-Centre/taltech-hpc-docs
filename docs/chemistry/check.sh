#!/bin/bash

k=0
fold1=1

for  ((k=0; k<$fold1; k++)); do
        if [ -d "$fold1" ]; then

                ((fold1=$k+2))

                        for  ((i=0; i<=9; i++)); do
                                for  ((j=0; j<=9; j++)); do

					# ORCA                        
                                        term="$(grep 'NORMALLY' $k/$i$j/job.log 2>/dev/null)"  

					# Gaussian                      
#                                        term="$(grep 'Normal termination of' $k/$i$j/job.log 2>/dev/null)"  
 
                                        echo "where $k-$i$j"

                                        if [ -z "$term" ] ; then
                                                echo "$k-$i$j" -  "false"
                                        fi 
                                 done
                         done
        else 
        
        i=0
        fold2=1
        j=0
        fold3=1

        for  ((i=0; i<$fold2; i++)); do
                for  ((j=0; j<=$fold3; j++)); do

                        if [ -d "$i$j" ]; then

                        ((fold2=$i+2))
                        ((fold3=$j+2))

				# ORCA                        
                                term="$(grep 'NORMALLY' $k/$i$j/job.log 2>/dev/null)"  

				# Gaussian                      
#                               term="$(grep 'Normal termination of' $k/$i$j/job.log 2>/dev/null)"   
                        
				echo "where $k-$i$j"

                        if [ -z "$term" ] ; then
                                echo "$k-$i$j" -  "false"
                        fi 
                fi
                done
        done
        fi
done
