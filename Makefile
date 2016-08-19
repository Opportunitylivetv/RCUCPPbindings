# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you can access it online at
# http://www.gnu.org/licenses/gpl-2.0.html.
#
# Copyright (c) 2016 Paul E. McKenney, IBM Corporation.

PROGS = urcucpp
GCC_ARGS = -g

all: $(PROGS)

# NOTE:  For decent scalability on update-side tests as of early 2015,
#	 use something like jemalloc() instead of glibc malloc().
#	 If you install jemalloc at /home/paulmck/jemalloc, you will
#	 need the following additional arguments to cc:
#		-I/home/paulmck/jemalloc/include
#		-L/home/paulmck/jemalloc/lib
#		-Wl,--rpath,/home/paulmck/jemalloc/lib
#		-DUSE_JEMALLOC
#	 Verify by using the nm command and searching output for malloc.

urcucpp: urcucpp.C urcu-signal.h rcu.h
	g++ $(GCC_ARGS) -o urcucpp urcucpp.C -I/home/git/userspace-rcu -L/home/git/userspace-rcu/.libs -Wl,--rpath,/home/git/userspace-rcu/.libs -lpthread -lurcu -lurcu-signal

clean:
	rm -f $(PROGS)
