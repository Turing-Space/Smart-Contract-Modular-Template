import React, { Component } from "react";

export default class GetETH extends Component {
    constructor(props) {
        super(props);
        this.state = {
            web3: props.web3,
            accounts: props.accounts,
            contract: props.contract,
            uint: "ether"
        }
        this.handleChange = this.handleChange.bind(this);
    }

    // onChange 事件處理函示
    handleChange(event) {
        this.setState({uint: event.target.value});
    }
    
    getETH = async() => {
        const { web3, accounts, contract } = this.state;
        const amount = web3.utils.toWei(this.input.value, this.state.uint);
        
        await contract.methods.getETH(amount).send({from: accounts[0]});
    };

    render() {
        return (
            <div>
                <input type="text" ref={input => this.input = input}/>
                <select value={this.state.uint} onChange={this.handleChange}>
                    <option value="ether">ether</option>
                    <option value="finney">finney</option>
                    <option value="gwei">gwei</option>
                    <option value="wei">wei</option>
                </select>
                <button type="button" onClick= {this.getETH}> 拿錢囉～～ </button>
            </div>
        );
    }
}