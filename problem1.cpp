#include <iostream>
using namespace std;
int gcd(int a, int b)
{
	int t = 1;
	while (t != 0) {
		t = a % b;
		a = b;
		b = t;
	}
	return a;
}
int main()
{
	int a, b;
	cin >> a >> b;
	cout << gcd(a, b) << endl;
}