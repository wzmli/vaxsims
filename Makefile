current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt README.md"

######################################################################

Sources += $(wildcard *.R) README.md

######################################################################

## local.mk needs to point to your Dropbox
Sources += $(wildcard *.local)
## jd.lmk:
%.lmk:
	ln -fs $*.local local.mk

-include local.mk

######################################################################

autopipeR = defined

######################################################################

vaxsim.Rout: vaxsim.R
	$(pipeR)

vaxfit.Rout: vaxfit.R vaxsim.rds
	$(pipeR)


######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

-include makestuff/pandoc.mk
-include makestuff/pipeR.mk
-include makestuff/chains.mk

-include makestuff/git.mk
-include makestuff/visual.mk