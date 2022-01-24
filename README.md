# Verification uing uvm

### Simulation phases

> 1. module load cadence/XCELIUMMAIN/19.03.009
> 2. setenv UVMHOME \`ncroot`/tools/methodology/UVM/CDNS-1.1d
> 3. xrun -f {NAME}.f
>     - add "+svseed=random" to radomize seed
>     - add "-gui -access +rwc" to start gui mod with "rwc" rights
>     - something else
>     - ...
>     - and one more
> 4. ???
> 5. profit

## Lab_XX Notes

>All notes at local dokuwiki page:
*[for more about phases](https://cadenceedu.vo.llnwd.net/v1/Courses/Standard/UVMA/publish/UVMA_v1_2_5_rev2/05_SimulationPhases/index_player.html?theme=dusk)*


All component are ultimately derived from the subclass uvm_component, although UVM provides specialist subclasses for the test, testbench, UVC, squencer, driver, etc. 

+UVM_TESTNAME={TEST_NAME}