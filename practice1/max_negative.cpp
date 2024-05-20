#include <iostream>
#include <vector>
#include <optional>
#include <print>

std::optional<int> findMaxNeg (const std::vector<int>& numbers){
	std::optional<int> maxNeg;
	for (int num : numbers){
		if (num < 0){
			if (!maxNeg || num > maxNeg){
				maxNeg = num;
			}
		}
	}
return maxNeg;
}

int main() {
	std::vector<int> numbers = {32, -3435, 425, -42, 435, -1};
	std::optional<int> result = findMaxNeg(numbers);
	std::cout << *result <<std::endl;
	return 0;
}


