#!/usr/bin/awk -f

/H/ {
  MAM = sprintf("%s    %s = \"s\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1857\n", HD, $1);
};
/C/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1492\n", HD, $1);
};
/O/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1575\n", HD, $1);
};
/N/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1535\n", HD, $1);
};
/Br/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0573\n", HD, $1);
};
/Mg/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0200\n", HD, $1);
}
/Ca/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0340\n", HD, $1);
}
/Na/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0454\n", HD, $1);
}
/Cl/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0697\n", HD, $1);
}
/F/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1623\n", HD, $1);
}
/P/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1400\n", HD, $1);
}
/S/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.1100\n", HD, $1);
}
/I/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0433\n", HD, $1);
}
/Zn/ {
  MAM = sprintf("%s    %s = \"d\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0300\n", HD, $1);
}
/K/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  HD = sprintf("%s    %s = -0.0339\n", HD, $1);
}

END {
print "Geometry = GenFormat {";
print "  <<< \"struc.gen\"";
print "}";
print "";
print "Driver = {}";
print "";
print "Hamiltonian = DFTB {";
print "  SCC = Yes";
print "  SCCTolerance = 1.00E-8";
if ((getline charge < ".CHRG") > 0) {
  print "  Charge = ", charge
}
print "  MaxAngularMomentum {";
printf "%s", MAM
print "  }";
print "  MaxSCCIterations = 250";
if (method == "3ob" || method "3ob-3-1") {
  print "  HubbardDerivs {";
  printf "%s", HD;
  print "  }";
  print "  ThirdOrder = Yes";
  #print "  ThirdOrderFull = Yes";
  print "  HCorrection = Damping {";
  print "    Exponent = 4.0";
  print "  }";
}
print "  SlaterKosterFiles = Type2FileNames {";
format = "    Prefix = \"/home/ehlert/git/DFTB+/external/slakos/origin/%s/\"\n";
if (method == "3ob" || method == "3ob-3-1") {
  printf format, "3ob-3-1";
} else if (method == "matsci" || method == "matsci-0-3") {
  printf format, "matsci-0-3";
} else if (method == "mio" || method == "mio-1-1") {
  printf format, "mio-1-1";
} else if (method == "pbc" || method == "pbc-0-3") {
  printf format, "pbc-0-3";
} else if (method == "ob2" || method == "ob2-1-1") {
  printf format, "ob2-1-1";
}
print "    Separator = \"-\"";
print "    Suffix = \".skf\"";
print "  }";
if (method == "ob2" || method == "ob2-1-1") {
  print "  RangeSeparated = LC {";
  print "    Screening = NeighbourBased {}";
  print "  }";
}
print "}";
print "Options {";
print "  WriteResultsTag = Yes";
print "}";
}
