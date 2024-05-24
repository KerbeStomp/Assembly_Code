#include <iostream>
#include "cache_unit.h"
using namespace std;

const int addr[] = {0x1000, 0x1024, 0x1599, 0x100, 0x10245, 0x10246,
		0x1027, 0x10247, 0x1600, 0x1601, 0x1700};
const int total_addr = 11;

int main()
{
		cache_unit L1(1, 256, 4);
		cache_unit L2(10, 1024, 64);
		cache_unit L3(100, 4096, 256);
		cache_unit main_mem(1000, 0, 0);

		int total_cycles = 0;

		for (int i = 0; i < total_addr; ++i)
		{
				// check if addr is in level-1 cache
				if (L1.check_cache(addr[i]))
				{
						total_cycles += L1.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
						continue;
				}
				else
				{
						L1.update_cache(addr[i]);
						total_cycles += L1.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
				}

				// check if addr is in level-2 cache
				if (L2.check_cache(addr[i]))
				{
						total_cycles += L2.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
						continue;
				}
				else
				{
						L2.update_cache(addr[i]);
						total_cycles += L2.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
				}

				// check if addr is in level-3 cache
				if (L3.check_cache(addr[i]))
				{
						total_cycles += L3.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
						continue;
				}
				else
				{
						L3.update_cache(addr[i]);
						total_cycles += L3.get_cost();
						cout << "Total cycles for address " << i << " : " << total_cycles << endl;
				}

				// if reached, addr not found, so look in main mem
				total_cycles += main_mem.get_cost();
				cout << "Total cycles for address " << i << " : " << total_cycles << endl;
		}

		cout << "Total cycles: " << total_cycles << endl;
		return 0;
}
