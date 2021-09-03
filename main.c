// Test program

int main() {

  int k;
  int sum = 0;

  for (k = 0; k < 10; k++)
	sum += k; 
 
  *((char*) 0x7000) = (char) sum;

  return 0;
}

