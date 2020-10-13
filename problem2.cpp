#include <iostream>
using namespace std;
void swap(int number[], int i, int j)
{
	int temp;
	temp = number[i];
	number[i] = number[j];
	number[j] = temp;
}
bool compare(int number[], int modulo, int i, int j)
{
	if (number[i] % modulo > number[j] % modulo)
		return true;
	else if (number[i] % modulo < number[j] % modulo)
		return false;
	else {
		if (number[i] % 2 < number[j] % 2)
			return true;
		else if (number[i] % 2 > number[j] % 2)
			return false;
		else {
			if (number[i] % 2) {
				if (number[i] < number[j])
					return true;
				else
					return false;
			}
			else {
				if (number[i] > number[j])
					return true;
				else
					return false;
			}
		}
	}
}
void bobule_sort(int number[], int num, int modulo)
{
	for (int i = 0; i < num - 1; i++) {
		for (int j = i + 1; j < num; j++) {
			if (compare(number, modulo, i, j))
				swap(number, i, j);
		}
	}
}
int main()
{
	int N, M, * number;
	cin >> N >> M;
	number = new int[N];
	for (int i = 0; i < N; i++)
		cin >> number[i];
	bobule_sort(number, N, M);
	for (int i = 0; i < N; i++)
		cout << number[i] << " ";
}