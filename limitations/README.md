# Limitations of Existing Datasets

The `limitations/` folder explores the limitations in existing smart contract datasets and provides additional insight into how vulnerabilities are represented and detected. This folder contains a single subfolder called `Turn-The-Rudder`, which provides an analysis of **semantically unique** and **exact matches** between vulnerable and non-vulnerable smart contract functions.

## Folder Structure

### `Turn-The-Rudder/`
This folder contains three CSV files that highlight different levels of function similarities in smart contracts, focusing on vulnerabilities:

- **`duplicates-semantically-unique.csv`**: This file lists smart contract functions that are semantically unique but may contain duplicate or similar-looking code. It is useful for understanding how small syntactical differences may or may not affect vulnerability detection tools.
  
- **`duplicates-unique.csv`**: This file contains data where duplicate function names exist, but the functions are unique in terms of their logic or structure. This highlights potential challenges in detecting vulnerabilities when function names are reused but their logic diverges.

- **`duplicates.csv`**: This file lists completely identical functions found in different smart contracts. These duplicates share both the same function names and bodies, making them ideal for analysis of exact matches and vulnerability propagation.

Each file contains the following columns:

- **`Smart Contract`**: The name of the smart contract where the function appears.
  
- **`Vuln-Function`**: The name of the function that is considered vulnerable in the contract.

- **`Exact-Function-In-Non-Vuln`**: A hash of the function body that has been matched with a non-vulnerable function in a different contract. This column is used to show cases where a function is vulnerable in one contract but matches exactly with a non-vulnerable version in another contract.

## How to Use

1. Navigate to the `Turn-The-Rudder/` folder.
2. Open any of the CSV files to analyze the relationship between vulnerable functions and their counterparts in non-vulnerable contracts.
3. Use the data to study how certain vulnerabilities may propagate even when function names appear identical or similar.

### Example Workflow:

You can load the CSV files into a data analysis tool like pandas in Python to process and analyze the data:

```python
import pandas as pd

# Load the CSV file
df = pd.read_csv('Turn-The-Rudder/duplicates-semantically-unique.csv')

# Display the data
print(df.head())

