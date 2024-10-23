#!/bin/bash

# Creating CREST folder in order not to distort initial conformational search files.
echo "Creating CREST folder in order not to distort initial conformational search..."

if [ ! -d "CREST" ]; then

        mkdir CREST

        cp crest_conformers.xyz CREST/
        cp crest_rotamers.xyz CREST/
        cp crest.energies CREST/
        cp struc.* CREST/

        rm *coord*  cre*  struc.out gfnff* wbo sl*
fi

# Creating ORCA backup (energies & geometries)
echo
echo "Creating ORCA backup (energies & geometries)..."

k=0
fold1=1

for  ((k=0; k<$fold1; k++)); do
        if [ -d "$fold1" ]; then

                cd $k
                touch ALL.xyz
                ((fold1=$k+2))

                        for  ((i=0; i<=9; i++)); do
                                for  ((j=0; j<=9; j++)); do
                        
                                        cd $i$j
                                        a=`sed  -n 8p  job.engrad`
                                        sed -i "s/Coordinates from ORCA-job job/ $k-$i$j geom = $a/g" job.xyz

                                        cat ../ALL.xyz job.xyz | sponge ../ALL.xyz  
                                 cd ../
                                 done
                          done
        else 

        cd $k
        touch ALL.xyz
        
        i=0
        fold2=1
        j=0
        fold3=1

        for  ((i=0; i<$fold2; i++)); do
                for  ((j=0; j<=$fold3; j++)); do

                        if [ -d "$i$j" ]; then

                        ((fold2=$i+2))
                        ((fold3=$j+2))

                        cd $i$j

                                a=`sed  -n 8p  job.engrad`
                                sed -i "s/Coordinates from ORCA-job job/ $k-$i$j geom = $a/g" job.xyz

                                cat ../ALL.xyz job.xyz | sponge ../ALL.xyz 
                        cd ../
                        fi
                done
        done
        fi
cd ../
done

module load rocky8/all
module load xtb-crest

cp CREST/struc.xyz .

#Creating input for CREST & comparing conformers in folders
echo
echo "Creating input for CREST & comparing conformers in folders..."

for ((k=0; k<$fold1; k++)); do  
        cd $k
        
        if [[ $k -lt 10 ]]; then
                sed 's/^......geom..//' ALL.xyz > orca.xyz
        
        else  
                sed 's/^.......geom..//' ALL.xyz > orca.xyz
        fi

        crest ../struc.xyz --cregen orca.xyz  > final.out
        rm *coord*   crest_best.xyz  cre_members struc.xyz *.sorted

        cat ../ORCA.xyz orca.xyz | sponge ../ORCA.xyz
        cd ../
done

# Comparing conformers by folders
echo
echo "Comparing conformers by folders..."
echo
echo
crest struc.xyz --cregen --ewin 50 ORCA.xyz  > final.out
# rm *coord* crest_best.xyz  cre_members struc.xyz *.sorted



