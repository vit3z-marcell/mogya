param nRows;
param cashierCount;
param cashierLength;
set ProductGroups;
param space{ProductGroups};
set Rows := 1..nRows;
set Cashiers := 1..cashierCount;
# Hasznalt valtozok
var aBoltHossza >= 0;
var termekekEgySorban{Rows, ProductGroups} binary;
var kasszakSzamaEgySorban{Rows, Cashiers} binary;
var egySorHossza{Rows} >= 0;

# Kikotesek
s.t. egyTermekcsakEgySorban{p in ProductGroups}:
	sum{r in Rows} productInRow[r,p]=1;


s.t. sorokhosszanakszamitasa{r in Rows}:
	lengthOfRow[r] = sum{p in ProductGroups} termekekEgySorban[r,p]*space[p] + sum{c in Cashiers} kasszakSzamaEgySorban[r,c]*cashierLength;

s.t. mindenKasszanakLegyenHelye{c in Cashiers}:
	sum{r in Rows} kasszakSzamaEgySorban[r,c]=1;

s.t. boltMerete{r in Rows}:
	aBoltHossza >= egySorHossza[r];


# Celfg

minimize azAruhazMerete: aBoltHossza;

# Kiiratas
solve;

printf "%f\n",aBoltHossza;


