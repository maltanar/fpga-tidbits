# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "NUM_MEM_PORTS" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.NUM_MEM_PORTS { PARAM_VALUE.NUM_MEM_PORTS } {
	# Procedure called to update NUM_MEM_PORTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_MEM_PORTS { PARAM_VALUE.NUM_MEM_PORTS } {
	# Procedure called to validate NUM_MEM_PORTS
	return true
}


