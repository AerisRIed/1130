run 20
database -open phy_waves -into waves.shm -default
probe -create cdn_phy_tb_top -depth all -tasks -functions -all -database phy_waves 
run 800