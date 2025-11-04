database -open waves -into waves.shm -default
probe -create -database waves -all -tasks -functions -memories -depth all   $env(TEST)
 
run
