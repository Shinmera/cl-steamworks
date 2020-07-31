CXX ?= g++

shim:
	@[ "${steamworks}" ] || ( echo "[!!] Please set the 'steamworks' variable to the steamworks SDK root."; exit 1 )
	$(CXX) -std=c++11 -fPIC -I $(steamworks)/public/steam/ shim.c -shared -o steamworks_shim.so
