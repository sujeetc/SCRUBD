# SCRUBD: A Dataset for Smart Contract Bug Detection

SCRUBD is a dataset designed for the detection of bugs in Smart Contracts, with a focus on **Reentrancy** (RE) and **Unhandled Exceptions** (UX). The dataset includes both real-world and synthetically generated scenarios, providing a comprehensive resource for advancing Smart Contract bug detection research.

## Version History

### v5.0 - 8th July 2025 ([`Version-5`](https://github.com/sujeetc/SCRUBD/tree/V5.0))
#### Updates
- Updated SCRUBD-CD/data/labels.csv
- Rectified an error

| Dataset    | Total RE Functions | RE Vuln | RE Non-Vuln | Total UX Functions |  UX Vuln | UX Non-Vuln |
|------------|-----------------|------------|----------------|-----------|------------|------------|
| **SCRUBD/SD** | 242           | 151        | 91             | N/A       | N/A        | N/A |
| **SCRUBD/CD** | 746         | 244        | 502            | 566      | 275        | 291


### v4.0 - 6th May 2025 ([`Version-4`](https://github.com/sujeetc/SCRUBD/tree/V4.0))
#### Updates
- Updated SCRUBD-SD/data/labels.csv
- Rectified some errors

| Dataset    | Total RE Functions | RE Vuln | RE Non-Vuln | Total UX Functions |  UX Vuln | UX Non-Vuln |
|------------|-----------------|------------|----------------|-----------|------------|------------|
| **SCRUBD/SD** | 242           | 151        | 91             | N/A       | N/A        | N/A |
| **SCRUBD/CD** | 746         | 245        | 501            | 566      | 275        | 291


### v3.0 - 1st April 2025 ([`Version-3`](https://github.com/sujeetc/SCRUBD/tree/V3.0))
#### Updates
- Updated SCRUBD-SD/data/labels.csv
- Rectified some errors

| Dataset    | Total RE Functions | RE Vuln | RE Non-Vuln | Total UX Functions |  UX Vuln | UX Non-Vuln |
|------------|-----------------|------------|----------------|-----------|------------|------------|
| **SCRUBD/SD** | 242           | 153        | 89             | N/A       | N/A        | N/A |
| **SCRUBD/CD** | 746         | 245        | 501            | 566      | 275        | 291

### v2.0 - 27th Feb 2025 ([`Version-2`](https://github.com/sujeetc/SCRUBD/tree/V2.0))
#### Updates
- Updated `SCRUBD-SD/data/solidity_codes/tool_fail.sol`
- Updated `SCRUBD-SD/data/labels.csv`
- Cleaned up Solidity code files in `SCRUBD-SD/data/solidity_codes`:
  - Removed unnecessary files
  - Removed redundant functions

| Dataset    | Total RE Functions | RE Vuln | RE Non-Vuln | Total UX Functions |  UX Vuln | UX Non-Vuln |
|------------|-----------------|------------|----------------|-----------|------------|------------|
| **SCRUBD/SD** | 242           | 154        | 88             | N/A       | N/A        | N/A
| **SCRUBD/CD** | 746         | 245        | 501            | 566       | 275        | 291

### v1.0 - 2nd Feb 2025 ([`Version-1`](https://github.com/sujeetc/SCRUBD/tree/V1.0))
Initial release of SCRUBD

| Dataset    | Total RE Functions | RE Vuln | RE Non-Vuln | Total UX Functions |  UX Vuln | UX Non-Vuln |
|------------|-----------------|------------|----------------|-----------|------------|------------|
| **SCRUBD/SD** | 239           | 155        | 84             | N/A       | N/A        | N/A |
| **SCRUBD/CD** | 746         | 245        | 501            | 566       | 275        |291|


## Project Structure

The repository is organized into the following main folders:

### 1. `limitations/`
This folder contains a detailed analysis of the limitations in existing Smart Contract datasets. It highlights areas where current datasets fall short and suggests improvements for more comprehensive bug detection. For more information, refer to [limitations folder](limitations).


### 2. `SCRUBD-CD/` (Crowdsourced Dataset)
This folder contains a crowdsourced dataset with labeled Smart Contract data, focusing on both **Reentrancy** (RE) and **Unhandled Exceptions** (UX).

#### Folder Structure:
- **`data/`**: This folder houses the dataset files:
  - **`contracts.csv`**: Contains addresses of Real World Smart Contracts used in SCRUBD-CD.
  - **`labels.csv`**: Provides vulnerability labels for each Smart Contract with detailed annotations about their vulnerability status. Each entry includes the Smart Contract address, function name, vulnerability to RE and UX, and a detailed comment explaining the rationale behind the vulnerability assessment.
  - **`tools_RE.csv`** and **`tools_UX.csv`**: These CSV files store the results from automated tool analyses applied to the Smart Contract codes. They include columns for each tool used (e.g., sailfish, slither, solhint) that indicate the presence of a vulnerability with "1", absence with "0", or "N/A" if a contract was not successfully parsed by a tool.
  - **`solidity_codes/`**: Contains Solidity Smart Contract codes associated with the dataset.
  - **`tool-results/`**: Stores the results of automated tool analyses in a structured format.
- **`scripts/`**:
  - **`ExtFromEtherScan.py`**: Script to collect Real World Smart Contracts from the Etherscan API.
    * Usage: `python3 ExtFromEtherScan.py`
    * contracts.csv contains addresses of Real World Smart Contracts used in SCRUBD-CD
  - **`Google-Bigquery.db`**: Contains a Google BigQuery SQL query that lists Smart Contracts with more than one transaction, sorted by their Ethereum balances. This query can be run on [Google Cloud BigQuery](https://cloud.google.com/bigquery).

#### Example Structure of the Labels Files (SCRUBD-CD/data/labels.csv)

This CSV file contains labels for the dataset, detailing the vulnerability status of Smart Contracts with an emphasis on **Reentrancy (RE)** and **Unhandled Exceptions (UX)** vulnerabilities. Each entry includes detailed comments explaining the rationale behind the vulnerability assessment.

##### File Structure

The file includes the following headers:

- ****Smart Contract****: The Ethereum address of the Smart Contract under analysis.
- ****Function Name****: Specifies the function within the Smart Contract being evaluated.
- ****RE****: Indicates the vulnerability of the contract to Reentrancy attacks. A value of `1` means the function is vulnerable, while `0` indicates it is not.
- ****UX****: Reflects the potential for Unhandled Exceptions within the function. A `1` denotes a vulnerability, whereas `0` signifies no vulnerabilities detected.
- ****is_student****: Indicates whether the analysis or mock scenario was designed or influenced by student involvement. `1` for yes, `0` for no.
- ****Comments****: Provides a detailed explanation for the vulnerability status, including reasons for identifying or dismissing the presence of vulnerabilities.

##### Sample Data

Here is a sample from the dataset showcasing the structure and type of data recorded:

| Smart Contract                               | Function Name                                             | RE | UX  | is_student | Comments                                                   |
|----------------------------------------------|-----------------------------------------------------------|----|-----|------------|------------------------------------------------------------|
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlue.spendGasTokens                                    | 1  | 1   | 1          | RE -- Multi call bug                                       |
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlueSettlementModule.matchOrderWithReserve            | 1  |     | 0          | RE -- balances[order.sellToken][order.signee]              |
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlueSettlementModule.matchOrderWithReserveWithData    | 1  |     | 0          | RE -- balances[order.sellToken][order.signee]              |
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlueSettlementModule.settleRingTrade                  | 1  |     | 0          | RE -- balances[trades[i].giveToken][reserve]               |
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlueSettlementModule.settleRingTradeWithData          | 1  |     | 0          | RE -- balances[trades[i].giveToken][reserve]               |
| 0x000000000000541e251335090ac5b47176af4f7e   | dexBlueSettlementModule.swapWithReserve                  | 0  |     | 0          | No vulnerabilities detected                                |
| 0x0000000000b3f879cb30fe243b4dfee438691c04   | GasToken2.destroyChildren                                 | 1  |     | 0          | RE -- Multi call bug                                       |
| 0x00195777bed7025e78819156281192c85fb3cf9b   | GAME.startRaffle                                          | 1  | 0   | 1          | RE -- state var jackpot                                    |
| 0x0030f75e27f6df16383f47ae11ae34abc21f5f2c   | TYRANT.internalTransfer                                   | 1  |     | 0          | Possible RE vulnerability detected                         |

##### Explanation of Columns

- ****RE (Reentrancy)****: This column indicates whether the Smart Contract is vulnerable to reentrancy attacks. A value of `1` suggests vulnerability, pointing to potential risks where the contract might be called recursively before the first invocation of the function is completed, leading to unexpected behaviors or states.

- ****UX (Unhandled Exceptions)****: This column shows whether the function is prone to unhandled exceptions, which might occur if the contract does not properly check or handle the outcomes of external calls or operations that fail, potentially reverting transactions or leading to loss of funds.

- ****Comments****: Provides context and clarification on the vulnerability status of each function, detailing specific conditions or coding patterns that contribute to the security assessment.

This structured approach in `labels.csv` ensures that researchers and developers have clear insights into the vulnerabilities of smart contracts, supporting more informed security practices and enhancements.

#### Example Structure of the Tool Files (SCRUBD-CD/data/tools\_RE.csv)

The tool results are stored in CSV files with the following columns:

- ***Smart Contract***: The address of the Smart Contract.
- ***Function Name***: The name of the function within the Smart Contract.
- ***sailfish, slither, solhint, mythril, conkas, smartcheck***: Columns representing the results from various static analysis tools. These tools identify potential vulnerabilities, with "1" indicating the presence of the vulnerability and "0" indicating its absence. If a contract was not parsed successfully by a tool, the result will be marked as "N/A".
- ***Actual***: The actual result of the vulnerability (either "1" for detected or "0" for not detected).

Here is an example structure for the file `tools_RE.csv` (for Reentrancy vulnerabilities):

| Smart Contract                               | Function Name                                          | conkas | mythril | sailfish | slither | solhint | Actual |
|---------------------------------------------|-------------------------------------------------------|----------|---------|---------|---------|--------|--------|
| 0x000000000000541e251335090ac5b47176af4f7e  | dexblue.spendgastokens                                | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.matchorderwithreserve        | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.matchorderwithreservewithdata| N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.settleringtrade              | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x000000000000541e251335090ac5b47176af4f7e  | dexbluesettlementmodule.settleringtradewithdata     | N/A      | 1       | 0       | 0       | 0      | 1      |
| 0x00195777bed7025e78819156281192c85fb3cf9b  | game.startraffle                                     | 0        | 1       | 1       | 0       | 0      | 1      |

In this table:
- The ****"Smart Contract"**** and ****"Function Name"**** columns identify the contract and function analyzed.
- The ****tool columns**** (e.g., sailfish, slither, etc.) represent the results of various static analysis tools used to detect vulnerabilities.
- ****"Actual"**** represents the real vulnerability outcome, with "1" indicating the vulnerability was detected and "0" indicating it was not.





### 3. `SCRUBD-SD/` (Synthesized Dataset)

This folder contains manually synthesized Reentrancy (RE) scenarios designed to aid in the study of Reentrancy vulnerabilities in Smart Contracts.

Similar to `SCRUBD-CD`, this folder also contains the following subdirectories:
#### Folder Structure:
- **`data/`**:
  - **`labels.csv`**: A CSV file containing the labels for the manually synthesized scenarios. This file categorizes the contracts based on the presence of RE vulnerabilities.
  - **`solidity_codes/`**: Contains the manually synthesized Smart Contracts designed to demonstrate specific vulnerabilities.
  - **`tool-results/`**: Stores the results of the tool analysis applied to the synthesized Smart Contracts, specifically for Reentrancy vulnerabilities.
  - **`tools_RE.csv`**: This CSV file store the results from automated tool analyses applied to the Smart Contract codes. It includes columns for each tool used (e.g., sailfish, slither, solhint) that indicate the presence of a vulnerability with "1", absence with "0", or "N/A" if a contract was not successfully parsed by a tool.



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

- The dataset was created as part of ongoing research to improve Smart Contract security and bug detection.


## Contact Us

For any inquiries or feedback regarding the SCRUBD dataset, please feel free to contact us:

- **Email**: [sujeetc@cse.iitk.ac.in](mailto:sujeetc@cse.iitk.ac.in)

We look forward to your contributions and feedback!
