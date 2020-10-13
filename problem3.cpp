#include <iostream>
#include <queue>
using namespace std;
struct info
{
	int p1, p2, d;
	info() {};
	info(int a, int b, int c) :p1(a), p2(b), d(c) {};
	bool operator<(const info& a)const { return d > a.d; };
};
int min_spanning_tree(int** map, int N, info* portal)
{
	int* is_visited, prtl_size = 0;
	is_visited = new int [N] {};
	priority_queue<info>min_heap;
	min_heap.push(info(0, 0, 0));
	while (!min_heap.empty()) {
		info curt = min_heap.top(), next;
		min_heap.pop();
		if (is_visited[curt.p2] == 1)
			continue;
		else
			portal[prtl_size++] = curt;
		is_visited[curt.p2] = 1;
		for (int i = 0; i < N; i++) {
			if (map[curt.p1][i] != 0 && is_visited[i] == 0) {
				next.p1 = curt.p2;
				next.p2 = i;
				next.d = map[curt.p2][i];
				min_heap.push(next);
			}
		}
	}
	delete[]is_visited;
	return prtl_size;
}
int min_cost(int T,int X, info* portal, int prtl_size)
{
	int min = 99999999, level = 0;
	for (int i = 1; i <= T; i++) {
		int total = 0;
		for (int j = 0; j < prtl_size; j++)
			total += portal[j].d / i;
		total += i * X;
		if (min > total) {
			min = total;
			level = i;
		}
	}
	return level;
}
int main()
{
	int N, M, T, X, ** map, island_x, island_y, C, level, prtl_size;
	info* portal;
	cin >> N >> M >> T >> X;
	map = new int* [N] {};
	portal = new info[M]{};
	for (int i = 0; i < N; i++)
		map[i] = new int [N] {};
	for (int i = 0; i < M; i++) {
		cin >> island_x >> island_y >> C;
		map[island_x - 1][island_y - 1] = map[island_y - 1][island_x - 1] = C;
	}
	prtl_size = min_spanning_tree(map, N, portal);
	level = min_cost(T, X, portal, prtl_size);
	cout << level << endl;
	cout << prtl_size - 1 << endl;
	for (int i = 1; i < prtl_size; i++)
		cout << portal[i].p1 + 1 << " " << portal[i].p2 + 1 << endl;
	for (int i = 0; i < N; i++)
		delete[]map[i];
	delete[]map;
	delete[]portal;
}