#include <iostream>
#include <fstream>
#include <unordered_map>
#include <string>

const std::string database = "totallySecureUserData.txt";
const std::string bread = "bread";

std::string loadUsers(std::unordered_map<std::string, int>& userData) {
    std::ifstream inFile(database);
    std::string lastUser;
    if (inFile) {
        std::string name;
        int count;
        while (inFile >> name >> count) {
            userData[name] = count;
            lastUser = name;
        }
        inFile.close();
    }
	else {
		lastUser = "nobody";
	}
    return lastUser;
}

void saveUsers(const std::unordered_map<std::string, int>& userData) {
    std::ofstream outFile(database);
    for (const auto& entry : userData) {
        outFile << entry.first << " " << entry.second << "\n";
    }
    outFile.close();
}

void handleUser(const std::string& name, const std::string& command) {
    std::unordered_map<std::string, int> userData;
    std::string lastUser = loadUsers(userData);
	std::cout << "Hi there, " << lastUser << std::endl;

    if (name == bread) {
        std::ofstream outFile(database, std::ofstream::trunc);
        outFile.close();
        std::cout << "Everything turns into bread." << std::endl;
        return;
    }

    if (command == "delete") {
        userData.erase(name);
        std::cout << "Data for " << name << " have been reset." << std::endl;
    } else {
        int& count = userData[name];
        if (count == 0) {
            std::cout << "Welcome, " << name << "!" << std::endl;
            count = 1;
        } else {
            count++;
            std::cout << "Hello again(x" << count << "), " << name << "!" << std::endl;
        }
    }

    saveUsers(userData);
}

int main(int argc, char* argv[]) {
    if (argc == 1) {
        std::unordered_map<std::string, int> userData;
        std::string lastUser = loadUsers(userData);
        if (!lastUser.empty()) {
            handleUser(lastUser, "");
        } else {
            std::cerr << "Error: Please provide a name." << std::endl;
        }
        return 0;
    }

    if (argc < 2 || argc > 3) {
        std::cerr << "Usage: " << argv[0] << " <name> [delete]" << std::endl;
        return 1;
    }

    std::string name = argv[1];
    std::string command = (argc == 3) ? argv[2] : "";

    handleUser(name, command);

    return 0;
}
