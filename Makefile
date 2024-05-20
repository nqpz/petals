.PHONY: all clean

all:
	$(MAKE) -C petals

clean:
	$(MAKE) clean -C petals
