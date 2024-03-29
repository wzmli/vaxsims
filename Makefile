current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt README.md"

######################################################################

Sources += $(wildcard *.R *.md *.Rmd)

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

params.Rout: params.R
	$(pipeR)

simfuns.Rout: simfuns.R
	$(pipeR)

basic_sim.Rout: basic_sim.R simfuns.rda params.rda
	$(pipeR)

basic_fit.Rout: basic_fit.R basic_sim.rds params.rda
	$(pipeR)

doublevax.Rout: doublevax_params.R
	$(pipeR)

doublevax_sim.Rout: basic_sim.R doublevax_params.rda simfuns.rda
	$(pipeR)

doublevax_fit.Rout: doublevax_fit.R doublevax_sim.rds params.rda
	$(pipeR)

render.Rout: render.R vaxsim.Rmd
	$(pipeR)

Ignore += vaxsim.html
vaxsim.html: render.Rout vaxsim.Rmd

vaxsim_BMB.Rout: vaxsim_BMB.R
	$(pipeR)

######################################################################

### Makestuff

Sources += Makefile

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
