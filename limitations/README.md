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

##### Sample Data from `duplicates.csv`
| Smart Contract | Vuln-Function | Exact-Function-In-Non-Vuln |
|----------------|---------------|----------------------------|
| 0x9a156f934c3542ef6a4443ce9a91d2d768fc01c1.sol | executeProposal(uint256;bytes) | 07fcf82e36393d01fe19ebad7129d03b6cbf0568 |
| 0xb7c5c5aa4d42967efe906e1b66cb8df9cebf04f7.sol | withdraw() | 0d4fab96a6b16debadded507d1507b25fd3375e1 |
| 0x05f49e3e0a27efa05d60c19cd8f0ecc951d3717e.sol | ReturnEthToEtherhero() | 0f5140806321d87d82ad0a35b930315f8b56afe9 |
| ... | ... | ... |

Each file contains columns for the smart contract name, the vulnerable function, and an exact match of the function in a non-vulnerable contract. The 'Exact-Function-In-Non-Vuln' column includes hashes followed by contract lists, indicating matched non-vulnerable functions.

##### Turn The Rudder Dataset
 [Github Link](https://github.com/InPlusLab/ReentrancyStudy-Data).


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

