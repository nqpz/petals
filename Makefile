.PHONY: all clean

all:
	$(MAKE) -C petals
	$(MAKE) -C inorganic

clean:
	$(MAKE) clean -C petals
	$(MAKE) clean -C inorganic
