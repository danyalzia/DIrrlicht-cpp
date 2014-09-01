IRRLICHT_HOME = /usr/local/include/irrlicht

all:
	g++ src/dirrlicht/cpp/main.cpp -c -o cpp.o -I$(IRRLICHT_HOME)
	
.PHONY:
	all
