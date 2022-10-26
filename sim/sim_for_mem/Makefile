#compile	sim	   verdi	clean

compile:
		@echo "Start to compile"
		vcs -full64 -f run.f -debug_access+all +lint=TFIPC-L -l com.log 
		@echo "End of compile"

sim:
	@echo "Start to simulation"
	./simv -l sim.log
	@echo "End of run simulation"

verdi:
	@echo "Start to launch verdi"
	verdi -f run.f -ssf mem32x8_test.fsdb -sswr signal.rc &

clean:
	rm -rf *simv *.vpd *.simdb *.rc *.csrc *.daidir *.log *DVEfiles *key *fsdb *csrc *Log *conf

#/usr/Synopsys/verdi/R-2020.12-SP1/share/PLI/VCS/LINUX64/pli.a

