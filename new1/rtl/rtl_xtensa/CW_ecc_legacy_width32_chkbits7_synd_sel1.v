`ifdef ONE_HOT_MUX
module u_1_CDN_bmux2(sel0, data0, data1, z);
  input sel0, data0, data1;
  output z;
  wire sel0, data0, data1;
  reg  z;
  always
    @(sel0 or data0 or data1)
      case ({sel0})
       1'b0: z = data0;
       1'b1: z = data1;
      endcase
endmodule
`else
module u_1_CDN_bmux2(sel0, data0, data1, z);
  input sel0, data0, data1;
  output z;
  wire sel0, data0, data1;
  wire z;
  wire inv_sel0, w_0, w_1;
  not i_0 (inv_sel0, sel0);
  and a_0 (w_0, inv_sel0, data0);
  and a_1 (w_1, sel0, data1);
  or org (z, w_0, w_1);
endmodule
`endif // ONE_HOT_MUX

module u_1_RC_DP_equal_unsigned_2(A, B, Z);
  input [10:0] A;
  input B;
  output Z;
  wire [10:0] A;
  wire B;
  wire Z;
  wire n_14, n_15, n_16, n_17, n_18;
  xnor RC_i_1 (n_14, A[0], B);
  nor RC_i_2 (n_15, A[10], A[9], A[8], A[7]);
  nor RC_i_3 (n_16, A[6], A[5], A[4], A[3]);
  nor RC_i_4 (n_17, A[2], A[1]);
  nand RC_i_5 (n_18, n_14, n_15, n_16, n_17);
  not RC_i_6 (Z, n_18);
endmodule

module u_1_RC_DP_bmux(ctl, in_0, in_1, z);
  input ctl;
  input [6:0] in_0, in_1;
  output [6:0] z;
  wire ctl;
  wire [6:0] in_0, in_1;
  wire [6:0] z;
  u_1_CDN_bmux2 RC_i_1(.sel0 (ctl), .data0 (in_0[6]), .data1 (in_1[6]), .z
       (z[6]));
  u_1_CDN_bmux2 RC_i_2(.sel0 (ctl), .data0 (in_0[5]), .data1 (in_1[5]), .z
       (z[5]));
  u_1_CDN_bmux2 RC_i_3(.sel0 (ctl), .data0 (in_0[4]), .data1 (in_1[4]), .z
       (z[4]));
  u_1_CDN_bmux2 RC_i_4(.sel0 (ctl), .data0 (in_0[3]), .data1 (in_1[3]), .z
       (z[3]));
  u_1_CDN_bmux2 RC_i_5(.sel0 (ctl), .data0 (in_0[2]), .data1 (in_1[2]), .z
       (z[2]));
  u_1_CDN_bmux2 RC_i_6(.sel0 (ctl), .data0 (in_0[1]), .data1 (in_1[1]), .z
       (z[1]));
  u_1_CDN_bmux2 RC_i_7(.sel0 (ctl), .data0 (in_0[0]), .data1 (in_1[0]), .z
       (z[0]));
endmodule

module u_1_RC_DP_bmux_5(ctl, in_0, in_1, z);
  input ctl;
  input [38:0] in_0, in_1;
  output [38:0] z;
  wire ctl;
  wire [38:0] in_0, in_1;
  wire [38:0] z;
  u_1_CDN_bmux2 RC_i_1(.sel0 (ctl), .data0 (in_0[38]), .data1 (in_1[38]),
       .z (z[38]));
  u_1_CDN_bmux2 RC_i_2(.sel0 (ctl), .data0 (in_0[37]), .data1 (in_1[37]),
       .z (z[37]));
  u_1_CDN_bmux2 RC_i_3(.sel0 (ctl), .data0 (in_0[36]), .data1 (in_1[36]),
       .z (z[36]));
  u_1_CDN_bmux2 RC_i_4(.sel0 (ctl), .data0 (in_0[35]), .data1 (in_1[35]),
       .z (z[35]));
  u_1_CDN_bmux2 RC_i_5(.sel0 (ctl), .data0 (in_0[34]), .data1 (in_1[34]),
       .z (z[34]));
  u_1_CDN_bmux2 RC_i_6(.sel0 (ctl), .data0 (in_0[33]), .data1 (in_1[33]),
       .z (z[33]));
  u_1_CDN_bmux2 RC_i_7(.sel0 (ctl), .data0 (in_0[32]), .data1 (in_1[32]),
       .z (z[32]));
  u_1_CDN_bmux2 RC_i_8(.sel0 (ctl), .data0 (in_0[31]), .data1 (in_1[31]),
       .z (z[31]));
  u_1_CDN_bmux2 RC_i_9(.sel0 (ctl), .data0 (in_0[30]), .data1 (in_1[30]),
       .z (z[30]));
  u_1_CDN_bmux2 RC_i_10(.sel0 (ctl), .data0 (in_0[29]), .data1 (in_1[29]),
       .z (z[29]));
  u_1_CDN_bmux2 RC_i_11(.sel0 (ctl), .data0 (in_0[28]), .data1 (in_1[28]),
       .z (z[28]));
  u_1_CDN_bmux2 RC_i_12(.sel0 (ctl), .data0 (in_0[27]), .data1 (in_1[27]),
       .z (z[27]));
  u_1_CDN_bmux2 RC_i_13(.sel0 (ctl), .data0 (in_0[26]), .data1 (in_1[26]),
       .z (z[26]));
  u_1_CDN_bmux2 RC_i_14(.sel0 (ctl), .data0 (in_0[25]), .data1 (in_1[25]),
       .z (z[25]));
  u_1_CDN_bmux2 RC_i_15(.sel0 (ctl), .data0 (in_0[24]), .data1 (in_1[24]),
       .z (z[24]));
  u_1_CDN_bmux2 RC_i_16(.sel0 (ctl), .data0 (in_0[23]), .data1 (in_1[23]),
       .z (z[23]));
  u_1_CDN_bmux2 RC_i_17(.sel0 (ctl), .data0 (in_0[22]), .data1 (in_1[22]),
       .z (z[22]));
  u_1_CDN_bmux2 RC_i_18(.sel0 (ctl), .data0 (in_0[21]), .data1 (in_1[21]),
       .z (z[21]));
  u_1_CDN_bmux2 RC_i_19(.sel0 (ctl), .data0 (in_0[20]), .data1 (in_1[20]),
       .z (z[20]));
  u_1_CDN_bmux2 RC_i_20(.sel0 (ctl), .data0 (in_0[19]), .data1 (in_1[19]),
       .z (z[19]));
  u_1_CDN_bmux2 RC_i_21(.sel0 (ctl), .data0 (in_0[18]), .data1 (in_1[18]),
       .z (z[18]));
  u_1_CDN_bmux2 RC_i_22(.sel0 (ctl), .data0 (in_0[17]), .data1 (in_1[17]),
       .z (z[17]));
  u_1_CDN_bmux2 RC_i_23(.sel0 (ctl), .data0 (in_0[16]), .data1 (in_1[16]),
       .z (z[16]));
  u_1_CDN_bmux2 RC_i_24(.sel0 (ctl), .data0 (in_0[15]), .data1 (in_1[15]),
       .z (z[15]));
  u_1_CDN_bmux2 RC_i_25(.sel0 (ctl), .data0 (in_0[14]), .data1 (in_1[14]),
       .z (z[14]));
  u_1_CDN_bmux2 RC_i_26(.sel0 (ctl), .data0 (in_0[13]), .data1 (in_1[13]),
       .z (z[13]));
  u_1_CDN_bmux2 RC_i_27(.sel0 (ctl), .data0 (in_0[12]), .data1 (in_1[12]),
       .z (z[12]));
  u_1_CDN_bmux2 RC_i_28(.sel0 (ctl), .data0 (in_0[11]), .data1 (in_1[11]),
       .z (z[11]));
  u_1_CDN_bmux2 RC_i_29(.sel0 (ctl), .data0 (in_0[10]), .data1 (in_1[10]),
       .z (z[10]));
  u_1_CDN_bmux2 RC_i_30(.sel0 (ctl), .data0 (in_0[9]), .data1 (in_1[9]), .z
       (z[9]));
  u_1_CDN_bmux2 RC_i_31(.sel0 (ctl), .data0 (in_0[8]), .data1 (in_1[8]), .z
       (z[8]));
  u_1_CDN_bmux2 RC_i_32(.sel0 (ctl), .data0 (in_0[7]), .data1 (in_1[7]), .z
       (z[7]));
  u_1_CDN_bmux2 RC_i_33(.sel0 (ctl), .data0 (in_0[6]), .data1 (in_1[6]), .z
       (z[6]));
  u_1_CDN_bmux2 RC_i_34(.sel0 (ctl), .data0 (in_0[5]), .data1 (in_1[5]), .z
       (z[5]));
  u_1_CDN_bmux2 RC_i_35(.sel0 (ctl), .data0 (in_0[4]), .data1 (in_1[4]), .z
       (z[4]));
  u_1_CDN_bmux2 RC_i_36(.sel0 (ctl), .data0 (in_0[3]), .data1 (in_1[3]), .z
       (z[3]));
  u_1_CDN_bmux2 RC_i_37(.sel0 (ctl), .data0 (in_0[2]), .data1 (in_1[2]), .z
       (z[2]));
  u_1_CDN_bmux2 RC_i_38(.sel0 (ctl), .data0 (in_0[1]), .data1 (in_1[1]), .z
       (z[1]));
  u_1_CDN_bmux2 RC_i_39(.sel0 (ctl), .data0 (in_0[0]), .data1 (in_1[0]), .z
       (z[0]));
endmodule

module u_1_RC_DP_bmux_7(ctl, in_0, in_1, z);
  input ctl;
  input [31:0] in_0, in_1;
  output [31:0] z;
  wire ctl;
  wire [31:0] in_0, in_1;
  wire [31:0] z;
  u_1_CDN_bmux2 RC_i_1(.sel0 (ctl), .data0 (in_0[31]), .data1 (in_1[31]),
       .z (z[31]));
  u_1_CDN_bmux2 RC_i_2(.sel0 (ctl), .data0 (in_0[30]), .data1 (in_1[30]),
       .z (z[30]));
  u_1_CDN_bmux2 RC_i_3(.sel0 (ctl), .data0 (in_0[29]), .data1 (in_1[29]),
       .z (z[29]));
  u_1_CDN_bmux2 RC_i_4(.sel0 (ctl), .data0 (in_0[28]), .data1 (in_1[28]),
       .z (z[28]));
  u_1_CDN_bmux2 RC_i_5(.sel0 (ctl), .data0 (in_0[27]), .data1 (in_1[27]),
       .z (z[27]));
  u_1_CDN_bmux2 RC_i_6(.sel0 (ctl), .data0 (in_0[26]), .data1 (in_1[26]),
       .z (z[26]));
  u_1_CDN_bmux2 RC_i_7(.sel0 (ctl), .data0 (in_0[25]), .data1 (in_1[25]),
       .z (z[25]));
  u_1_CDN_bmux2 RC_i_8(.sel0 (ctl), .data0 (in_0[24]), .data1 (in_1[24]),
       .z (z[24]));
  u_1_CDN_bmux2 RC_i_9(.sel0 (ctl), .data0 (in_0[23]), .data1 (in_1[23]),
       .z (z[23]));
  u_1_CDN_bmux2 RC_i_10(.sel0 (ctl), .data0 (in_0[22]), .data1 (in_1[22]),
       .z (z[22]));
  u_1_CDN_bmux2 RC_i_11(.sel0 (ctl), .data0 (in_0[21]), .data1 (in_1[21]),
       .z (z[21]));
  u_1_CDN_bmux2 RC_i_12(.sel0 (ctl), .data0 (in_0[20]), .data1 (in_1[20]),
       .z (z[20]));
  u_1_CDN_bmux2 RC_i_13(.sel0 (ctl), .data0 (in_0[19]), .data1 (in_1[19]),
       .z (z[19]));
  u_1_CDN_bmux2 RC_i_14(.sel0 (ctl), .data0 (in_0[18]), .data1 (in_1[18]),
       .z (z[18]));
  u_1_CDN_bmux2 RC_i_15(.sel0 (ctl), .data0 (in_0[17]), .data1 (in_1[17]),
       .z (z[17]));
  u_1_CDN_bmux2 RC_i_16(.sel0 (ctl), .data0 (in_0[16]), .data1 (in_1[16]),
       .z (z[16]));
  u_1_CDN_bmux2 RC_i_17(.sel0 (ctl), .data0 (in_0[15]), .data1 (in_1[15]),
       .z (z[15]));
  u_1_CDN_bmux2 RC_i_18(.sel0 (ctl), .data0 (in_0[14]), .data1 (in_1[14]),
       .z (z[14]));
  u_1_CDN_bmux2 RC_i_19(.sel0 (ctl), .data0 (in_0[13]), .data1 (in_1[13]),
       .z (z[13]));
  u_1_CDN_bmux2 RC_i_20(.sel0 (ctl), .data0 (in_0[12]), .data1 (in_1[12]),
       .z (z[12]));
  u_1_CDN_bmux2 RC_i_21(.sel0 (ctl), .data0 (in_0[11]), .data1 (in_1[11]),
       .z (z[11]));
  u_1_CDN_bmux2 RC_i_22(.sel0 (ctl), .data0 (in_0[10]), .data1 (in_1[10]),
       .z (z[10]));
  u_1_CDN_bmux2 RC_i_23(.sel0 (ctl), .data0 (in_0[9]), .data1 (in_1[9]), .z
       (z[9]));
  u_1_CDN_bmux2 RC_i_24(.sel0 (ctl), .data0 (in_0[8]), .data1 (in_1[8]), .z
       (z[8]));
  u_1_CDN_bmux2 RC_i_25(.sel0 (ctl), .data0 (in_0[7]), .data1 (in_1[7]), .z
       (z[7]));
  u_1_CDN_bmux2 RC_i_26(.sel0 (ctl), .data0 (in_0[6]), .data1 (in_1[6]), .z
       (z[6]));
  u_1_CDN_bmux2 RC_i_27(.sel0 (ctl), .data0 (in_0[5]), .data1 (in_1[5]), .z
       (z[5]));
  u_1_CDN_bmux2 RC_i_28(.sel0 (ctl), .data0 (in_0[4]), .data1 (in_1[4]), .z
       (z[4]));
  u_1_CDN_bmux2 RC_i_29(.sel0 (ctl), .data0 (in_0[3]), .data1 (in_1[3]), .z
       (z[3]));
  u_1_CDN_bmux2 RC_i_30(.sel0 (ctl), .data0 (in_0[2]), .data1 (in_1[2]), .z
       (z[2]));
  u_1_CDN_bmux2 RC_i_31(.sel0 (ctl), .data0 (in_0[1]), .data1 (in_1[1]), .z
       (z[1]));
  u_1_CDN_bmux2 RC_i_32(.sel0 (ctl), .data0 (in_0[0]), .data1 (in_1[0]), .z
       (z[0]));
endmodule

module u_1_RC_DP_bmux_8(ctl, in_0, in_1, z);
  input ctl, in_0, in_1;
  output z;
  wire ctl, in_0, in_1;
  wire z;
  u_1_CDN_bmux2 RC_i_1(.sel0 (ctl), .data0 (in_0), .data1 (in_1), .z (z));
endmodule

module CW_ecc_legacy_width32_chkbits7_synd_sel1(gen, correct_n,
     datain, chkin, err_detect, err_multpl, dataout, chkout);
  input gen, correct_n;
  input [31:0] datain;
  input [6:0] chkin;
  output err_detect, err_multpl;
  output [31:0] dataout;
  output [6:0] chkout;
  wire gen, correct_n;
  wire [31:0] datain;
  wire [6:0] chkin;
  wire err_detect, err_multpl;
  wire [31:0] dataout;
  wire [6:0] chkout;
  wire [10:0] syn_chk;
  wire [10:0] syn;
  wire [511:0] full_correct_mask;
  wire [511:0] full_chk_val;
  wire det, mult, n_1438, n_1439, n_1440, n_1441, n_1442, n_1443;
  wire n_1444, n_1445, n_1446, n_1447, n_1448, n_1449, n_1450, n_1451;
  wire n_1452, n_1453, n_1454, n_1455, n_1456, n_1457, n_1458, n_1459;
  wire n_1460, n_1461, n_1462, n_1463, n_1464, n_1465, n_1466, n_1467;
  wire n_1468, n_1469, n_1470, n_1471, n_1472, n_1473, n_1474, n_1475;
  wire n_1476, n_1477, n_1478, n_1479, n_1480, n_1481, n_1482, n_1483;
  wire n_1484, n_1485, n_1486, n_1487, n_1488, n_1489, n_1490, n_1491;
  wire n_1492, n_1493, n_1494, n_1495, n_1496, n_1497, n_1498, n_1499;
  wire n_1500, n_1501, n_1502, n_1503, n_1504, n_1505, n_1506, n_1507;
  wire n_1508, n_1509, n_1510, n_1511, n_1512, n_1513, n_1514, n_1515;
  wire n_1516, n_1517, n_1518, n_1551, n_1552, n_1553, n_1725, n_1782;
  wire n_2005, n_2031, n_2044, n_2065, n_2070, n_2074, n_2076, n_2077;
  wire n_2079, n_2080, n_2081, n_2082, n_2083, n_2084, n_2085, n_2138;
  wire n_2149, n_2346, n_2446, n_2447, n_2449, n_2530, n_2540, n_2543;
  wire n_2544, n_2548, n_2549, n_2551, n_2553, n_2554, n_2555, n_2560;
  wire n_2561, n_2562, n_2563, n_2564, n_2565, n_2566, n_2567, n_2568;
  wire n_2569, n_2570, n_2571, n_2572, n_2573, n_2574, n_2575, n_2576;
  wire n_2577, n_2578, n_2579, n_2580, n_2581, n_2582, n_2583, n_2584;
  wire n_2585, n_2586, n_2587, n_2588, n_2589, n_2590, n_2591, n_2592;
  wire n_2593, n_2594, n_2595, n_2596, n_2597, n_2598, n_2599, n_2600;
  wire n_2601, n_2602, n_2603, n_2604, n_2605, n_2606, n_2607, n_2608;
  wire n_2609, n_2610, n_2611, n_2612, n_2613, n_2614, n_2615, n_2616;
  wire n_2617, n_2618, n_2619, n_2620, n_2621, n_2622, n_2623, n_2624;
  wire n_2625, n_2626, n_2627, n_2628, n_2629, n_2630, n_2631, n_2632;
  wire n_2633, n_2634, n_2635, n_2636, n_2637, n_2638, n_2639, n_2640;
  wire n_2641, n_2642, n_2643, n_2644, n_2645, n_2646, n_2647, n_2648;
  wire n_2649, n_2650, n_2651, n_2652, n_2653, n_2654, n_2655, n_2656;
  wire n_2657, n_2658, n_2659, n_2660, n_2661, n_2662, n_2663, n_2664;
  wire n_2665, n_2666, n_2667, n_2668, n_2669, n_2670, n_2671, n_2672;
  wire n_2673, n_2674, n_2675, n_2676, n_2677, n_2678, n_2679, n_2680;
  wire n_2681, n_2682, n_2683, n_2684, n_2685, n_2686, n_2687, n_2688;
  wire n_2689, n_2690, n_2691, n_2692, n_2693, n_2694, n_2695, n_2696;
  wire n_2697, n_2698, n_2699, n_2700, n_2701, n_2703, n_2704, n_2705;
  wire n_2706, n_2707, n_2708, n_2709, n_2710, n_2711, n_2712, n_2713;
  wire n_2714, n_2715, n_2716, n_2717, n_2718, n_2719, n_2720, n_2721;
  wire n_2722, n_2723, n_2724, n_2725, n_2726, n_2727, n_2728, n_2729;
  wire n_2730, n_2731, n_2732, n_2733, n_2734, n_2735, n_2736, n_2737;
  wire n_2738, n_2739, n_2740, n_2741, n_2742, n_2743, n_2744, n_2745;
  wire n_2746, n_2747, n_2748, n_2749, n_2750, n_2751, n_2752, n_2753;
  wire n_2754, n_2755, n_2756, n_2757, n_2758, n_2759, n_2760, n_2761;
  u_1_RC_DP_equal_unsigned_2 eq_1_19(.A ({4'b0000, syn_chk[6:0]}), .B
       (1'b0), .Z (n_1440));
  u_1_RC_DP_bmux mux_1_18(.ctl (gen), .in_0 (syn_chk[6:0]), .in_1
       (syn[6:0]), .z (chkout));
  u_1_RC_DP_bmux_5 mux_full_correct_mask_1_19(.ctl (n_1440), .in_0
       ({n_1479, n_1478, n_1477, n_1476, n_1475, n_1474, n_1473,
       n_1472, n_1471, n_1470, n_1469, n_1468, n_1467, n_1466, n_1465,
       n_1464, n_1463, n_1462, n_1461, n_1460, n_1459, n_1458, n_1457,
       n_1456, n_1455, n_1454, n_1453, n_1452, n_1451, n_1450, n_1449,
       n_1448, n_1447, n_1446, n_1445, n_1444, n_1443, n_1442,
       n_1441}), .in_1 (39'b000000000000000000000000000000000000000),
       .z ({n_1518, n_1517, n_1516, n_1515, n_1514, n_1513, n_1512,
       n_1511, n_1510, n_1509, n_1508, n_1507, n_1506, n_1505, n_1504,
       n_1503, n_1502, n_1501, n_1500, n_1499, n_1498, n_1497, n_1496,
       n_1495, n_1494, n_1493, n_1492, n_1491, n_1490, n_1489, n_1488,
       n_1487, n_1486, n_1485, n_1484, n_1483, n_1482, n_1481,
       n_1480}));
  u_1_RC_DP_bmux_5 mux_full_correct_mask_1_12(.ctl (n_1439), .in_0
       (39'b000000000000000000000000000000000000000), .in_1 ({n_1518,
       n_1517, n_1516, n_1515, n_1514, n_1513, n_1512, n_1511, n_1510,
       n_1509, n_1508, n_1507, n_1506, n_1505, n_1504, n_1503, n_1502,
       n_1501, n_1500, n_1499, n_1498, n_1497, n_1496, n_1495, n_1494,
       n_1493, n_1492, n_1491, n_1490, n_1489, n_1488, n_1487, n_1486,
       n_1485, n_1484, n_1483, n_1482, n_1481, n_1480}), .z
       (full_correct_mask[38:0]));
  u_1_RC_DP_bmux_7 mux_1_33(.ctl (n_1438), .in_0 (datain), .in_1
       (full_chk_val[31:0]), .z (dataout));
  u_1_RC_DP_bmux_8 mux_mult_1_19(.ctl (n_1440), .in_0 (n_1551), .in_1
       (1'b0), .z (n_1552));
  u_1_RC_DP_bmux_8 mux_mult_1_12(.ctl (n_1439), .in_0 (1'b0), .in_1
       (n_1552), .z (mult));
  u_1_RC_DP_bmux_8 mux_1_22(.ctl (gen), .in_0 (mult), .in_1 (1'b0), .z
       (err_multpl));
  u_1_RC_DP_bmux_8 mux_det_1_19(.ctl (n_1440), .in_0 (1'b1), .in_1 (1'b0),
       .z (n_1553));
  u_1_RC_DP_bmux_8 mux_det_1_12(.ctl (n_1439), .in_0 (1'b0), .in_1
       (n_1553), .z (det));
  u_1_RC_DP_bmux_8 mux_1_29(.ctl (gen), .in_0 (det), .in_1 (1'b0), .z
       (err_detect));
  or RC_i_24 (n_2005, gen, correct_n);
  xor RC_i_101 (n_2044, datain[4], datain[9]);
  xor RC_i_111 (n_2031, datain[28], datain[14]);
  xor RC_i_112 (n_2070, datain[29], n_2031);
  xor RC_i_114 (n_2065, datain[7], datain[18]);
  xor RC_i_126 (n_2079, datain[6], datain[26]);
  xor RC_i_127 (n_2076, datain[0], datain[17]);
  xor RC_i_128 (n_2077, datain[19], datain[8]);
  xor RC_i_131 (n_2074, datain[21], n_2044);
  xor RC_i_133 (n_2080, datain[11], n_2070);
  xor RC_i_134 (n_2083, n_2074, datain[31]);
  xor RC_i_135 (n_2082, n_2076, n_2077);
  xor RC_i_136 (n_2081, n_2065, n_2079);
  xor RC_i_137 (n_2084, n_2080, n_2081);
  xor RC_i_138 (n_2085, n_2082, n_2083);
  xor RC_i_139 (syn[0], n_2084, n_2085);
  xor RC_i_222 (n_2138, datain[0], datain[28]);
  xor RC_i_234 (n_2149, datain[1], datain[12]);
  xor RC_i_540 (n_2346, datain[2], datain[5]);
  xor RC_i_653 (n_2447, datain[25], datain[26]);
  xor RC_i_655 (n_2446, datain[30], datain[27]);
  xor RC_i_670 (n_2449, n_2446, n_2447);
  xor RC_i_768 (n_2540, datain[29], datain[28]);
  xor RC_i_779 (n_2530, datain[0], datain[1]);
  xor RC_i_782 (n_2549, datain[6], n_2449);
  xor RC_i_785 (n_2548, n_2346, datain[7]);
  xor RC_i_787 (n_2544, datain[3], datain[4]);
  xor RC_i_788 (n_2543, n_2540, datain[24]);
  xor RC_i_790 (n_2553, n_2544, datain[31]);
  xor RC_i_792 (n_2551, n_2548, n_2549);
  xor RC_i_793 (n_2554, n_2543, n_2551);
  xor RC_i_794 (n_2555, n_2530, n_2553);
  xor RC_i_795 (syn[6], n_2554, n_2555);
  xor RC_i_796 (syn_chk[0], syn[0], chkin[0]);
  xor RC_i_797 (syn_chk[1], syn[1], chkin[1]);
  xor RC_i_798 (syn_chk[2], syn[2], chkin[2]);
  xor RC_i_799 (syn_chk[3], syn[3], chkin[3]);
  xor RC_i_800 (syn_chk[4], syn[4], chkin[4]);
  xor RC_i_801 (syn_chk[5], syn[5], chkin[5]);
  xor RC_i_802 (syn_chk[6], syn[6], chkin[6]);
  xor RC_i_807 (full_chk_val[0], datain[0], full_correct_mask[0]);
  xor RC_i_808 (full_chk_val[1], datain[1], full_correct_mask[1]);
  xor RC_i_809 (full_chk_val[2], datain[2], full_correct_mask[2]);
  xor RC_i_810 (full_chk_val[3], datain[3], full_correct_mask[3]);
  xor RC_i_811 (full_chk_val[4], datain[4], full_correct_mask[4]);
  xor RC_i_812 (full_chk_val[5], datain[5], full_correct_mask[5]);
  xor RC_i_813 (full_chk_val[6], datain[6], full_correct_mask[6]);
  xor RC_i_814 (full_chk_val[7], datain[7], full_correct_mask[7]);
  xor RC_i_815 (full_chk_val[8], datain[8], full_correct_mask[8]);
  xor RC_i_816 (full_chk_val[9], datain[9], full_correct_mask[9]);
  xor RC_i_817 (full_chk_val[10], datain[10], full_correct_mask[10]);
  xor RC_i_818 (full_chk_val[11], datain[11], full_correct_mask[11]);
  xor RC_i_819 (full_chk_val[12], datain[12], full_correct_mask[12]);
  xor RC_i_820 (full_chk_val[13], datain[13], full_correct_mask[13]);
  xor RC_i_821 (full_chk_val[14], datain[14], full_correct_mask[14]);
  xor RC_i_822 (full_chk_val[15], datain[15], full_correct_mask[15]);
  xor RC_i_823 (full_chk_val[16], datain[16], full_correct_mask[16]);
  xor RC_i_824 (full_chk_val[17], datain[17], full_correct_mask[17]);
  xor RC_i_825 (full_chk_val[18], datain[18], full_correct_mask[18]);
  xor RC_i_826 (full_chk_val[19], datain[19], full_correct_mask[19]);
  xor RC_i_827 (full_chk_val[20], datain[20], full_correct_mask[20]);
  xor RC_i_22 (full_chk_val[21], datain[21], full_correct_mask[21]);
  xor RC_i_23 (full_chk_val[22], datain[22], full_correct_mask[22]);
  xor RC_i_828 (full_chk_val[23], datain[23], full_correct_mask[23]);
  xor RC_i_829 (full_chk_val[24], datain[24], full_correct_mask[24]);
  xor RC_i_830 (full_chk_val[25], datain[25], full_correct_mask[25]);
  xor RC_i_831 (full_chk_val[26], datain[26], full_correct_mask[26]);
  xor RC_i_832 (full_chk_val[27], datain[27], full_correct_mask[27]);
  xor RC_i_833 (full_chk_val[28], datain[28], full_correct_mask[28]);
  xor RC_i_834 (full_chk_val[29], datain[29], full_correct_mask[29]);
  xor RC_i_835 (full_chk_val[30], datain[30], full_correct_mask[30]);
  xor RC_i_836 (full_chk_val[31], datain[31], full_correct_mask[31]);
  not RC_i_837 (n_2560, syn_chk[6]);
  and RC_i_838 (n_2561, n_2560, syn_chk[5]);
  and RC_i_839 (n_2562, n_2560, syn_chk[4]);
  or RC_i_840 (n_2567, n_2561, n_2562);
  not RC_i_841 (n_2563, syn_chk[5]);
  not RC_i_842 (n_2564, syn_chk[4]);
  and RC_i_843 (n_2565, n_2563, n_2564);
  not RC_i_844 (n_2566, syn_chk[3]);
  and RC_i_845 (n_2568, n_2565, n_2566);
  and RC_i_846 (n_2569, n_2567, syn_chk[3]);
  or RC_i_847 (n_2570, n_2568, n_2569);
  and RC_i_848 (n_2571, n_2560, syn_chk[2]);
  or RC_i_849 (n_2599, n_2570, n_2571);
  and RC_i_850 (n_2572, syn_chk[5], n_2564);
  and RC_i_851 (n_2573, n_2563, syn_chk[4]);
  or RC_i_852 (n_2574, n_2572, n_2573);
  and RC_i_853 (n_2575, n_2574, n_2566);
  or RC_i_854 (n_2581, syn_chk[6], n_2575);
  and RC_i_855 (n_2576, syn_chk[6], n_2563);
  and RC_i_856 (n_2577, syn_chk[6], n_2564);
  or RC_i_857 (n_2578, n_2576, n_2577);
  and RC_i_858 (n_2579, n_2578, n_2566);
  and RC_i_859 (n_2580, n_2565, syn_chk[3]);
  or RC_i_860 (n_2583, n_2579, n_2580);
  not RC_i_861 (n_2582, syn_chk[2]);
  and RC_i_862 (n_2584, n_2581, n_2582);
  or RC_i_863 (n_2596, n_2583, n_2584);
  and RC_i_864 (n_2585, n_2560, n_2563);
  and RC_i_865 (n_2586, n_2585, n_2564);
  and RC_i_866 (n_2587, n_2561, syn_chk[4]);
  or RC_i_867 (n_2588, n_2586, n_2587);
  and RC_i_868 (n_2589, n_2560, syn_chk[3]);
  or RC_i_869 (n_2593, n_2588, n_2589);
  and RC_i_870 (n_2590, n_2576, n_2564);
  and RC_i_871 (n_2591, syn_chk[6], n_2566);
  or RC_i_872 (n_2592, n_2590, n_2591);
  and RC_i_873 (n_2594, n_2592, n_2582);
  and RC_i_874 (n_2595, n_2593, syn_chk[2]);
  not RC_i_875 (n_2597, syn_chk[1]);
  and RC_i_876 (n_2598, n_2596, n_2597);
  and RC_i_877 (n_2600, n_2599, syn_chk[1]);
  and RC_i_878 (n_2601, n_2567, n_2566);
  and RC_i_879 (n_2602, n_2586, syn_chk[3]);
  or RC_i_880 (n_2606, n_2601, n_2602);
  and RC_i_881 (n_2603, syn_chk[6], syn_chk[5]);
  and RC_i_882 (n_2604, syn_chk[6], syn_chk[4]);
  or RC_i_883 (n_2605, n_2603, n_2604);
  and RC_i_884 (n_2607, n_2605, syn_chk[3]);
  and RC_i_885 (n_2608, n_2606, n_2582);
  or RC_i_886 (n_2609, n_2607, n_2608);
  and RC_i_887 (n_2610, syn_chk[6], syn_chk[2]);
  or RC_i_888 (n_2626, n_2609, n_2610);
  and RC_i_889 (n_2611, n_2561, n_2564);
  and RC_i_890 (n_2612, n_2585, syn_chk[4]);
  or RC_i_891 (n_2613, n_2611, n_2612);
  and RC_i_892 (n_2616, n_2613, n_2566);
  and RC_i_893 (n_2614, n_2586, n_2566);
  or RC_i_894 (n_2615, n_2614, n_2569);
  and RC_i_895 (n_2617, n_2615, n_2582);
  and RC_i_896 (n_2618, n_2616, syn_chk[2]);
  or RC_i_897 (n_2624, n_2617, n_2618);
  and RC_i_898 (n_2619, n_2603, syn_chk[4]);
  and RC_i_899 (n_2620, syn_chk[6], syn_chk[3]);
  or RC_i_900 (n_2621, n_2619, n_2620);
  and RC_i_901 (n_2622, n_2587, n_2582);
  and RC_i_902 (n_2623, n_2621, syn_chk[2]);
  and RC_i_903 (n_2625, n_2624, n_2597);
  and RC_i_904 (n_2627, n_2626, syn_chk[1]);
  or RC_i_905 (n_2628, syn_chk[5], syn_chk[4]);
  and RC_i_906 (n_2629, n_2628, syn_chk[3]);
  or RC_i_907 (n_2632, n_2568, n_2629);
  and RC_i_908 (n_2630, syn_chk[5], syn_chk[4]);
  and RC_i_909 (n_2631, n_2590, n_2566);
  or RC_i_910 (n_2633, n_2630, n_2631);
  and RC_i_911 (n_2634, n_2632, syn_chk[2]);
  or RC_i_912 (n_2647, n_2633, n_2634);
  and RC_i_913 (n_2635, n_2603, n_2564);
  and RC_i_914 (n_2636, n_2576, syn_chk[4]);
  or RC_i_915 (n_2637, n_2635, n_2636);
  and RC_i_916 (n_2638, n_2637, n_2566);
  and RC_i_917 (n_2639, n_2590, syn_chk[3]);
  and RC_i_918 (n_2640, n_2638, n_2582);
  or RC_i_919 (n_2641, n_2639, n_2640);
  and RC_i_920 (n_2642, n_2580, syn_chk[2]);
  or RC_i_921 (n_2645, n_2641, n_2642);
  and RC_i_922 (n_2643, n_2630, syn_chk[3]);
  and RC_i_923 (n_2644, n_2631, syn_chk[2]);
  and RC_i_924 (n_2646, n_2645, n_2597);
  and RC_i_925 (n_2648, n_2647, syn_chk[1]);
  not RC_i_926 (n_2650, syn_chk[0]);
  and RC_i_927 (n_2651, n_2649, n_2650);
  and RC_i_928 (n_2653, n_2652, syn_chk[0]);
  and RC_i_929 (n_2654, n_2636, n_2566);
  and RC_i_930 (n_2655, n_2654, syn_chk[2]);
  and RC_i_931 (n_2656, n_2655, n_2597);
  and RC_i_932 (n_1444, n_2656, n_2650);
  and RC_i_933 (n_2657, n_2655, syn_chk[1]);
  and RC_i_934 (n_1445, n_2657, syn_chk[0]);
  and RC_i_935 (n_2658, n_2636, syn_chk[3]);
  and RC_i_936 (n_2659, n_2658, n_2582);
  and RC_i_937 (n_2660, n_2659, n_2597);
  and RC_i_938 (n_1446, n_2660, n_2650);
  and RC_i_939 (n_2661, n_2659, syn_chk[1]);
  and RC_i_940 (n_1447, n_2661, syn_chk[0]);
  and RC_i_941 (n_2662, n_2611, n_2566);
  and RC_i_942 (n_2663, n_2662, n_2582);
  and RC_i_943 (n_2664, n_2663, syn_chk[1]);
  and RC_i_944 (n_1449, n_2664, syn_chk[0]);
  and RC_i_945 (n_2665, n_2662, syn_chk[2]);
  and RC_i_946 (n_2666, n_2665, n_2597);
  and RC_i_947 (n_1450, n_2666, syn_chk[0]);
  and RC_i_948 (n_2667, n_2665, syn_chk[1]);
  and RC_i_949 (n_1451, n_2667, n_2650);
  and RC_i_950 (n_2668, n_2611, syn_chk[3]);
  and RC_i_951 (n_2669, n_2668, n_2582);
  and RC_i_952 (n_2670, n_2669, n_2597);
  and RC_i_953 (n_1452, n_2670, syn_chk[0]);
  and RC_i_954 (n_2671, n_2669, syn_chk[1]);
  and RC_i_955 (n_1453, n_2671, n_2650);
  and RC_i_956 (n_2672, n_2587, n_2566);
  and RC_i_957 (n_2673, n_2602, n_2582);
  and RC_i_958 (n_2674, n_2673, syn_chk[1]);
  and RC_i_959 (n_1458, n_2674, syn_chk[0]);
  and RC_i_960 (n_2675, n_2612, n_2566);
  and RC_i_961 (n_2676, n_2675, n_2582);
  and RC_i_962 (n_2677, n_2676, syn_chk[1]);
  and RC_i_963 (n_1459, n_2677, syn_chk[0]);
  and RC_i_964 (n_2678, n_2675, syn_chk[2]);
  and RC_i_965 (n_2679, n_2678, n_2597);
  and RC_i_966 (n_1460, n_2679, syn_chk[0]);
  and RC_i_967 (n_2680, n_2678, syn_chk[1]);
  and RC_i_968 (n_1461, n_2680, n_2650);
  and RC_i_969 (n_2681, n_2612, syn_chk[3]);
  and RC_i_970 (n_2682, n_2681, n_2582);
  and RC_i_971 (n_2683, n_2682, n_2597);
  and RC_i_972 (n_1462, n_2683, syn_chk[0]);
  and RC_i_973 (n_2684, n_2682, syn_chk[1]);
  and RC_i_974 (n_1463, n_2684, n_2650);
  and RC_i_975 (n_2685, n_2635, n_2566);
  and RC_i_976 (n_2686, n_2685, syn_chk[2]);
  and RC_i_977 (n_2687, n_2686, n_2597);
  and RC_i_978 (n_1466, n_2687, n_2650);
  and RC_i_979 (n_2688, n_2686, syn_chk[1]);
  and RC_i_980 (n_1467, n_2688, syn_chk[0]);
  and RC_i_981 (n_2689, n_2635, syn_chk[3]);
  and RC_i_982 (n_2690, n_2689, n_2582);
  and RC_i_983 (n_2691, n_2690, n_2597);
  and RC_i_984 (n_1468, n_2691, n_2650);
  and RC_i_985 (n_2692, n_2690, syn_chk[1]);
  and RC_i_986 (n_1469, n_2692, syn_chk[0]);
  and RC_i_987 (n_2693, n_2619, n_2566);
  and RC_i_988 (n_2694, n_2614, n_2582);
  and RC_i_989 (n_2695, n_2694, n_2597);
  and RC_i_990 (n_1473, n_2695, syn_chk[0]);
  and RC_i_991 (n_2696, n_2694, syn_chk[1]);
  and RC_i_992 (n_1474, n_2696, n_2650);
  and RC_i_993 (n_2697, n_2673, n_2597);
  and RC_i_994 (n_1476, n_2697, n_2650);
  and RC_i_995 (n_2698, n_2676, n_2597);
  and RC_i_996 (n_1477, n_2698, n_2650);
  and RC_i_997 (n_2699, n_2663, n_2597);
  and RC_i_998 (n_1478, n_2699, n_2650);
  and RC_i_999 (n_1479, n_2631, n_2582, n_2597, n_2650);
  and RC_i_1000 (n_1475, n_2614, syn_chk[2], n_2597, n_2650);
  and RC_i_1001 (n_1472, n_2693, syn_chk[2], n_2597, syn_chk[0]);
  and RC_i_1002 (n_1471, n_2693, n_2582, n_2597, n_2650);
  and RC_i_1003 (n_1470, n_2689, syn_chk[2], n_2597, syn_chk[0]);
  and RC_i_1004 (n_1465, n_2685, n_2582, syn_chk[1], n_2650);
  and RC_i_1005 (n_1464, n_2681, syn_chk[2], n_2597, n_2650);
  and RC_i_1006 (n_1457, n_2602, syn_chk[2], syn_chk[1], n_2650);
  and RC_i_1007 (n_1456, n_2672, syn_chk[2], n_2597, n_2650);
  and RC_i_1008 (n_1455, n_2672, n_2582, n_2597, syn_chk[0]);
  and RC_i_1009 (n_1454, n_2668, syn_chk[2], n_2597, n_2650);
  and RC_i_1010 (n_1448, n_2658, syn_chk[2], n_2597, syn_chk[0]);
  and RC_i_1011 (n_1443, n_2654, n_2582, syn_chk[1], n_2650);
  and RC_i_1012 (n_1442, n_2639, n_2582, syn_chk[1], n_2650);
  and RC_i_1013 (n_1441, n_2639, syn_chk[2], syn_chk[1], syn_chk[0]);
  or RC_i_1014 (n_2700, n_2643, n_2644);
  or RC_i_1015 (n_2701, n_2646, n_2648);
  or RC_i_1016 (n_1551, n_2651, n_2653, n_2700, n_2701);
  or RC_i_1017 (n_2649, n_2622, n_2623, n_2625, n_2627);
  or RC_i_1018 (n_2652, n_2594, n_2595, n_2598, n_2600);
  not RC_i_1021 (n_1439, gen);
  not RC_i_1023 (n_1438, n_2005);
  not RC_i_1024 (syn[2], n_1725);
  not RC_i_1025 (syn[3], n_1782);
  xor RC_i_1026 (n_2703, datain[15], datain[11]);
  xor RC_i_1027 (n_2704, n_2070, datain[24]);
  xor RC_i_1028 (n_2705, datain[12], datain[10]);
  xor RC_i_1029 (n_2706, datain[13], n_2449);
  xor RC_i_1030 (n_2707, datain[8], datain[9]);
  xor RC_i_1031 (n_2708, datain[31], n_2703);
  xor RC_i_1032 (n_2709, n_2704, n_2705);
  xor RC_i_1033 (n_2710, n_2706, n_2707);
  xor RC_i_1034 (n_2711, n_2708, n_2709);
  xor RC_i_1035 (syn[5], n_2710, n_2711);
  xor RC_i_1036 (n_2712, datain[23], datain[15]);
  xor RC_i_1037 (n_2713, datain[3], n_2346);
  xor RC_i_1038 (n_2714, datain[18], datain[4]);
  xor RC_i_1039 (n_2715, datain[14], datain[30]);
  xor RC_i_1040 (n_2716, datain[6], datain[19]);
  xor RC_i_1041 (n_2717, datain[7], datain[31]);
  xor RC_i_1042 (n_2718, datain[20], datain[21]);
  xor RC_i_1043 (n_2719, datain[22], n_2712);
  xor RC_i_1044 (n_2720, n_2713, n_2714);
  xor RC_i_1045 (n_2721, n_2715, n_2716);
  xor RC_i_1046 (n_2722, n_2717, n_2718);
  xor RC_i_1047 (n_2723, n_2719, n_2720);
  xor RC_i_1048 (n_2724, n_2721, n_2722);
  xor RC_i_1049 (syn[4], n_2723, n_2724);
  xor RC_i_1050 (n_2725, n_2149, datain[10]);
  xor RC_i_1051 (n_2726, datain[18], datain[20]);
  xor RC_i_1052 (n_2727, datain[8], n_2138);
  xor RC_i_1053 (n_2728, datain[26], datain[6]);
  xor RC_i_1054 (n_2729, datain[24], datain[22]);
  xor RC_i_1055 (n_2730, datain[2], datain[17]);
  xor RC_i_1056 (n_2731, datain[4], datain[16]);
  xor RC_i_1057 (n_2732, n_2725, n_2726);
  xor RC_i_1058 (n_2733, n_2727, n_2728);
  xor RC_i_1059 (n_2734, n_2729, n_2730);
  xor RC_i_1060 (n_2735, n_2731, n_2732);
  xor RC_i_1061 (n_2736, n_2733, n_2734);
  xor RC_i_1062 (syn[1], n_2735, n_2736);
  xor RC_i_1063 (n_2737, n_2149, datain[21]);
  xor RC_i_1064 (n_2738, datain[7], n_2138);
  xor RC_i_1065 (n_2739, datain[6], datain[13]);
  xor RC_i_1066 (n_2740, datain[29], datain[27]);
  xor RC_i_1067 (n_2741, datain[23], datain[22]);
  xor RC_i_1068 (n_2742, datain[17], datain[5]);
  xor RC_i_1069 (n_2743, datain[11], datain[16]);
  xor RC_i_1070 (n_2744, n_2737, n_2738);
  xor RC_i_1071 (n_2745, n_2739, n_2740);
  xor RC_i_1072 (n_2746, n_2741, n_2742);
  xor RC_i_1073 (n_2747, n_2743, n_2744);
  xor RC_i_1074 (n_2748, n_2745, n_2746);
  xor RC_i_1075 (n_1782, n_2747, n_2748);
  xor RC_i_1076 (n_2749, datain[25], datain[10]);
  xor RC_i_1077 (n_2750, datain[3], datain[7]);
  xor RC_i_1078 (n_2751, datain[19], datain[20]);
  xor RC_i_1079 (n_2752, datain[0], datain[26]);
  xor RC_i_1080 (n_2753, datain[13], datain[29]);
  xor RC_i_1081 (n_2754, datain[23], n_2044);
  xor RC_i_1082 (n_2755, datain[31], datain[16]);
  xor RC_i_1083 (n_2756, datain[15], n_2749);
  xor RC_i_1084 (n_2757, n_2750, n_2751);
  xor RC_i_1085 (n_2758, n_2752, n_2753);
  xor RC_i_1086 (n_2759, n_2754, n_2755);
  xor RC_i_1087 (n_2760, n_2756, n_2757);
  xor RC_i_1088 (n_2761, n_2758, n_2759);
  xor RC_i_1089 (n_1725, n_2760, n_2761);
endmodule

