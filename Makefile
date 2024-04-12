# Définir le compilateur VHDL
VHDL_COMPILER=ghdl

# Définir les fichiers VHDL à compiler
VHDL_FILES=\
combi.vhd \
mem.vhd \
proc.vhd \
reg_bank.vhd \
etages.vhd \
decodeur.vhd \
condition.vhd \
test_cond.vhd \
proc_tp2.vhd

# Cible par défaut
all: test

# Règle pour construire le fichier de test
test:
	$(VHDL_COMPILER) -a $(VHDL_FILES)
	$(VHDL_COMPILER) -e test_cond
	$(VHDL_COMPILER) -r test_cond --vcd=test_cond.vcd

gtkwave:
	gtkwave test_cond.vcd

# Règle pour nettoyer les fichiers générés
clean:
	rm -f *.o *.vcd work-obj93.cf
