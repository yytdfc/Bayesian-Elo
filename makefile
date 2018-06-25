CXX = g++
CXX_FLAG = -O3 -std=c++11
PYBINDSO = bayeselo$(shell python3-config --extension-suffix)
SRCS =./BayesElo/version.cpp \
			./BayesElo/pgnlex.cpp \
			./BayesElo/str.cpp \
			./BayesElo/const.cpp \
			./BayesElo/date.cpp \
			./BayesElo/pgnstr.cpp \
			./BayesElo/move.cpp \
			./BayesElo/consolui.cpp \
			./BayesElo/clktimer.cpp \
			./BayesElo/CTimeIO.cpp \
			./BayesElo/chtime.cpp \
			./BayesElo/readstr.cpp \
			./BayesElo/ReadLineToString.cpp \
			./BayesElo/CVector.cpp \
			./BayesElo/CMatrix.cpp \
			./BayesElo/CMatrixIO.cpp \
			./BayesElo/CLUDecomposition.cpp \
			./BayesElo/CBradleyTerry.cpp \
			./BayesElo/CCDistribution.cpp \
			./BayesElo/CCDistributionCUI.cpp \
			./BayesElo/CCondensedResults.cpp \
			./BayesElo/CDistribution.cpp \
			./BayesElo/CDistributionCollection.cpp \
			./BayesElo/CEloRatingCUI.cpp \
			./BayesElo/CJointBayesian.cpp \
			./BayesElo/CResultSet.cpp \
			./BayesElo/CResultSetCUI.cpp \
			./BayesElo/EloDataFromFile.cpp \
			./BayesElo/CPredictionCUI.cpp

OBJS = $(SRCS:.cpp=.o)

.PHONY: all clean py-bayeselo test

all: libbayeselo.a libbayeselo.so $(PYBINDSO)
	

bayeselo: ./BayesElo/elomain.cpp $(OBJS)
	$(CXX) $(CXX_FLAG) $^ -o $@

test: test-cc $(PYBINDSO)
	@echo "Testing in C++..."
	./test-cc
	@echo
	@echo "Testing in Python..."
	python3 ./test.py

test-cc: test.cc libbayeselo.so
	$(CXX) $(CXX_FLAG) $^ -I. -L. -o test-cc -lbayeselo

libbayeselo.so: $(SRCS)
	$(CXX) $(CXX_FLAG) $^ -fPIC -shared -o $@

libbayeselo.a: $(OBJS)
	ar -r $@ $(OBJS)

py-bayeselo: $(PYBINDSO)
	

$(PYBINDSO): ./py-bayeselo.cc $(SRCS)
	$(CXX) $(CXX_FLAG) $^ -fPIC -shared \
		`python3 -m pybind11 --includes` -o $@

%.o: %.cpp
	$(CXX) $(CXX_FLAG) $< -c -o $@

clean:
	-rm bayeselo libbayeselo.so libbayeselo.a $(kPYBINDSO) test $(OBJS)
