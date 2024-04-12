# Définir le compilateur VHDL
VHDL_COMPILER=ghdl

# Définir les fichiers VHDL à compiler
VHDL_FILES=\
combi.vhd \
mem.vhd \
reg_bank.vhd \
etages.vhd \
decodeur.vhd \
condition.vhd \
proc_tp2.vhd \
test_proc.vhd
# Cible par défaut
all: test

# Règle pour construire le fichier de test
test:
	$(VHDL_COMPILER) -a $(VHDL_FILES)
	$(VHDL_COMPILER) -e test_proc
	$(VHDL_COMPILER) -r test_proc --vcd=test_proc.vcd

gtkwave:
	gtkwave test_proc.vcd

# Règle pour nettoyer les fichiers générés
clean:
	rm -f *.o *.vcd work-obj93.cf
