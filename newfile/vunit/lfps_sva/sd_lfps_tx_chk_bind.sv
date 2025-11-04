bind `PHY_TOP_NAME 
 lfps_tx_chk  lfps_tx_chk_i(
		                       .phy_reset_n         (phy_reset_n         ),
		                       .phy_mode            (phy_mode            ),
		                       .phy_rate            (phy_rate            ),
		                       .pma_refclk          (                    ),
		                       .tx_td_clk           (tx_td_clk           ),
		                       .pipe_clk            (pipe_clk            ),
		                       .pipe_tx_ones_zeros  (pipe_tx_ones_zeros  ),
		                       .pipe_powerdown      (pipe_powerdown      ),
		                       .pipe_powerdown_pcs  (pipe_powerdown_pcs  ),
		                       .pipe_tx_det_rx_lpbk (pipe_tx_det_rx_lpbk ),
		                       .pipe_tx_elec_idle   (pipe_tx_elec_idle   ),
		                       .pipe_tx_data_valid  (pipe_tx_data_valid  ),
		                       .pipe_phy_status     (pipe_phy_status     ),
		                       .tx_m                (xcvr_m_ln_0         ),
		                       .tx_p                (xcvr_p_ln_0         )
                           );
