#!/usr/bin/awk -f

/H/ {
  MAM = sprintf("%s    %s = \"s\"\n", MAM, $1);
  #HD = sprintf("%s    %s = -0.1857\n", HD, $1);
};
/C/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  #HD = sprintf("%s    %s = -0.1492\n", HD, $1);
};
/O/ {
  MAM = sprintf("%s    %s = \"p\"\n", MAM, $1);
  #HD = sprintf("%s    %s = -0.1575\n", HD, $1);
};
/N/ {
  MAM = sprintf("%s    %s = \"p\"\n", "$MAM", $1);
  #HD = sprintf("%s    %s = -0.1535\n", "$HD", $1);
};

END {
print "Geometry = GenFormat {";
print "  <<< \"struc.gen\"";
print "}";
print "";
print "Driver = {}";
print "";
print "Hamiltonian = DFTB {";
print "  SCC = Yes";
print "  SCCTolerance = 1.00E-6";
print "  MaxAngularMomentum {";
printf "%s", MAM
print "  }";
#print "  HubbardDerivs {";
#printf "%s", HD
#print "  }";
print "  ThirdOrder = Yes";
print "  SlaterKosterFiles = Type2FileNames {";
print "    Prefix = \"/home/ehlert/git/DFTB+/external/slakos/origin/mio-1-1/\"";
#print "    Prefix = \"/home/ehlert/git/DFTB+/external/slakos/origin/3ob-3-1/\"";
print "    Separator = \"-\"";
print "    Suffix = \".skf\"";
print "  }";
print "}";
print "Options {";
print "  WriteResultsTag = Yes";
print "}";
}
