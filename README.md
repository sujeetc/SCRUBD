# SCRUBD: A Dataset for Smart Contract Bug Detection

SCRUBD is a dataset designed for the detection of bugs in smart contracts. It includes both real-world and synthetically generated scenarios, with a focus on **Reentrancy** (RE) and **Unhandled Exceptions** (UX). This dataset is divided into multiple components, each serving a specific purpose in advancing smart contract bug detection research.

## Project Structure

The repository is organized into the following main folders:

### 1. `limitations/`
This folder contains a detailed analysis of the limitations in existing smart contract datasets. It highlights areas where current datasets fall short and suggests improvements for more comprehensive bug detection. For more information, refer to the detailed README in the [limitations folder](limitations/README.md).

### 2. `SCRUBD-CD/` (Crowdsourced Dataset)
This folder contains a crowdsourced dataset with labeled smart contract data, focusing on **Reentrancy** (RE) and **Unhandled Exceptions** (UX).

Within this folder, you'll find the following subdirectories:
- **`labels.csv`**: A CSV file containing labels for the dataset. It specifies whether the smart contract is vulnerable to RE or UX.
- **`solidity_codes/`**: A folder containing Solidity smart contract codes. These are the actual contracts associated with the labels.
- **`tool-results/`**: This directory contains the results of automated tool analyses applied to the smart contract codes, indicating vulnerabilities identified by various static analysis tools.

### 3. `SCRUBD-SD/` (Synthesized Dataset)
This folder contains manually synthesized Reentrancy Scenarios designed to aid in the study of Reentrancy vulnerabilities in smart contracts.

Similar to `SCRUBD-CD`, this folder also contains the following subdirectories:
- **`labels.csv`**: A CSV file containing the labels for the manually synthesized scenarios. This file categorizes the contracts based on the presence of RE or UX vulnerabilities.
- **`solidity_codes/`**: Contains the manually synthesized smart contracts designed to demonstrate specific vulnerabilities, particularly Reentrancy.
- **`tool-results/`**: Results of the tool analysis applied to the synthesized smart contracts.

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


