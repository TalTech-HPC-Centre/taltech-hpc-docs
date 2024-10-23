<span style="color:red">not changed to rocky yet</span>

# Define 

<ol>
Define contains four main parts:
<li>    Geomery menu:  read the geometry of the molecules, set up the coordinates of the system, find out the point group symmetry</li>
<li>    Atomic attributes menu: select the basis sets for the atoms</li>
<li>    Initial guess menu: determaine the charge of the molecule and generate the initial guess for the molecular orbitals and their occupation</li>
<li>    General menu: select the computational method and set up advanced options such as excited state calculations.</li>
</ol>
    
<dl>
Some general instructions for define:
<li>    * (or q)     -     Closes the current menu and writes the data into control</li>
<li>    &            -     Returns to the previous menu</li>
<li>   qq            -     Quits Define immediately (panic button).</li>
</dl>

Usually Define offers a default choice for all questions. The default choice can be accepted simply by pressing `Enter`.

**NB!**  *define* is case-sensitive. 


## Starting define

    ***********************************************************
    *                                                         *
    *                       D E F I N E                       *
    *                                                         *
    *         TURBOMOLE`S  INTERACTIVE  INPUT  PROGRAM        *
    *                                                         *
    *  Quantum Chemistry Group       University of Karlsruhe  *
    *                                                         *
    ***********************************************************
 
 
    DATA WILL BE WRITTEN TO THE NEW FILE control
 
    IF YOU WANT TO READ DEFAULT-DATA FROM ANOTHER control-TYPE FILE,
    THEN ENTER ITS LOCATION/NAME OR OTHERWISE HIT >return<.    
`Enter`

    INPUT TITLE OR 
    ENTER & TO REPEAT DEFINITION OF DEFAULT INPUT FILE 
    
`Enter`

    SPECIFICATION OF MOLECULAR GEOMETRY ( #ATOMS=0     SYMMETRY=c1  )
    YOU MAY USE ONE OF THE FOLLOWING COMMANDS : 
    sy <group> <eps> : DEFINE MOLECULAR SYMMETRY (default for eps=3d-1)
    desy <eps>       : DETERMINE MOLECULAR SYMMETRY AND ADJUST 
                     COORDINATES (default for eps=1d-6)
    susy             : ADJUST COORDINATES FOR SUBGROUPS
    ai               : ADD ATOMIC COORDINATES INTERACTIVELY
    a <file>         : ADD ATOMIC COORDINATES FROM FILE <file>
    aa <file>        : ADD ATOMIC COORDINATES IN ANGSTROEM UNITS FROM FILE <file>
    sub              : SUBSTITUTE AN ATOM BY A GROUP OF ATOMS
    i                : INTERNAL COORDINATE MENU 
    ired             : REDUNDANT INTERNAL COORDINATES
    red_info         : DISPLAY REDUNDANT INTERNAL COORDINATES
    ff               : UFF-FORCEFIELD CALCULATION
    m                : MANIPULATE GEOMETRY
    frag             : Define Fragments for BSSE calculation
    w <file>         : WRITE MOLECULAR COORDINATES TO FILE <file> 
    r <file>         : RELOAD ATOMIC AND INTERNAL COORDINATES FROM FILE <file>
    name             : CHANGE ATOMIC IDENTIFIERS 
    del              : DELETE ATOMS 
    dis              : DISPLAY MOLECULAR GEOMETRY 
    banal            : CARRY OUT BOND ANALYSIS 
    *                : TERMINATE MOLECULAR GEOMETRY SPECIFICATION 
                        AND WRITE GEOMETRY DATA TO CONTROL FILE 

    IF YOU APPEND A QUESTION MARK TO ANY COMMAND AN EXPLANATION
    OF THAT COMMAND MAY BE GIVEN 

`a start-coord`

    CARTESIAN COORDINATES FOR  12 ATOMS HAVE SUCCESSFULLY 
    BEEN ADDED. 
    ........
    SPECIFICATION OF MOLECULAR GEOMETRY ( #ATOMS=12    SYMMETRY=c1  )

`ired`

    GEOIRED: NBDIM      30  NDEGR:      30 ......

`*`

    ATOMIC ATTRIBUTE DEFINITION MENU  ( #atoms=12    #bas=12    #ecp=4     )
    
    b    : ASSIGN ATOMIC BASIS SETS 
    bb   : b RESTRICTED TO BASIS SET LIBRARY 
    bl   : LIST ATOMIC BASIS SETS ASSIGNED
    bm   : MODIFY DEFINITION OF ATOMIC BASIS SET
    bp   : SWITCH BETWEEN 5d/7f AND 6d/10f
    lib  : SELECT BASIS SET LIBRARY
    ecp  : ASSIGN EFFECTIVE CORE POTENTIALS 
    ecpb : ecp RESTRICTED TO BASIS SET LIBRARY 
    ecpi : GENERAL INFORMATION ABOUT EFFECTIVE CORE POTENTIALS
    ecpl : LIST EFFECTIVE CORE POTENTIALS ASSIGNED
    ecprm: REMOVE EFFECTIVE CORE POTENTIAL(S)
    c    : ASSIGN NUCLEAR CHARGES (IF DIFFERENT FROM DEFAULTS) 
    cem  : ASSIGN NUCLEAR CHARGES FOR EMBEDDING 
    m    : ASSIGN ATOMIC MASSES (IF DIFFERENT FROM DEFAULTS) 
    dis  : DISPLAY MOLECULAR GEOMETRY 
    dat  : DISPLAY ATOMIC ATTRIBUTES YET ESTABLISHED 
    h    : EXPLANATION OF ATTRIBUTE DEFINITION SYNTAX 
    *    : TERMINATE THIS SECTION AND WRITE DATA OR DATA REFERENCES TO control
    GOBACK=& (TO GEOMETRY MENU !)

`*`

    OCCUPATION NUMBER & MOLECULAR ORBITAL DEFINITION MENU 

    CHOOSE COMMAND 
    infsao     : OUTPUT SAO INFORMATION 
    atb        : Switch for writing MOs in ASCII or binary format
    eht        : PROVIDE MOS && OCCUPATION NUMBERS FROM EXTENDED HUECKEL GUESS 
    use <file> : SUPPLY MO INFORMATION USING DATA FROM <file> 
    man        : MANUAL SPECIFICATION OF OCCUPATION NUMBERS 
    hcore      : HAMILTON CORE GUESS FOR MOS
    flip       : FLIP SPIN OF A SELECTED ATOM
    &          : MOVE BACK TO THE ATOMIC ATTRIBUTES MENU
    THE COMMANDS  use  OR  eht  OR  *  OR q(uit) TERMINATE THIS MENU !!! 
    FOR EXPLANATIONS APPEND A QUESTION MARK (?) TO ANY COMMAND 

`eht`  
`Enter`  
`0`   
`Enter`  

    GENERAL MENU : SELECT YOUR TOPIC 
    scf    : SELECT NON-DEFAULT SCF PARAMETER 
    mp2    : OPTIONS AND DATA GROUPS FOR rimp2 and mpgrad
    cc     : OPTIONS AND DATA GROUPS FOR ricc2
    pnocc  : OPTIONS AND DATA GROUPS FOR pnoccsd
    ex     : EXCITED STATE AND RESPONSE OPTIONS
    prop   : SELECT TOOLS FOR SCF-ORBITAL ANALYSIS 
    drv    : SELECT NON-DEFAULT INPUT PARAMETER FOR EVALUATION
          OF ANALYTICAL ENERGY DERIVATIVES 
          (GRADIENTS, FORCE CONSTANTS) 
    rex    : SELECT OPTIONS FOR GEOMETRY UPDATES USING RELAX
    stp    : SELECT NON-DEFAULT STRUCTURE OPTIMIZATION PARAMETER
    e      : DEFINE EXTERNAL ELECTROSTATIC FIELD 
    dft    : DFT Parameters 
    ri     : RI Parameters 
    rijk   : RI-JK-HF Parameters 
    rirpa  : RIRPA Parameters 
    senex  : seminumeric exchange parameters 
    hybno  : hybrid Noga/Diag parameters
    dsp    : DFT dispersion correction
    trunc  : USE TRUNCATED AUXBASIS DURING ITERATIONS 
    marij  : MULTIPOLE ACCELERATED RI-J 
    dis    : DISPLAY MOLECULAR GEOMETRY 
    list   : LIST OF CONTROL FILE 
    &      : GO BACK TO OCCUPATION/ORBITAL ASSIGNMENT MENU

    * or q : END OF DEFINE SESSION 

`*`


## Examples of define files

### _DFT calculation (PB86-D3BJ/def2-SV(P))_  

In this example, the BP86 functional (***dft/on***) and def2-SV(P) basis set (***b/all def2-SV(P)***) will be used for the calculation. This is the default level of theory for DFT calculations in TURBOMOLE. BP86 functional has a good and stable performance throughout the periodic system, and by default ***def2*** basis sets include ECPs for atoms beyond Kr. Additionally, will be used Grimme's dispersion correction D3BJ (***dsp/on/bj***). The geometry will be read from the file start-coord. Will be used the redundant internal coordinates (***ired***) since they typically result in the smallest number of optimization steps. To speed up calculations resolution-of-the-identity (RI) and multipole-accelerated RI-J (MARIJ) approximations will be used (***ri/on*** and ***marij/on***). 
The molecule's charge is -1. An initial guess of the molecular orbitals will be done by ***eht** and up to 100 iterations will be done during scf cycle (***scf/iter/100***).

**start-coord**

    $coord
        -1.95916500780981     -0.42159243893826      0.00000000000000      ir
        -1.95916500780981      4.47279824523555      0.00000000000000       i
        -6.85355569198362     -0.42159243893826      0.00000000000000       i
        -1.95916500780981     -0.42159243893826     -4.89439068417382       i
        -1.95916500780981     -0.42159243893826      3.83614404975786       c
        -2.45256841929780     -2.26300137375688      4.51014577207379       h
        -0.11775648873094      0.07181261661147      4.51014577207379       h
        -3.30717015319520      0.92641151591967      4.51014673583412       h
         1.87697904194805     -0.42159243893826      0.00000000000000       c
        -1.95916500780981     -4.25773648869612      0.00000000000000       c
         4.25501040757134     -0.42159243893826      0.00000000000000       o
        -1.95916500780981     -6.63576785431941      0.00000000000000       o
    $end

**define**

    define <<EOF
   
    
    a start-coord  
    ired  
    *
    b
    all def2-SV(P)
    *
    eht  
    yes  
    -1   
    yes  
    scf  
    iter  
    100  
    
    ri  
    on  
    
    marij  
    on  
    
    dft  
    on  
        
    dsp  
    on  
    bj  
    
    *
    EOF

**comands to run**

    ridft > JOB.out 2>JOB.err    # single point calculation using RI-approximation
    jobex -ri -c 45 > FINAL.out 2>FINAL.err # geometry optimization using RI-approximation,
                                              will be don up to 45 steps


### _DFT calculation (MO6 (hybrid functional) and different basis sets including ECP) with frozen position of several atoms_

In this example, the M06 functional (**_dft/on/func/m06_**) and two different basis sets (**_b/1 6-31G*/ecp/"i" DZP_**) will be used for calculations. For the first atom 6-31G* will bu applied and for all I atoms - def-SV(P) with ECP. The geometry will be read from the file start-coord and Cartesian coordinates will be used for further calculations. In addition, the position of the two first atoms will be frozen, that can be done only in Cartesian coordinates. The molecule's charge is 0. An initial guess of the molecular orbitals will be done by ***eht** and up to 30 default iterations will be done during scf cycle.

**start-coord**

    $coord
        0.74398670919525      0.42159243893826      0.00000000000000       n    f
        2.02272352743997      2.22995142429552      3.13219908774303       i    f
        2.02265750040888     -3.19517438119679      0.00000000000000       i
        2.02272352743997      2.22995142429552     -3.13219909530193       i
    $end

**define**

    define <<EOF
   
    
    a start-coord  
    *
    no
    b
    1 6-31G*
    ecp  
    "i" DZP 
    
    *
    eht  
    yes  
    0   
    yes  
            
    dft  
    on  
    func  
    m06  
    
    *
    EOF
   
     
**NB!**  In coord file should appear the corresponding "f" marks.

    $coord
        0.74398670919525      0.42159243893826      0.00000000000000       n    f
        2.02272352743997      2.22995142429552      3.13219908774303       i    f

**comands to run**

    dft > JOB.out 2>JOB.err      # single point calculation 
    jobex -c 45 > FINAL.out 2>FINAL.err # geometry optimization, will be done up to 45 steps

    
### _HF & optimization with frozen internal coordinated_

In this example, HF and minix basis set will be used for calculations. Some internal coordinates will be frozen (***i/idef/f tors 1 2 3 4/f bend 1 2 3/f stre 1 2***) during geometry optimization. To speed up calculations RI-approximations will be used.

**coord file**
    
    $coord
         1.27839972889714      0.80710203135546      0.00041573974923       c
         1.42630859331810      2.88253155131977      0.00372276048178       h
         3.06528696563114     -0.57632867600746     -0.00069919866917       o
        -1.91446264796512     -0.31879679861781      0.00039684248791       o
        -2.98773260513752      1.98632893279876     -0.00701088395301       h
    $end

**define**

    define <<EOF
   
    
    a start-coord  
    i
    idef
    f tors 1 2 3 4
    f bend 1 2 3 
    f stre 1 2 
    
    
    
    ired  
    *
    bb all minix  
        
    *
    eht  
    yes  
    0   
    yes  
            
    ri  
    on  
    
    *
    EOF
     
**NB!**  In coord file should appear a corresponding part with list of defined internal coordinates:

    $intdef
    # definitions of internal coordinates
    1 f  1.0000000000000 tors    1    2    3    4 val=  -0.04664
    2 f  1.0000000000000 bend    1    2    3      val=  26.89863
    3 f  1.0000000000000 stre    1    2           val=   2.08070
    
**comands to run**

    dscf > JOB.out 2>JOB.err              # single point calculation  
    jobex -ri > FINAL.out 2>FINAL.err     # geometry optimization 
    (RI-approximation will be used if it is specified in control file)
   
### _RI-MP2 calculation_

In this example, calculations will be performed at the MP2/def2-TZVP level of theory (**_b/all def2-TZVP_** and **_cc/ricc2/mp2/geoopt model=mp2_**), inner core electrons will be freezed and conergence criteria  increaced (**_mp2/freeze/*/cbas/b/all def2-TZVP/*/denconv/0.1E-07_**). The symmetry of the molecule is determined and will be utilized (***desy**). To speed up calculations RI-approximations will be used (**_ricc2_**). The molecule's charge is 0. An initial guess of the molecular orbitals will be done by ***eht** and up to 70 iterations will be done during scf cycle.

**coord file**
    
    $coord
             0.00000000000000     -0.00000000000000      0.00000000000000  c
            -1.18649579051912      1.18649579051912      1.18649579051912  h
             1.18649579051912     -1.18649579051912      1.18649579051912  h
            -1.18649579051912     -1.18649579051912     -1.18649579051912  h
             1.18649579051912      1.18649579051912     -1.18649579051912  h
    $end

**define**

    define <<EOF
   
    
    a start-coord 
    desy
    ired  
    *
    b
    all def2-TZVP
    *
    eht  
    yes  
    0   
    yes  
            
    scf
    iter
    70
    
    mp2 
    freeze
    *
    cbas
    b
    all def2-TZVP
    *   
    denconv
    0.1E-07
    *
    cc
    ricc2
    mp2 
    geoopt model=mp2
    *
    *
    *
    EOF
    
**comands to run**

      
    jobex -ri  -level mp2 > FINAL.out 2>FINAL.err




### _CC2 calculation_
 
In this example, calculations will be performed at the cc22/def2-TZVP level of theory (**_b/all def2-TZVP_** and **_cc/ricc2/cc2/geoopt model=cc2_**), inner core electrons will be freezed and conergence criteria  increaced (**_mp2/freeze/*/cbas/b/all def2-TZVP/*/denconv/0.1E-07_**). The symmetry of the molecule is determined and will be utilized (***desy**). To speed up calculations RI-approximations will be used (**_ricc2_**). The molecule's charge is 0. An initial guess of the molecular orbitals will be done by ***eht** and up to 70 iterations will be done during scf cycle.
 
**coord file**
    
    $coord
             0.00000000000000     -0.00000000000000      0.00000000000000  c
            -1.18649579051912      1.18649579051912      1.18649579051912  h
             1.18649579051912     -1.18649579051912      1.18649579051912  h
            -1.18649579051912     -1.18649579051912     -1.18649579051912  h
             1.18649579051912      1.18649579051912     -1.18649579051912  h
    $end
 
 
 **define**

    define <<EOF
   
    
    a start-coord 
    desy
    ired  
    *
    b
    all def2-TZVP
    *
    eht  
    yes  
    0   
    yes  
            
    scf
    iter
    70
    
    cc
    freeze
    *
    cbas
    b
    all def2-TZVP
    *   
    denconv
    0.1E-07
    ricc2
    cc2 
    geoopt model=cc2 
    *
    *
    *
    EOF
 
**comands to run**

    jobex -ri  -level cc2 > FINAL.out 2>FINAL.err
