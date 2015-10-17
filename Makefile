JADE = ./node_modules/.bin/jade
STYLUS = ./node_modules/.bin/stylus
DEST = ./build
SRC = ./src
PORT = 3000

all: jade styl live

before:
	@mkdir -p $(DEST)

jade: before
	$(JADE) $(SRC) --out $(DEST)

styl: before
	$(STYLUS) $(SRC) --out $(DEST)

live: before
	browserify -t [ @jigsaw/anyify --ls [ livescript?compile ] ] src/index.ls > $(DEST)/index.js

serve:
	@./node_modules/.bin/static -p $(PORT) $(DEST)

.PHONY: before jade styl live serve
