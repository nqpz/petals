.PHONY: all clean

all:
	$(MAKE) -C inorganic

clean:
	$(MAKE) clean -C inorganic
