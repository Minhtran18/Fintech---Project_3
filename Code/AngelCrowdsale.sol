pragma solidity ^0.5.5;

import "./AngelToken.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract AngelTokenSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
       // @TODO: Fill in the constructor parameter  
       uint rate, // rate in AngelToken Coins
       address payable wallet, // sale beneficiary
       AngelToken coin, // name of the Coin
       uint goal,  //goal for crowdsale
       uint open,
       uint close // uint time Cap
       )
       Crowdsale(rate, wallet, coin)
       CappedCrowdsale(goal)
       TimedCrowdsale(open, close)
       RefundableCrowdsale(goal)
       
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        

        public
    {
        // constructor can stay empty
    }
}

contract AngelTokenSaleDeployer {

    address public coin_sale_address;
    address public coin_address;

    constructor(
       string memory name,
       string memory symbol,
       address payable wallet,
       uint goal
       
        // @TODO: Fill in the constructor parameters!
    )
        public
    {
        // @TODO: create the AngelToken and keep its address handy
        AngelToken coin  = new AngelToken(name, symbol, 0);
        coin_address = address(coin);

        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 12 weeks.
        AngelTokenSale coin_sale = new AngelTokenSale(1, wallet, coin, goal, now, now + 12 weeks);
        coin_sale_address = address(coin_sale);
        
        // make the AngelTokenCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        
        coin.addMinter(coin_sale_address);
        coin.renounceMinter();
    }
}
