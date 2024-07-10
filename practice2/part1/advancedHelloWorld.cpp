#include <iostream>
#include <fstream>
#include <unordered_map>
#include <string>
#include <print>

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
    } else {
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
    std::println("Hi there, {}", lastUser);

    if (name == bread) {
        std::ofstream outFile(database, std::ofstream::trunc);
        outFile.close();
        std::println("Everything turns into bread.");
        return;
    }

    if (command == "delete") {
        userData.erase(name);
        std::println("Data for {} have been reset.", name);
    } else {
        int& count = userData[name];
        if (count == 0) {
            std::println("Welcome, {}!", name);
            count = 1;
        } else {
            count++;
            std::println("Hello again(x{}), {}!", count, name);
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
