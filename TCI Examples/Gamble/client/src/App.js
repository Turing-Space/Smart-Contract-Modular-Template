import React, { Component } from "react";
import SimpleStorageContract from "./contracts/Gamble.json";
import getWeb3 from "./utils/getWeb3";

import DonateToBanker from './components/DonateToBanker.js';
import GetBankerBalance from './components/GetBankerBalance.js';
import GetReturnRate from './components/GetReturnRate.js';
import SetReturnRate from './components/SetReturnRate.js';
import GetETH from './components/GetETH.js';
import PlayGame from './components/PlayGame.js';

import "./App.css";

class App extends Component {
  state = { bankerBalnace: 0, web3: null, accounts: null, contract: null };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = SimpleStorageContract.networks[networkId];
      const instance = new web3.eth.Contract(
        SimpleStorageContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance });
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>有膽！來對賭啊！</h1>

        <DonateToBanker web3={this.state.web3} 
                        accounts={this.state.accounts} 
                        contract={this.state.contract}/>
        <GetBankerBalance contract={this.state.contract}/>
        <GetReturnRate contract={this.state.contract}/>
        <PlayGame web3={this.state.web3} 
                  accounts={this.state.accounts} 
                  contract={this.state.contract}/>
        <h2>以下為～合約擁有者 專屬互動～ </h2>
        <SetReturnRate  accounts={this.state.accounts} 
                        contract={this.state.contract}/>
        <GetETH web3={this.state.web3}
                accounts={this.state.accounts}
                contract={this.state.contract}/>

      </div>
    );
  }
}

export default App;
