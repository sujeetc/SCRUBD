# SCRUBD: A Dataset for Smart Contract Bug Detection

SCRUBD is a dataset designed for the detection of bugs in smart contracts, with a focus on **Reentrancy** (RE) and **Unhandled Exceptions** (UX). The dataset includes both real-world and synthetically generated scenarios, providing a comprehensive resource for advancing smart contract bug detection research.

## Project Structure

The repository is organized into the following main folders:

### 1. `limitations/`
This folder contains a detailed analysis of the limitations in existing smart contract datasets. It highlights areas where current datasets fall short and suggests improvements for more comprehensive bug detection. For more information, refer to the detailed README in the [limitations folder](limitations/README.md).

### 2. `SCRUBD-CD/` (Crowdsourced Dataset)
This folder contains a crowdsourced dataset with labeled smart contract data, focusing on both **Reentrancy** (RE) and **Unhandled Exceptions** (UX).

Within this folder, you'll find the following subdirectories:
- **`solidity_codes/`**: A folder containing Solidity smart contract codes. These are the actual contracts associated with the labels.
- **`tool-results/`**: This directory contains two files, `tools_RE.csv` and `tools_UX.csv`, which store the results of automated tool analyses applied to the smart contract codes, indicating vulnerabilities identified by various static analysis tools.
- **`labels.csv`**: A CSV file containing labels for the dataset. It specifies whether the smart contract is vulnerable to RE or UX.
- **`Google-Bigquery.db`**: Contains a Google BigQuery SQL query that lists smart contracts with more than one transaction, sorted by their Ethereum balances. This query can be run on [Google Cloud BigQuery](https://cloud.google.com/bigquery).

This file contains labeled data for smart contracts with an emphasis on **Reentrancy (RENT)** and **Unhandled Exceptions (UE)** vulnerabilities. The file provides detailed comments explaining whether each contract function is vulnerable to these issues or not.

#### File Structure

The file contains the following headers:

- **Smart Contract**: The address of the smart contract being analyzed.
- **Function Name**: The name of the function within the smart contract.
- **RENT**: Indicates whether the contract is vulnerable to Reentrancy. A value of `1` means vulnerable, while `0` means not vulnerable.
- **UX**: Indicates whether the contract is vulnerable to Unhandled Exceptions. A value of `1` means vulnerable, while `0` means not vulnerable.
- **Comments**: Detailed explanation for the vulnerability status, including reasons for identifying the vulnerability or not.

#### Sample Data

| Smart Contract                               | Function Name                                             | RENT | UE  | Comments                                                            |
|---------------------------------------------|----------------------------------------------------------|------|-----|---------------------------------------------------------------------|
| 0x000000000000541e251335090ac5b47176af4f7e  | dexBlue.spendGasTokens(uint256)                          | 0    | 1   | -- No REENT: no ether involved                                       |
| 0x0000000000b3f879cb30fe243b4dfee438691c04  | GasToken2.makeChild()                                    | 0    | 1   | -- Reason for no REENT: No state changes after external call       | 
| 0x0003ed19f80564745e84b4cc411a7b6be4f0cf31  | NeverJeet.openTrading()                                  | 0    | 0   |                                                                     |
| 0x00195777bed7025e78819156281192c85fb3cf9b  | GAME.startRaffle(uint256)                                | 1    | 0   | -- REENT -- state var jackpot                                       |
| 0x0030f75e27f6df16383f47ae11ae34abc21f5f2c  | TYRANT.GoLive()                                          | 0    | 0   | -- no REENT: modifier onlyowner                                     |

#### Explanation of Columns

- **RENT (Reentrancy)**: This column indicates whether the smart contract is vulnerable to **Reentrancy** attacks. A value of `1` means the function is vulnerable, and `0` means the function is not vulnerable. Reentrancy vulnerabilities occur when a contract calls an external contract and the external contract calls back into the original contract, potentially causing unintended behavior.

- **UE (Unhandled Exceptions)**: This column indicates whether the smart contract function has **Unhandled Exceptions**. A value of `1` means there is a vulnerability, and `0` means there isn't. Unhandled exceptions can occur when the contract fails to handle error cases properly, such as failing to account for the failure of external contract calls or operations that could revert the transaction.

- **Comments**: This column provides explanations for the vulnerabilities (or lack thereof). It describes why a function is marked as vulnerable or not, such as the lack of state changes or the presence of modifiers that prevent reentrancy.


### 3. `SCRUBD-SD/` (Synthesized Dataset)
This folder contains manually synthesized Reentrancy (RE) scenarios designed to aid in the study of Reentrancy vulnerabilities in smart contracts.

Similar to `SCRUBD-CD`, this folder also contains the following subdirectories:
- **`labels.csv`**: A CSV file containing the labels for the manually synthesized scenarios. This file categorizes the contracts based on the presence of RE vulnerabilities.
- **`solidity_codes/`**: Contains the manually synthesized smart contracts designed to demonstrate specific vulnerabilities, particularly Reentrancy.
- **`tool-results/`**: This directory contains the file `tools_RE.csv`, which stores the results of the tool analysis applied to the synthesized smart contracts, specifically for Reentrancy vulnerabilities.

## Example Structure of the Tool Files

The tool results are stored in CSV files with the following columns:

- **Smart Contract**: The address of the smart contract.
- **Function Name**: The name of the function within the smart contract.
- **sailfish, slither, solhint, mythril, conkas, smartcheck**: Columns representing the results from various static analysis tools. These tools identify potential vulnerabilities, with "1" indicating the presence of the vulnerability and "0" indicating its absence. If a contract was not parsed successfully by a tool, the result will be marked as "N/A".
- **Actual**: The actual result of the vulnerability (either "1" for detected or "0" for not detected).

Here is an example structure for the file `tools_RE.csv` (for Reentrancy vulnerabilities):

| Smart Contract                               | Function Name                                          | sailfish | slither | solhint | mythril | conkas | Actual |
|---------------------------------------------|-------------------------------------------------------|----------|---------|---------|---------|--------|--------|
| 0x000000000000541e251335090ac5b47176af4f7e  | dexblue.spendgastokens                                | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.matchorderwithreserve        | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.matchorderwithreservewithdata| N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.settleringtrade              | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.settleringtradewithdata     | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x00195777bed7025e78819156281192c85fb3cf9b  | game.startraffle                                     | 0        | 1       | 1       | 0       | 0      | 1      |

In this table:
- The **"Smart Contract"** and **"Function Name"** columns identify the contract and function analyzed.
- The **tool columns** (e.g., sailfish, slither, etc.) represent the results of various static analysis tools used to detect vulnerabilities.
- **"Actual"** represents the real vulnerability outcome, with "1" indicating the vulnerability was detected and "0" indicating it was not.

## How to Use

1. Clone the repository:
    ```bash
    git clone https://github.com/sujeetc/SCRUBD.git
    ```

2. Navigate to the relevant folder:
    - For crowdsourced data: `SCRUBD-CD/`
    - For synthesized data: `SCRUBD-SD/`
    - For limitations and analysis of dataset gaps: `limitations/`

3. Analyze the Solidity codes and labels using the provided tool results for vulnerability detection.

## Contribution

We welcome contributions from the community to improve this dataset. If you have suggestions for new scenarios, tools, or enhancements to the current dataset, feel free to open an issue or submit a pull request.

## Acknowledgments

- The dataset was created as part of ongoing research to improve smart contract security and bug detection.

