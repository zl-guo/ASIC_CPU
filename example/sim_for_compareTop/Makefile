#compile	sim	   verdi	clean

compile:
		@echo "Start to compile"
		vcs -full64 -f run.f -debug_access+all +lint=TFIPC-L -l com.log 
		@echo "End of compile"

sim:
	@echo "Start to simulation"
	./simv +fsdb+delta -l sim.log
	@echo "End of run simulation"

verdi:
	@echo "Start to launch verdi"
	verdi -f run.f -ssf compareTop.fsdb -sswr signal.rc &

clean:
	rm -rf *simv *.vpd *.simdb *.rc *csrc *.daidir *.log *DVEfiles *key *fsdb *Log *conf *.dump

#/usr/Synopsys/verdi/R-2020.12-SP1/share/PLI/VCS/LINUX64/pli.a


