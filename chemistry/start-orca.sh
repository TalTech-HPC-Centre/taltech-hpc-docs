#!/bin/bash

if [ -f "method" ]; then
    rm method
fi

while getopts c:m:n: flag
do
    case "${flag}" in
        c) charge=${OPTARG};;
        m) mult=${OPTARG};;
        n) conf=${OPTARG};;
    esac
done
echo "Charge: $charge";
echo "Multiplisity: $mult";
echo "Number of conformers: $conf";

((hundreds=$conf/100))
((tens=($conf-$hundreds*100)/10))
((units=$conf-$tens*10-$hundreds*100))

atoms=`sed  -n 1p   crest_best.xyz`

((lines=$atoms+2))

# ORCA method 
echo "ORCA calculations will be done using RI BP86 D3BJ def2-SVP "
cat  <<EOT >> method 
! BP86 def2-SVP def2/J D3BJ Opt 
*xyz $charge $mult
EOT

# Creating ORCA input 
	for ((k=0; k<$hundreds; k++)); do  

		mkdir $k
		cd $k

		for  ((i=0; i<=9; i++)); do   
			for  ((j=0; j<=9; j++)); do    

				mkdir $i$j
				
				number=$(($i * 10 + $j + $k*100))
				((first=($number*$lines)+3))
				((last=($number*$lines)+$lines))
				
				sed -n ''$first','$last'p' ../crest_conformers.xyz | sed -e '$a*' > $i$j/b

				cat ../method $i$j/b  > $i$j/job.inp

				cd $i$j/
				sbatch ../../orca.slurm
				rm b
				cd ..

			done
		done
		cd ../
	done

	mkdir $hundreds
	cd $hundreds
	    for ((i=0; i<$tens; i++)); do   
            for ((j=0; j<=9; j++)); do   

                mkdir $i$j
                
                number=$(($i * 10 + $j + $k*100))
                ((first=($number*$lines)+3))
                ((last=($number*$lines)+$lines))

                sed -n ''$first','$last'p' ../crest_conformers.xyz | sed -e '$a*' > $i$j/b

                cat ../method $i$j/b  > $i$j/job.inp

                cd $i$j/
                sbatch ../../orca.slurm
                rm b
		        cd ../
        done
    done

	for ((j=0; j<$units; j++)); do  
			i=$tens  
		
            mkdir $i$j
		       
		    number=$(($i * 10 + $j + $k*100))
		    ((first=($number*$lines)+3))
		    ((last=($number*$lines)+$lines))

		    sed -n ''$first','$last'p' ../crest_conformers.xyz | sed -e '$a*' > $i$j/b

            cat ../method $i$j/b  > $i$j/job.inp

            cd $i$j/
            sbatch ../../orca.slurm
            rm b
            cd ../

	 done
cd ../




 
