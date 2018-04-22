## This file is a general .xdc for the PYNQ-Z1 board Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal 125 MHz

#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sysclk }];

##Switches

#set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }]; #IO_L7N_T1_AD2N_35 Sch=sw[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L7P_T1_AD2P_35 Sch=sw[1]

##RGB LEDs

#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { led4_b }]; #IO_L22N_T3_AD7N_35 Sch=led4_b
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { led4_g }]; #IO_L16P_T2_35 Sch=led4_g
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { led4_r }]; #IO_L21P_T3_DQS_AD14P_35 Sch=led4_r
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { led5_b }]; #IO_0_35 Sch=led5_b
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { led5_g }]; #IO_L22P_T3_AD7P_35 Sch=led5_g
#set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { led5_r }]; #IO_L23N_T3_35 Sch=led5_r

##LEDs

#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=led[0]
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=led[1]
#set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=led[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L23P_T3_35 Sch=led[3]

##Buttons

#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L4P_T0_35 Sch=btn[0]
#set_property -dict { PACKAGE_PIN D20   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L4N_T0_35 Sch=btn[1]
#set_property -dict { PACKAGE_PIN L20   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L9N_T1_DQS_AD3N_35 Sch=btn[2]
#set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L9P_T1_DQS_AD3P_35 Sch=btn[3]

##Pmod Header JA

#set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L17P_T2_34 Sch=ja_p[1]
#set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L17N_T2_34 Sch=ja_n[1]
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L7P_T1_34 Sch=ja_p[2]
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L7N_T1_34 Sch=ja_n[2]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L12P_T1_MRCC_34 Sch=ja_p[3]
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L12N_T1_MRCC_34 Sch=ja_n[3]
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L22P_T3_34 Sch=ja_p[4]
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L22N_T3_34 Sch=ja_n[4]

##Pmod Header JB

#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { jb[0] }]; #IO_L8P_T1_34 Sch=jb_p[1]
#set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { jb[1] }]; #IO_L8N_T1_34 Sch=jb_n[1]
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { jb[2] }]; #IO_L1P_T0_34 Sch=jb_p[2]
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L1N_T0_34 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L18P_T2_34 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L18N_T2_34 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L4P_T0_34 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L4N_T0_34 Sch=jb_n[4]

##Audio Out

#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { aud_pwm }]; #IO_L20N_T3_34 Sch=aud_pwm
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { aud_sd }]; #IO_L20P_T3_34 Sch=aud_sd

##Mic input

#set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { m_clk }]; #IO_L6N_T0_VREF_35 Sch=m_clk
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { m_data }]; #IO_L16N_T2_35 Sch=m_data

##ChipKit Single Ended Analog Inputs
##NOTE: The ck_an_p pins can be used as single ended analog inputs with voltages from 0-3.3V (Chipkit Analog pins A0-A5).
##      These signals should only be connected to the XADC core. When using these pins as digital I/O, use pins ck_io[14-19].

#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[0] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=ck_an_n[0]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[0] }]; #IO_L3P_T0_DQS_AD1P_35 Sch=ck_an_p[0]
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[1] }]; #IO_L5N_T0_AD9N_35 Sch=ck_an_n[1]
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[1] }]; #IO_L5P_T0_AD9P_35 Sch=ck_an_p[1]
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[2] }]; #IO_L20N_T3_AD6N_35 Sch=ck_an_n[2]
#set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[2] }]; #IO_L20P_T3_AD6P_35 Sch=ck_an_p[2]
#set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[3] }]; #IO_L24N_T3_AD15N_35 Sch=ck_an_n[3]
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[3] }]; #IO_L24P_T3_AD15P_35 Sch=ck_an_p[3]
#set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[4] }]; #IO_L17N_T2_AD5N_35 Sch=ck_an_n[4]
#set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[4] }]; #IO_L17P_T2_AD5P_35 Sch=ck_an_p[4]
#set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 } [get_ports { ck_an_n[5] }]; #IO_L18N_T2_AD13N_35 Sch=ck_an_n[5]
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { ck_an_p[5] }]; #IO_L18P_T2_AD13P_35 Sch=ck_an_p[5]

##ChipKit Digital I/O Low

#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { ck_io[0] }]; #IO_L5P_T0_34 Sch=ck_io[0]
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { ck_io[1] }]; #IO_L2N_T0_34 Sch=ck_io[1]
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { ck_io[2] }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=ck_io[2]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { ck_io[3] }]; #IO_L3N_T0_DQS_34 Sch=ck_io[3]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { ck_io[4] }]; #IO_L10P_T1_34 Sch=ck_io[4]
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { ck_io[5] }]; #IO_L5N_T0_34 Sch=ck_io[5]
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ck_io[6] }]; #IO_L19P_T3_34 Sch=ck_io[6]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[7] }]; #IO_L9N_T1_DQS_34 Sch=ck_io[7]
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[8] }]; #IO_L21P_T3_DQS_34 Sch=ck_io[8]
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { ck_io[9] }]; #IO_L21N_T3_DQS_34 Sch=ck_io[9]
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { ck_io[10] }]; #IO_L9P_T1_DQS_34 Sch=ck_io[10]
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[11] }]; #IO_L19N_T3_VREF_34 Sch=ck_io[11]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ck_io[12] }]; #IO_L23N_T3_34 Sch=ck_io[12]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ck_io[13] }]; #IO_L23P_T3_34 Sch=ck_io[13]

##ChipKit Digital I/O On Outer Analog Header
##NOTE: These pins should be used when using the analog header signals A0-A5 as digital I/O (Chipkit digital pins 14-19)

#set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { ck_io[14] }]; #IO_L18N_T2_13 Sch=ck_a[0]
#set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { ck_io[15] }]; #IO_L20P_T3_13 Sch=ck_a[1]
#set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { ck_io[16] }]; #IO_L18P_T2_13 Sch=ck_a[2]
#set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { ck_io[17] }]; #IO_L21P_T3_DQS_13 Sch=ck_a[3]
#set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { ck_io[18] }]; #IO_L19P_T3_13 Sch=ck_a[4]
#set_property -dict { PACKAGE_PIN U10   IOSTANDARD LVCMOS33 } [get_ports { ck_io[19] }]; #IO_L12N_T1_MRCC_13 Sch=ck_a[5]

##ChipKit Digital I/O On Inner Analog Header
##NOTE: These pins will need to be connected to the XADC core when used as differential analog inputs (Chipkit analog pins A6-A11)

#set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { ck_io[20] }]; #IO_L1N_T0_AD0N_35 Sch=ad_n[0]
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { ck_io[21] }]; #IO_L1P_T0_AD0P_35 Sch=ad_p[0]
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { ck_io[22] }]; #IO_L15N_T2_DQS_AD12N_35 Sch=ad_n[12]
#set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { ck_io[23] }]; #IO_L15P_T2_DQS_AD12P_35 Sch=ad_p[12]
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { ck_io[24] }]; #IO_L2N_T0_AD8N_35 Sch=ad_n[8]
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { ck_io[25] }]; #IO_L2P_T0_AD8P_35 Sch=ad_p[8]

##ChipKit Digital I/O High

#set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { ck_io[26] }]; #IO_L19N_T3_VREF_13 Sch=ck_io[26]
#set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { ck_io[27] }]; #IO_L6N_T0_VREF_13 Sch=ck_io[27]
#set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { ck_io[28] }]; #IO_L22P_T3_13 Sch=ck_io[28]
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[29] }]; #IO_L11P_T1_SRCC_13 Sch=ck_io[29]
#set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[30] }]; #IO_L11N_T1_SRCC_13 Sch=ck_io[30]
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { ck_io[31] }]; #IO_L17N_T2_13 Sch=ck_io[31]
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { ck_io[32] }]; #IO_L15P_T2_DQS_13 Sch=ck_io[32]
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { ck_io[33] }]; #IO_L21N_T3_DQS_13 Sch=ck_io[33]
#set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { ck_io[34] }]; #IO_L16P_T2_13 Sch=ck_io[34]
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { ck_io[35] }]; #IO_L22N_T3_13 Sch=ck_io[35]
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { ck_io[36] }]; #IO_L13N_T2_MRCC_13 Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { ck_io[37] }]; #IO_L13P_T2_MRCC_13 Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { ck_io[38] }]; #IO_L15N_T2_DQS_13 Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { ck_io[39] }]; #IO_L14N_T2_SRCC_13 Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { ck_io[40] }]; #IO_L16N_T2_13 Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { ck_io[41] }]; #IO_L14P_T2_SRCC_13 Sch=ck_io[41]
#set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33 } [get_ports { ck_io[42] }]; #IO_L20N_T3_13 Sch=ck_ioa

## ChipKit SPI

#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { ck_miso }]; #IO_L10N_T1_34 Sch=ck_miso
#set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { ck_mosi }]; #IO_L2P_T0_34 Sch=ck_mosi
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { ck_sck }]; #IO_L19P_T3_35 Sch=ck_sck
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { ck_ss }]; #IO_L6P_T0_35 Sch=ck_ss

## ChipKit I2C

#set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { ck_scl }]; #IO_L24N_T3_34 Sch=ck_scl
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { ck_sda }]; #IO_L24P_T3_34 Sch=ck_sda

##HDMI Rx

#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L13N_T2_MRCC_35 Sch=hdmi_rx_cec
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L13N_T2_MRCC_34 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L13P_T2_MRCC_34 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[0] }]; #IO_L16N_T2_34 Sch=hdmi_rx_d_n[0]
#set_property -dict { PACKAGE_PIN V20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[0] }]; #IO_L16P_T2_34 Sch=hdmi_rx_d_p[0]
#set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[1] }]; #IO_L15N_T2_DQS_34 Sch=hdmi_rx_d_n[1]
#set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[1] }]; #IO_L15P_T2_DQS_34 Sch=hdmi_rx_d_p[1]
#set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_n[2] }]; #IO_L14N_T2_SRCC_34 Sch=hdmi_rx_d_n[2]
#set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_d_p[2] }]; #IO_L14P_T2_SRCC_34 Sch=hdmi_rx_d_p[2]
#set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_hpd }]; #IO_25_34 Sch=hdmi_rx_hpd
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L11P_T1_SRCC_34 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_rx_sda

##HDMI Tx

#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L19N_T3_VREF_35 Sch=hdmi_tx_cec
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_n }]; #IO_L11N_T1_SRCC_35 Sch=hdmi_tx_clk_n
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_clk_p }]; #IO_L11P_T1_SRCC_35 Sch=hdmi_tx_clk_p
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[0] }]; #IO_L12N_T1_MRCC_35 Sch=hdmi_tx_d_n[0]
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[0] }]; #IO_L12P_T1_MRCC_35 Sch=hdmi_tx_d_p[0]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[1] }]; #IO_L10N_T1_AD11N_35 Sch=hdmi_tx_d_n[1]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[1] }]; #IO_L10P_T1_AD11P_35 Sch=hdmi_tx_d_p[1]
#set_property -dict { PACKAGE_PIN H18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_n[2] }]; #IO_L14N_T2_AD4N_SRCC_35 Sch=hdmi_tx_d_n[2]
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD TMDS_33  } [get_ports { hdmi_tx_d_p[2] }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=hdmi_tx_d_p[2]
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_hpdn }]; #IO_0_34 Sch=hdmi_tx_hpdn
#set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_scl }]; #IO_L8P_T1_AD10P_35 Sch=hdmi_tx_scl
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_sda }]; #IO_L8N_T1_AD10N_35 Sch=hdmi_tx_sda

##Crypto SDA

#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_25_35 Sch=crypto_sda

#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 1 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list procsys_i/ps7/inst/FCLK_CLK0]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 64 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[0]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[1]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[2]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[3]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[4]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[5]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[6]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[7]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[8]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[9]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[10]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[11]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[12]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[13]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[14]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[15]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[16]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[17]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[18]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[19]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[20]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[21]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[22]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[23]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[24]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[25]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[26]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[27]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[28]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[29]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[30]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[31]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[32]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[33]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[34]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[35]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[36]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[37]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[38]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[39]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[40]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[41]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[42]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[43]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[44]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[45]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[46]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[47]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[48]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[49]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[50]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[51]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[52]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[53]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[54]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[55]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[56]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[57]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[58]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[59]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[60]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[61]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[62]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_ARADDR[63]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 64 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[0]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[1]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[2]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[3]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[4]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[5]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[6]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[7]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[8]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[9]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[10]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[11]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[12]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[13]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[14]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[15]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[16]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[17]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[18]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[19]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[20]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[21]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[22]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[23]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[24]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[25]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[26]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[27]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[28]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[29]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[30]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[31]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[32]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[33]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[34]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[35]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[36]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[37]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[38]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[39]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[40]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[41]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[42]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[43]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[44]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[45]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[46]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[47]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[48]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[49]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[50]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[51]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[52]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[53]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[54]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[55]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[56]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[57]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[58]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[59]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[60]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[61]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[62]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_WDATA[63]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#set_property port_width 64 [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[0]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[1]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[2]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[3]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[4]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[5]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[6]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[7]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[8]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[9]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[10]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[11]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[12]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[13]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[14]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[15]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[16]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[17]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[18]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[19]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[20]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[21]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[22]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[23]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[24]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[25]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[26]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[27]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[28]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[29]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[30]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[31]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[32]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[33]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[34]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[35]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[36]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[37]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[38]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[39]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[40]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[41]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[42]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[43]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[44]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[45]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[46]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[47]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[48]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[49]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[50]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[51]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[52]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[53]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[54]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[55]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[56]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[57]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[58]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[59]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[60]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[61]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[62]} {procsys_i/BlackBoxJam_0_m_axi_hostmem_RDATA[63]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#set_property port_width 1 [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_ARREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
#set_property port_width 1 [get_debug_ports u_ila_0/probe4]
#connect_debug_port u_ila_0/probe4 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_ARVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
#set_property port_width 1 [get_debug_ports u_ila_0/probe5]
#connect_debug_port u_ila_0/probe5 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_AWREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
#set_property port_width 1 [get_debug_ports u_ila_0/probe6]
#connect_debug_port u_ila_0/probe6 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_AWVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
#set_property port_width 1 [get_debug_ports u_ila_0/probe7]
#connect_debug_port u_ila_0/probe7 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_BREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
#set_property port_width 1 [get_debug_ports u_ila_0/probe8]
#connect_debug_port u_ila_0/probe8 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_BVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
#set_property port_width 1 [get_debug_ports u_ila_0/probe9]
#connect_debug_port u_ila_0/probe9 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_RREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
#set_property port_width 1 [get_debug_ports u_ila_0/probe10]
#connect_debug_port u_ila_0/probe10 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_RVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
#set_property port_width 1 [get_debug_ports u_ila_0/probe11]
#connect_debug_port u_ila_0/probe11 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_WREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
#set_property port_width 1 [get_debug_ports u_ila_0/probe12]
#connect_debug_port u_ila_0/probe12 [get_nets [list procsys_i/BlackBoxJam_0_m_axi_hostmem_WVALID]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets u_ila_0_FCLK_CLK0]
