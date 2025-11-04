# To open a database with a custom name

ida_database -open -name=waves.db -compress   

# To save smartlog information in the database.
ida_probe -log                                                                               

# To probe the signals from all scope (you can customize the scope and depth)
ida_probe -wave -wave_probe_args="[scope -tops] -all -memories -dynamic -unpacked 38912 -depth all"

# Simulation run and exit after finish
run
exit