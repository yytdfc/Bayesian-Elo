#include "BayesElo/CResultSet.h"
#include "BayesElo/CEloRatingCUI.h"
#include <iostream>
int main() {
  CResultSet rs;
  rs.Append(1, 0, 2);
  CEloRatingCUI ercui(rs, std::vector<std::string>({"1", "2"}));
  ercui.Offset(1600);
  ercui.MM();
  ercui.ExactDist();
  ercui.Ratings(std::cout);
}
