#this dumptcl is for perl script for debug
set dump_sel $env(DUMP_SEL)
set dump_delay $env(DUMP_DELAY)
set dump_name $env(DUMP_NAME)
set db_name "$dump_name.db"
puts "$dump_name.db"

ida_database -open -name=$db_name -compress   

# To save smartlog information in the database.
ida_probe -log                                                                               

# To probe the signals from all scope (you can customize the scope and depth)
ida_probe -wave -wave_probe_args="[scope -tops]  * -all -depth all ACM"  

# Simulation run and exit after finish
run $dump_delay
run


