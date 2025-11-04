//********************************************************
//* Cadence.
//*
//*Author                   : chao.huang 
//*Email                    : chaoh@cadence.com
//*Filename                 : README.sv
//*Description  :                                         
//
//
//--------------------------------------------------------
//* Date	          Modified By		   Reason
//2025-05-26 07:38
//
//--------------------------------------------------------
//*******************************************************
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//  This is a CLK agent that can support Jitter,SSC and support duty cycle adjust,
//it can also support dynamic switch clk during simulation. For further used, it will support
//frequency viaration to simulate retimer or other frequency viaration cases.
//
//The number of total CLK will be set in system_param.sv in model directory.

//There are two CLK start config in this agent , one is set_one_clk_config and the other is set_one_ssc_clk_config.
//And the corresponding struct parameter is t_clk_para and t_ssc_clk_para, all above is configured by sequence.
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//
//--------------------------------------NON SSC CLK EXAMPLE------------------------------------------//
//For example (non SSC):    20GHz CLK with 0.85 duty_cycle in clk index 0      
//m_clk_seq.t_clk_para= '{clk_index : 0 , clk_en : 1, clk_frequency_MHz : 20000 ,clk_duty_cycle : 0.85,set_ini_period_rand :1};
//m_clk_seq.set_one_clk_config();
//m_clk_seq.start(m_clk_sqr);
//--------------------------------------------------------------------------------------------------//
//--------------------------------------NON SSC CLK with Jitter EXAMPLE------------------------------------------//
//For example (non SSC):    20GHz CLK with 0.85 duty_cycle in clk index 0      
//m_env.m_clk_agent.m_cfg.UI_PPM_shift_half_period[0] = 150;  this PPM value shall definated by SPEC, USB is 300PPM, so half is 150
//m_clk_seq.t_clk_para= '{clk_index : 0 , clk_en : 1, clk_frequency_MHz : 20000 ,clk_duty_cycle : 0.85,set_ini_period_rand :1};
//m_clk_seq.set_one_clk_config();
//m_clk_seq.start(m_clk_sqr);
//--------------------------------------------------------------------------------------------------//


//----------------------------------------- SSC CLK EXAMPLE------------------------------------------//
//For example (SSC): 25.6GHz with 0.5% SSC shift within 30kHz-33Khz USB4 Gen4 in clk index 2
//m_clk_seq.t_ssc_clk_para = '{clk_index:2 ,clk_en:1,clk_frequency_MHz:25600,start_freq_Mhz:25460,set_ini_period_rand:0,delta_frequency_MHz:140,delta_time :1fs,accuracy_count:3579,clk_ssc_en:1};
//m_clk_seq.set_one_ssc_clk_config();
//m_clk_seq.start(m_clk_sqr);
//
//The important value in this example is delta_time and accuracy_count. The reason is the minimum accuracy of the simulater is 1fs.
//--------------------------------------------------------------------------------------------------//
//clk_frequency_MHz(Tbase) = 25600(39063fs)   -----(T)30-33Khz-----
//      |              \                    /\                    /\                    /\                    /
//      |               \                  /  \                  /  \                  /  \                  / 
//      |                \                /    \                /    \                /    \                /  
//      |                 \              /      \              /      \              /      \              /   
//      |                  \            /        \            /        \            /        \            /    
// delta_frequency_MHz      \          /          \          /          \          /          \          /     
//  =140Mhz(Tdelta=214fs)    \        /            \        /            \        /            \        /      
//      |                     \      /              \      /              \      /              \      /       
//      |                      \    /                \    /                \    /                \    /        
//      |                       \  /                  \  /                  \  /                  \  /         
//      |                        \/                    \/                    \/                    \/          
//                  start_freq_Mhz(Tend) =25460(39277fs)
//
//  Δ = 2fs(half high period 1fs plus half low period 1fs)
//  Δmin x accuracy_count = 2fs
//  
//  (Tbase+Tend)x N = 30us
//  N = 30us/(39063+39277) = 382946
//  Δmin = Tdelta / N = 214 / 382946 = 0.0005588
//  accuracy_count = 2 / 0.0005588 = 3579
//
//--------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------//
//The test base has 4 clk that 
index0 is normal 200Mhz clk with 65 duty cycle 
index1 is normal 20Ghz clk with 50 duty cycle and with Jitter //Jitter suggested not be opened, because each cycle will random a Jitter
index2 is ssc clk 25.6GHz in 30Khz
index3 is ssc clk 800Mhz start in random frequency in 30Khz
//--run step--
//perl run.pl -run
