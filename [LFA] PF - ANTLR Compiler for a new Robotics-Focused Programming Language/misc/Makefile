# Change here! ------------------------------------------------

# By default we can look for a single Main class.
# If you have many list them here.

#MAIN_CLASS := $(subst .g4,Main.class,$(GRAMMARS_G4))
MAIN_CLASS := calcMainV.class calcMainL.class

MY_CLASSES := MyListener.class MyVisitor.class

# By default, for each grammar we produce listeners and visitors.
# Remove when unnecessary.

%Parser.java %Lexer.java: %.g4
	antlr4 $^ -listener -visitor

# Don't change below this line! -------------------------------

GRAMMARS_G4 := $(shell ls *.g4)
GRAMMARS := $(subst .g4,,$(GRAMMARS_G4))

LEXER_CLASS := $(subst .g4,Lexer.class,$(GRAMMARS_G4))
PARSER_CLASS := $(subst .g4,Parser.class,$(GRAMMARS_G4))
LISTENER_CLASS := $(subst .g4,Listener.class,$(GRAMMARS_G4))
BASELISTENER_CLASS := $(subst .g4,BaseListener.class,$(GRAMMARS_G4))

AUTO_CLASSES := \
	$(LEXER_CLASS) \
	$(PARSER_CLASS) \
	$(BASELISTENER_CLASS)

AUTO_SRC := $(patsubst %.class,%.java,$(AUTO_CLASSES))

# Global targets

main: $(AUTO_CLASSES) $(MAIN_CLASS) $(MY_CLASSES)

$(MY_CLASSES) $(MAIN_CLASS): $(AUTO_SRC)

%Main.java:
	@echo "------ Generate file \"$@\" ------"
	@read -p "*** Grammar entry rule? " rule; \
	while true; do \
	    read -p "*** Line-by-line processing? " yn; \
	    case $$yn in \
		[Yy]* ) rule="$$rule -i"; \
			break;; \
		[Nn]* ) break;; \
		* ) echo "Please answer yes or no";; \
	    esac; \
	done; \
	while true; do \
	    read -p "*** Use listeners? " yn; \
	    case $$yn in \
		[Yy]* ) read -p "Listeners's class? " class; \
			rule="$$rule -l $$class"; \
			warning="Don't forget to change the Makefile to include a dependency from class $$class\n"; \
			break;; \
		[Nn]* ) break;; \
		* ) echo "Please answer yes or no";; \
	    esac; \
	done; \
	while true; do \
	    read -p "*** Use visitors? " yn; \
	    case $$yn in \
		[Yy]* ) read -p "Visitor's class? " class; \
			rule="$$rule -v $$class"; \
			warning="Don't forget to change the Makefile to include a dependency from class $$class\n"; \
			break;; \
		[Nn]* ) break;; \
		* ) echo "Please answer yes or no";; \
	    esac; \
	done; \
	echo antlr4-main $* $$rule; \
	antlr4-main $* $$rule; \
	echo "------ done ------"

%.class: %.java
	javac $*.java

# Clean all automatic files

clean:
	antlr4-clean

# Clean all automatic files and semi-automatic Main files

deep-clean:
	@$(MAKE) -s clean
	-rm $(subst .class,.java,$(MAIN_CLASS))
