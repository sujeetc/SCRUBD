// SPDX-License-Identifier: MIT

/**
C-TEAM ALWAYS DREAMING BIG... CHIP, CHIP, CHIP!!
*
*/
pragma solidity 0.8.13;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Pair {
    function sync() external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;
}

contract ChipToken is Context, IERC20, IERC20Metadata, Ownable {
    // Openzeppelin variables
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    // My variables

    bool private inSwap;
    uint256 internal _marketingFeeCollected;
    uint256 internal _donationFeeCollected;
    uint256 internal _liquidityFeeCollected;

    uint256 public minTokensBeforeSwap;
    
    address public marketing_wallet;
    address public donation_wallet;
    address public liquidity_wallet;

    IUniswapV2Router02 public router;
    address public pair;

    uint public _feeDecimal = 2;
    // index 0 = buy fee, index 1 = sell fee, index 2 = p2p fee
    uint[] public _marketingFee;
    uint[] public _donationFee;
    uint[] public _liquidityFee;

    bool public swapEnabled = true;
    bool public isFeeActive = false;

    mapping(address => bool) public isTaxless;
    mapping(address => bool) public isMaxTxExempt;

    mapping(address => bool) public blacklist;
    uint blocks_autoblacklist_active;

    mapping(address => bool) public whitelist;

    uint public maxTxAmount;
    uint public maxWalletAmount;

    bool public tradingOpen = true;
    bool public restrictionsEnabled = false;
    uint extra_fee_percent;
    mapping(address => uint) public lastTx;
    uint cooldown_period;

    event Swap(uint swaped, uint sentToMarketing, uint sentToDonation);
    event AutoLiquify(uint256 amountETH, uint256 amountTokens);

    // Openzeppelin functions

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor() {
        // Editable
        string memory e_name = "Chip Token";
        string memory e_symbol = "CHIP";
        marketing_wallet = 0x2B7eE5c88E18E7343ec787c7261Cc62169C4902D;
        donation_wallet = 0xC985FEFf12c16F3F308A55202A6BD6b7B8E4f362;
        liquidity_wallet = 0x2d0B9D9B03c2B0cC2610150a427ee03A63c80B5B;
        uint e_totalSupply = 500_000_000 ether;
        minTokensBeforeSwap = e_totalSupply;    // Off by default
        cooldown_period = 2 minutes;
        extra_fee_percent = 9000;
        // End editable
        
        _name = e_name;
        _symbol = e_symbol;

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());
        router = _uniswapV2Router;

        _marketingFee.push(300);
        _marketingFee.push(300);
        _marketingFee.push(0);

        _donationFee.push(300);
        _donationFee.push(300);
        _donationFee.push(0);

        _liquidityFee.push(200);
        _liquidityFee.push(200);
        _liquidityFee.push(0);

        isTaxless[msg.sender] = true;
        isTaxless[address(this)] = true;
        isTaxless[marketing_wallet] = true;
        isTaxless[donation_wallet] = true;
        isTaxless[liquidity_wallet] = true;
        isTaxless[address(0)] = true;

        isMaxTxExempt[msg.sender] = true;
        isMaxTxExempt[address(this)] = true;
        isMaxTxExempt[marketing_wallet] = true;
        isMaxTxExempt[donation_wallet] = true;
        isMaxTxExempt[liquidity_wallet] = true;
        isMaxTxExempt[pair] = true;
        isMaxTxExempt[address(router)] = true;

        _mint(msg.sender, e_totalSupply);

        setMaxWalletPercentage(1000);    // 100%
        setMaxTxPercentage(1000);         // 100%
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, _allowances[owner][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = _allowances[owner][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        // My implementation
        require(!blacklist[from] && !blacklist[to], "sender or recipient is blacklisted!");
        require(isMaxTxExempt[from] || amount <= maxTxAmount, "Transfer exceeds limit!");
        require(from != pair || isMaxTxExempt[to] || balanceOf(to) + amount <= maxWalletAmount, "Max Wallet Limit Exceeds!");

        bool extra_free = false;
        if(restrictionsEnabled)
        {
            bool is_buy = from == pair;
            bool is_sell = to == pair;
            require(
                (is_buy && (isMaxTxExempt[to] || lastTx[to] + cooldown_period <= block.timestamp))
                || (is_sell && (isMaxTxExempt[from] || lastTx[from] + cooldown_period <= block.timestamp))
                || (!is_buy && !is_sell && lastTx[from] + cooldown_period <= block.timestamp)
                , "Must wait cooldown period");
            if(is_buy)
            {
                lastTx[to] = block.timestamp;
            }else
            {
                lastTx[from] = block.timestamp;
            }
            if(is_buy && !whitelist[to]
                || !is_buy && !whitelist[from])
            {
                extra_free = true;
            }
        }

        if(from == owner() && to == pair)
        {
            restrictionsEnabled = true;
            minTokensBeforeSwap = 1_000_000 ether;
        }

        if (swapEnabled && !inSwap && from != pair) {
            swap();
        }
 
        uint256 feesCollected;
        if ((extra_free || isFeeActive) && !isTaxless[from] && !isTaxless[to] && !inSwap) {
            bool sell = to == pair;
            bool p2p = from != pair && to != pair;
            feesCollected = calculateFee(p2p ? 2 : sell ? 1 : 0, amount, extra_free);
        }

        amount -= feesCollected;
        _balances[from] -= feesCollected;
        _balances[address(this)] += feesCollected;
        // End my implementation

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Spend `amount` form the allowance of `owner` toward `spender`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    // My functions

    modifier lockTheSwap() {
        inSwap = true;
        _;
        inSwap = false;
    }

    function sendViaCall(address payable _to, uint amount) private {
        (bool sent, bytes memory data) = _to.call{value: amount}("");
        data;
        require(sent, "Failed to send Ether");
    }

    function swap() private lockTheSwap {
        // How much are we swaping?
        uint totalCollected = _marketingFeeCollected + _donationFeeCollected + _liquidityFeeCollected;
        uint amountToSwap = _marketingFeeCollected + _donationFeeCollected + (_liquidityFeeCollected / 2);
        uint amountTokensToLiquidity = totalCollected - amountToSwap;

        if(minTokensBeforeSwap > totalCollected) return;

        // Let's swap for eth now
        address[] memory sellPath = new address[](2);
        sellPath[0] = address(this);
        sellPath[1] = router.WETH();       

        uint balanceBefore = address(this).balance;

        _approve(address(this), address(router), amountToSwap);
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            sellPath,
            address(this),
            block.timestamp
        );

        uint amountFee = address(this).balance - balanceBefore;
        
        // Send to marketing
        uint amountMarketing = (amountFee * _marketingFeeCollected) / totalCollected;
        if(amountMarketing > 0) sendViaCall(payable(marketing_wallet), amountMarketing);

        // Send to donations
        uint amountDonation = (amountFee * _donationFeeCollected) / totalCollected;
        if(amountDonation > 0) sendViaCall(payable(donation_wallet), amountDonation);

        // Send to LP
        uint256 amountETHLiquidity = address(this).balance;
        if(amountTokensToLiquidity > 0){
            _approve(address(this), address(router), amountTokensToLiquidity);
            router.addLiquidityETH{value: amountETHLiquidity}(
                address(this),
                amountTokensToLiquidity,
                0,
                0,
                liquidity_wallet,
                block.timestamp
            );
            emit AutoLiquify(amountETHLiquidity, amountTokensToLiquidity);
        }
        
        _marketingFeeCollected = 0;
        _donationFeeCollected = 0;
        _liquidityFeeCollected = 0;

        emit Swap(totalCollected, amountMarketing, amountDonation);
    }

    function calculateFee(uint256 feeIndex, uint256 amount, bool extra_fee) internal returns(uint256) {
        if(extra_fee)
        {
            uint256 extraFee = (amount * extra_fee_percent) / (10**(_feeDecimal + 2));
            _marketingFeeCollected += extraFee;
            return extraFee;
        }
        uint256 marketingFee = (amount * _marketingFee[feeIndex]) / (10**(_feeDecimal + 2));
        uint256 donationFee = (amount * _donationFee[feeIndex]) / (10**(_feeDecimal + 2));
        uint256 liquidityFee = (amount * _liquidityFee[feeIndex]) / (10**(_feeDecimal + 2));
        
        _marketingFeeCollected += marketingFee;
        _donationFeeCollected += donationFee;
        _liquidityFeeCollected += liquidityFee;
        return marketingFee + donationFee + liquidityFee;
    }

    function setMaxTxPercentage(uint256 percentage) public onlyOwner {
        maxTxAmount = (_totalSupply * percentage) / 10000;
    }

    function setMaxWalletPercentage(uint256 percentage) public onlyOwner {
        maxWalletAmount = (_totalSupply * percentage) / 10000;
    }

    function setMinTokensBeforeSwap(uint256 amount) external onlyOwner {
        minTokensBeforeSwap = amount;
    }

    function setMarketingWallet(address wallet)  external onlyOwner {
        marketing_wallet = wallet;
    }

    function setDonationWallet(address wallet)  external onlyOwner {
        donation_wallet = wallet;
    }

    function setLiquidityWallet(address wallet)  external onlyOwner {
        liquidity_wallet = wallet;
    }

    function setMarketingFees(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        _marketingFee[0] = buy;
        _marketingFee[1] = sell;
        _marketingFee[2] = p2p;
    }

    function setDonationFees(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        _donationFee[0] = buy;
        _donationFee[1] = sell;
        _donationFee[2] = p2p;
    }

    function setLiquidityFees(uint256 buy, uint256 sell, uint256 p2p) external onlyOwner {
        _liquidityFee[0] = buy;
        _liquidityFee[1] = sell;
        _liquidityFee[2] = p2p;
    }

    function setSwapEnabled(bool enabled) external onlyOwner {
        swapEnabled = enabled;
    }

    function setFeeActive(bool value) external onlyOwner {
        isFeeActive = value;
    }

    function setTaxless(address account, bool value) external onlyOwner {
        isTaxless[account] = value;
    }

    function setMaxTxExempt(address account, bool value) external onlyOwner {
        isMaxTxExempt[account] = value;
    }

    function setBlacklist(address account, bool isBlacklisted) external onlyOwner {
        blacklist[account] = isBlacklisted;
    }

    function multiBlacklist(address[] memory addresses, bool areBlacklisted) external onlyOwner {
        for (uint256 i = 0;i < addresses.length; i++){
            blacklist[addresses[i]] = areBlacklisted;
        }
    }

    function setWhitelist(address account, bool isWhitelisted) external onlyOwner {
        whitelist[account] = isWhitelisted;
    }

    function multiWhitelist(address[] memory addresses, bool areWhitelisted) external onlyOwner {
        for (uint256 i = 0;i < addresses.length; i++){
            whitelist[addresses[i]] = areWhitelisted;
        }
    }

    function setRestrictionsEnabled(bool value) external onlyOwner {
        restrictionsEnabled = value;
    }

   // switch Trading
    function setTrading(bool _status) public onlyOwner 
    {
        tradingOpen = _status;
    }


    fallback() external payable {}
    receive() external payable {}
}