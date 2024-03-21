# Définir le compilateur VHDL
VHDL_COMPILER=ghdl

# Définir les fichiers VHDL à compiler
VHDL_FILES=\
combi.vhd \
mem.vhd \
proc.vhd \
reg_bank.vhd \
etages.vhd \
test_fetch.vhd

# Cible par défaut
all: test

# Règle pour construire le fichier de test
test:
	$(VHDL_COMPILER) -a $(VHDL_FILES)
	$(VHDL_COMPILER) -e test_fetch
	$(VHDL_COMPILER) -r test_fetch --vcd=test_fetch.vcd

gtkwave:
	gtkwave test_fetch.vcd

# Règle pour nettoyer les fichiers générés
clean:
	rm -f *.o *.vcd work-obj93.cf
