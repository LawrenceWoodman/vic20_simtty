simtty: simtty.d64

simtty.d64: simtty.prg
						@c1541 -format diskname,id d64 simtty.d64 -attach simtty.d64 -write simtty.prg simtty

simtty.prg: simtty.asm
					  @xa simtty.asm -osimtty.prg -lsimtty.lst

