current_dir = $(shell pwd)


rtl:
	python3 ./peripheralScript.py
	sbt "runMain SoCNowDriver"

relocate: SoCNow.v PLL_8MHz.v clk_wiz_0_clk_wiz.v
	mv -t fpga/ SoCNow.v PLL_8MHz.v clk_wiz_0_clk_wiz.v

cleanup: relocate
	rm -f firrtl_black_box_resource_files.f SoCNow.fir SoCNow.anno.json

initmem:
	python3 insertmem.py

initmemBitstream:
	python3 initMemForBitstream.py

clean: 
	rm -rf $(current_dir)/fpga/build/ $(current_dir)/fpga/PLL_8MHz.v $(current_dir)/fpga/clk_wiz_0_clk_wiz.v
	rm $(current_dir)/fpga/SoCNow.v 
	

bitstream: clean rtl initmemBitstream cleanup $(current_dir)/fpga/SoCNow.v $(current_dir)/fpga/PLL_8MHz.v $(current_dir)/fpga/clk_wiz_0_clk_wiz.v
	TARGET="arty_35" $(MAKE) -C fpga

upload: $(current_dir)/fpga/build/arty_35/SoCNow.bit
	openocd -f ${INSTALL_DIR}/${FPGA_FAM}/conda/envs/${FPGA_FAM}/share/openocd/scripts/board/digilent_arty.cfg -c "init; pld load 0 $(current_dir)/fpga/build/arty_35/SoCNow.bit; exit"


