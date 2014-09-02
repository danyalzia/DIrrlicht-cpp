module dirrlicht.core;

alias stringc = string;

struct dimension2d(T) {
	int height;
	int width;
}

alias dimension2du = dimension2d!uint;

struct position2d(T) {
}

alias position2di = position2d!int;

struct rect(T) {
}

alias recti = rect!int;

struct vector3d(T) {
	T x, y, z;
}

alias vector3df = vector3d!float;

struct triangle3d(T) {
	T x, y, z;
}

alias triangle3df = triangle3d!float;

struct plane3d(T) {
	T x, y, z;
}

alias plane3df = plane3d!float;

struct aabbox3d(T) {
	T x, y, z;
}

alias aabbox3df = aabbox3d!float;

struct matrix4 {
}

alias path = const char*;

struct array(T) {
	
}
