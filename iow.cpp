#include <iostream>
#include <fstream>
#include <string>

int main()
{
    std::ifstream inputFile("input.txt"); // Replace "input.txt" with your actual file path

    if (!inputFile)
    {
        std::cerr << "Failed to open the file." << std::endl;
        return 1;
    }

    std::string line;
    int row = 0;
    while (std::getline(inputFile, line))
    {
        std::cout << line << std::endl;
        row++;

        if (row % 8 == 0)
        {
            std::cout << "Press Enter to continue...";
            std::cin.ignore();
        }
    }

    inputFile.close();
    return 0;
}
