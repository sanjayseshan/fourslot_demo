TARGET = $(OFS_ASP_ROOT):ofs_iseries-dk_usm_noc

MHZ = 600MHz

EARLY = -fsycl-link=early 

SEED = 0

FLAGS = -fsycl -fPIC -fintelfpga -Xstarget=$(TARGET) -shared -Xshardware -Xsclock=$(MHZ) -Xsseed=$(SEED)

COMMON = -I ./include

s0:
	icpx $(FLAGS) $(COMMON) slot0/fourslot_iopipes_stream.cpp -o slot0/fourslot_iopipes_stream.so
s0b:
	icpx $(FLAGS) $(COMMON) slot0b/fourslot_iopipes_stream.cpp -o slot0b/fourslot_iopipes_stream.so
s1:
	icpx $(FLAGS) $(COMMON) slot1/fourslot_iopipes_stream.cpp -o slot1/fourslot_iopipes_stream.so
s2:
	icpx $(FLAGS) $(COMMON) slot2/fourslot_iopipes_sink.cpp -o slot2/fourslot_iopipes_sink.so
s3:
	icpx $(FLAGS) $(COMMON) slot3/fourslot_iopipes_src.cpp    -o slot3/fourslot_iopipes_src.so

s0_sim:
	icpx -fsycl -fPIC -shared -DFPGA_EMULATOR=1 $(COMMON) slot0/fourslot_iopipes_stream.cpp -o slot0/fourslot_iopipes_stream_sim.so
s0b_sim:
	icpx -fsycl -fPIC -shared -DFPGA_EMULATOR=1 $(COMMON) slot0b/fourslot_iopipes_stream.cpp -o slot0b/fourslot_iopipes_stream_sim.so
s1_sim:
	icpx -fsycl -fPIC -shared -DFPGA_EMULATOR=1 $(COMMON) slot1/fourslot_iopipes_stream.cpp -o slot1/fourslot_iopipes_stream_sim.so
s2_sim:
	icpx -fsycl -fPIC -shared -DFPGA_EMULATOR=1 $(COMMON) slot2/fourslot_iopipes_sink.cpp -o slot2/fourslot_iopipes_sink_sim.so
s3_sim:
	icpx -fsycl -fPIC -shared -DFPGA_EMULATOR=1 $(COMMON) slot3/fourslot_iopipes_src.cpp    -o slot3/fourslot_iopipes_src_sim.so


s0_early:
	icpx $(FLAGS) $(EARLY) $(COMMON) slot0/fourslot_iopipes_stream.cpp -o slot0/fourslot_iopipes_stream_early.so
s0b_early:
	icpx $(FLAGS) $(EARLY) $(COMMON) slot0b/fourslot_iopipes_stream.cpp -o slot0b/fourslot_iopipes_stream_early.so
s1_early:
	icpx $(FLAGS) $(EARLY) $(COMMON) slot1/fourslot_iopipes_stream.cpp -o slot1/fourslot_iopipes_stream_early.so
s2_early:
	icpx $(FLAGS) $(EARLY) $(COMMON) slot2/fourslot_iopipes_sink.cpp -o slot2/fourslot_iopipes_sink_early.so
s3_early:
	icpx $(FLAGS) $(EARLY) $(COMMON) slot3/fourslot_iopipes_src.cpp    -o slot3/fourslot_iopipes_src_early.so

all_early:
	make s0_early
	make s0b_early
	make s1_early
	make s2_early
	make s3_early

main: main.cpp
	icpx -fsycl -o main main.cpp

main_sim: main_sim.cpp
	icpx -fsycl -o main_sim main_sim.cpp

clean: 
	rm -rf slot0/*.so*
	rm -rf slot0b/*.so*
	rm -rf slot1/*.so*
	rm -rf slot2/*.so*
	rm -rf slot3/*.so*
